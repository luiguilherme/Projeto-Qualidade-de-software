global class OAMSystemOAuthProvider extends Auth.AuthProviderPluginClass {
    global String getCustomMetadataType() {
        return 'OAMProvider__mdt';
    }
    
	global PageReference initiate(Map<string,string> authProviderConfiguration, String stateToPropagate) {
        system.debug('## method.initiate'); 
		system.debug('## authProviderConfiguration: ' + json.serialize(authProviderConfiguration));
        system.debug('## stateToPropagate: ' + stateToPropagate);
        
    	String url = authProviderConfiguration.get('RedirectURL__c') + '?state='+ stateToPropagate; 
        
        system.debug('## url: ' + url);
        
        return new PageReference(url);    
    }
    
    global Auth.AuthProviderTokenResponse handleCallback(Map<string,string> authProviderConfiguration, Auth.AuthProviderCallbackState callbackState) {
    	system.debug('## method.handleCallback'); 
        system.debug('## authProviderConfiguration: ' + json.serialize(authProviderConfiguration));
        system.debug('## callbackState: ' + json.serialize(callbackState)); 
        
        String tokenUrl = authProviderConfiguration.get('TokenURL__c');
        String scopes = authProviderConfiguration.get('Scopes__c');      
        String headers = authProviderConfiguration.get('Headers__c');
        String systemUser = authProviderConfiguration.get('SystemUser__c');
        String systemPassword = authProviderConfiguration.get('SystemPassword__c');
        String clientId	= authProviderConfiguration.get('ClientId__c'); 
        String clientSecret	= authProviderConfiguration.get('ClientSecret__c');
        
        Blob blobCredentials = Blob.valueOf(clientId + ':' + clientSecret);
        String authorizationHeader = 'BASIC ' + EncodingUtil.base64Encode(blobCredentials);
        
        List<String> headerList = string.isNotBlank(headers) ? headers.split(';') : new List<String>();
          
        Map<String,String> queryParams = callbackState.queryParameters;
        
        String code = queryParams.get('code'); 
        String sfdcState = queryParams.get('state');
        
       	HttpRequest req = new HttpRequest();
        req.setEndpoint(tokenUrl);
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        req.setHeader('Authorization', authorizationHeader);
        
        //Necessário se passar pelo API Gateway
        for (String item : headerList){
            String[] keyValue = item.split(':');
            req.setHeader(keyValue[0], keyValue[1]);
        }
        
		req.setBody('grant_type=password' +
                    '&username=' + systemUser +
                    '&password=' + systemPassword +
                    '&scope=' + scopes);

        system.debug('## Request Body: ' + json.serialize(req.getBody()));
        
        Http http = new Http();
        HTTPResponse res = http.send(req);
        
        system.debug('## StatusCode: ' + json.serialize(res.getStatusCode()));
        system.debug('## Status: ' + json.serialize(res.getStatus()));
        
        String responseBody = res.getBody();        
        
        system.debug('## Response Body: ' + json.serialize(responseBody));
        
        Map<String,String> responseMap = responseBody2Map(responseBody);
        
        String accesstoken = responseMap.get('access_token');
        String refreshtoken = responseMap.get('refresh_token');  
        
        System.debug('## accesstoken = ' + accesstoken);  
        System.debug('## refreshToken = ' + refreshtoken);  
                
        return new Auth.AuthProviderTokenResponse('OAMSystemUser', accesstoken, refreshtoken, sfdcState);
    }
    
    global Auth.UserData getUserInfo(Map<string,string> authProviderConfiguration, Auth.AuthProviderTokenResponse response) {
        
        system.debug('## method.getUserInfo');
        system.debug('## authProviderConfiguration: ' + json.serialize(authProviderConfiguration));
        system.debug('## response: ' + json.serialize(response));   
        
        OAMToken oamToken = decodeToken(response.oauthToken);   
        
        system.debug('## oamToken: ' + json.serialize(oamToken));
        
        Map<String, String> attributeMap = new Map<String,String>();
        
        attributeMap.put('sub', oamToken.sub);
        attributeMap.put('iss', oamToken.iss);
        attributeMap.put('iat', oamToken.iat);
        attributeMap.put('exp', oamToken.exp);
        attributeMap.put('prn', oamToken.prn);
		attributeMap.put('jti', oamToken.jti);
        attributeMap.put('displayname', oamToken.displayname);

        Auth.UserData userData = new Auth.UserData(null,	        		//identifier,
                                                   null,					//firstName,
                                                   null,					//lastName,
                                                   oamToken.displayName,	//fullName,
                                                   null,					//email,
                                                   null, 					//link,
                                                   oamToken.sub,			//userName,
                                                   null,					//locale,
                                                   'OAMSystemUser',			//provider,
                                                   oamToken.iss,			//siteLoginUrl,
                                                   attributeMap);			//attributeMap
        
        system.debug('## userData: ' + json.serialize(userData));
        
		return userData;
    }
    
    // Refresh Token
    public override Auth.OAuthRefreshResult refresh(Map<String,String> authProviderConfiguration, String refreshToken) {
        
        System.debug('## method.refresh');
        System.debug('## authProviderConfiguration: ' + authProviderConfiguration);
        System.debug('## refreshToken: ' + refreshToken);
        
        OAMToken oamRefreshToken = decodeToken(refreshtoken);   
        
        system.debug('## oamRefreshToken: ' + json.serialize(oamRefreshToken));
        
        String tokenUrl = authProviderConfiguration.get('TokenURL__c');
        String refreshUrl = authProviderConfiguration.get('Refresh_URL__c');
        String scopes = authProviderConfiguration.get('Scopes__c');    
        String headers = authProviderConfiguration.get('Headers__c');
        String systemUser = authProviderConfiguration.get('SystemUser__c');
        String systemPassword = authProviderConfiguration.get('SystemPassword__c');
        String clientId = authProviderConfiguration.get('ClientId__c'); 
        String clientSecret = authProviderConfiguration.get('ClientSecret__c');
        
        Blob blobCredentials		= Blob.valueOf(clientId + ':' + clientSecret);
        String authorizationHeader	= 'BASIC ' + EncodingUtil.base64Encode(blobCredentials);
        
        List<String> headerList = string.isNotBlank(headers) ? headers.split(';') : new List<String>();
        
        HttpRequest req = new HttpRequest();
        
        req.setMethod('POST');
        req.setHeader('Content-Type',	'application/x-www-form-urlencoded');
        req.setHeader('Authorization', authorizationHeader);
        
        //Necessário se passar pelo API Gateway
        for (String item : headerList){
            String[] keyValue = item.split(':');
            req.setHeader(keyValue[0], keyValue[1]);
        }
        
        if(Long.valueOf(oamRefreshToken.exp) < Datetime.now().getTime()) {
        	req.setEndpoint(tokenUrl);
            
            req.setBody('grant_type=password' +
                    '&username=' + systemUser +
                    '&password=' + systemPassword +
                    '&scope=' + scopes);
        }
        else {
            req.setEndpoint(refreshUrl);
            
            req.setBody('grant_type=refresh_token'  +
                    '&refresh_token=' + refreshToken +
                    '&scope=' + scopes
                   );
        }		
        
        System.debug('##Request Body: ' + req.getBody());
        
        Http http = new Http();
        HTTPResponse res = http.send(req);
        
        system.debug('## StatusCode: ' + json.serialize(res.getStatusCode()));
        system.debug('## Status: ' + json.serialize(res.getStatus()));
        
        String responseBody = res.getBody();
        
        system.debug('## Response Body: ' + json.serialize(responseBody));

        Map<String,String> responseMap = responseBody2Map(responseBody);
        
        String newAccessToken 	= responseMap.get('access_token');
        String newRefreshToken  = responseMap.get('refresh_token');  

        System.debug('## newAccessToken: ' + newAccessToken);
        System.debug('## newRefreshToken: ' + newRefreshToken); 

        return new Auth.OAuthRefreshResult(newAccessToken, newRefreshToken);
    }
    
    private Map<String,String> responseBody2Map(String responseBody) {
        Map<String,String> responseMap = (Map<String,String>)JSON.deserialize(responseBody, Map<String,String>.class);
        
        return responseMap;
    }
    
    private OAMToken decodeToken(String idToken){
        String[] idparts = idToken.split('\\.');
        String header64	= idparts[0];
        String payload64 = idparts[1];
        String signature64 = idparts[2];

        Blob decodedPayload = EncodingUtil.base64Decode(payload64);
        String jsonpayload = decodedPayload.toString();
        
        JSONParser parser = JSON.createParser(jsonpayload);
        OAMToken oamToken = (OAMToken)parser.readValueAs(OAMToken.class);
        
        return oamToken;
    }
    
    public class OAMToken {
        public String sub;					
        public String iss;					
        public String iat;					
        public String exp;					
        public String prn;						
        public String jti;
        public String displayname;
    }
}