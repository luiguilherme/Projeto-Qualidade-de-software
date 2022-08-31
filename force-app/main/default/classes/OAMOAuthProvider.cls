global class OAMOAuthProvider extends Auth.AuthProviderPluginClass {

    @TestVisible
	private String id_token;
    
    global PageReference initiate(Map<string,string> authProviderConfiguration, String stateToPropagate) {
        
        system.debug('authProviderConfiguration: ' + json.serialize(authProviderConfiguration));
        
       	String authUrl		= authProviderConfiguration.get('AuthorizeURL__c'); 
        String clientId 	= authProviderConfiguration.get('ClientId__c');
        String redirectUrl 	= authProviderConfiguration.get('RedirectURL__c');
        String scopes 		= authProviderConfiguration.get('Scopes__c');

        String url = authUrl + '?client_id=' + clientId +
            '&response_type=code' 	+
            '&scope=' 				+ scopes +
            '&state=' 				+ stateToPropagate + 
            '&redirect_uri=' 		+ redirectUrl;
        
        system.debug('url: ' + url);
        
        return new PageReference(url); 
    }
    
    global Auth.AuthProviderTokenResponse handleCallback(Map<string,string> authProviderConfiguration, Auth.AuthProviderCallbackState state) {
        
        String tokenUrl 	= authProviderConfiguration.get('TokenURL__c');
        String redirectUrl 	= authProviderConfiguration.get('RedirectURL__c');
        //String redirectUrl 	= authProviderConfiguration.get('RedirectCommunityURL__c');
        String scopes 		= authProviderConfiguration.get('Scopes__c');      
        String clientId				= authProviderConfiguration.get('ClientId__c'); 
        String clientSecret 		= authProviderConfiguration.get('ClientSecret__c');
        Blob blobCredentials		= Blob.valueOf(clientId + ':' + clientSecret);
        String authorizationHeader	= 'BASIC ' + EncodingUtil.base64Encode(blobCredentials);
        
        String headers 		= authProviderConfiguration.get('Headers__c');
        String[] headerList = headers.split(';');
                                                             
        Map<String,String> queryParams = state.queryParameters;
        String code 		= queryParams.get('code'); 
        String sfdcState	= queryParams.get('state');
        
        HttpRequest req = new HttpRequest();
        req.setEndpoint(tokenUrl);
        req.setMethod('POST');
        req.setHeader('Content-Type',	'application/x-www-form-urlencoded');
        req.setHeader('Authorization', authorizationHeader);
        
        //Necessário se passar pelo API Gateway
        for (String item : headerList){
            String[] keyValue = item.split(':');
            req.setHeader(keyValue[0], keyValue[1]);
        }
        
		req.setBody('grant_type=authorization_code' +
                    '&code='		+ code +
                    //'&scope=' 		+ scopes +
                   	'&redirect_uri='+ redirectUrl);

        system.debug('req: ' + req);
        system.debug('req body: ' + req.getBody());
        Http http = new Http();
        HTTPResponse res = http.send(req);
        String responseBody = res.getBody();
        system.debug('Response: ' + responseBody);
        Map<String,String> responseMap = responseBody2Map(responseBody);
        id_token 			= responseMap.get('id_token');
        String accesstoken 	= responseMap.get('access_token');
        String refreshtoken = responseMap.get('refresh_token');  
        System.debug('##accesstoken = ' + accesstoken);  
        System.debug('##refreshToken = ' + refreshtoken);  
        return new Auth.AuthProviderTokenResponse('OAM Custom', accesstoken, refreshtoken, sfdcState);

    }
    
    global Auth.UserData getUserInfo(Map<string,string> authProviderConfiguration, Auth.AuthProviderTokenResponse response) {
        
        OAMIdToken oamIdToken = decodeidtoken(id_token);        
        Map<String, String> attributeMap = new Map<String,String>();
        attributeMap.put('aud', 			oamIdToken.aud);
        attributeMap.put('iat', 			oamIdToken.iat);
        attributeMap.put('exp', 			oamIdToken.exp);
        attributeMap.put('network_id', 		oamIdToken.network_id);
		attributeMap.put('employee_number', oamIdToken.employee_number);
        attributeMap.put('phone_number', 	oamIdToken.phone_number); 
        attributeMap.put('profile_name', 	oamIdToken.profile_name);
        attributeMap.put('CNPJ',            oamIdToken.CNPJ);
        attributeMap.put('active', 			oamIdToken.active);
        attributeMap.put('role', 			oamIdToken.role);
        attributeMap.put('sub', 			oamIdToken.sub);
        attributeMap.put('adabas', 			oamIdToken.adabas);

        if (oamIdToken.permission_sets != null && !oamIdToken.permission_sets.isEmpty()){
       	attributeMap.put('permission_sets', 	JSON.serialize(oamIdToken.permission_sets));
        }
        
        Auth.UserData userData = new Auth.UserData(oamIdToken.sub,	                //identifier,
                                                   oamIdToken.given_name,			//firstName,
                                                   oamIdToken.family_name,			//lastName,
                                                   oamIdToken.given_name + ' ' + oamIdToken.family_name,//fullName,
                                                   oamIdToken.email,				//email,
                                                   null, 							//link,
                                                   oamIdToken.sub,                  //userName,
                                                   null,							//locale,
                                                   'OAM Custom',					//provider,
                                                   oamIdToken.iss,					//siteLoginUrl,
                                                   attributeMap);					//attributeMap
        
		return userData;
	}
    
    //setup
    global String getCustomMetadataType() {
        return 'OAMProvider__mdt';
    }
 
    private Map<String,String> responseBody2Map(String responseBody) {
        Map<String,String> responseMap = (Map<String,String>)JSON.deserialize(responseBody, Map<String,String>.class);
        
        return responseMap;
    }
    
    public OAMIdToken decodeidtoken(String id_token){
        String[] idparts = id_token.split('\\.');
        String header64		= idparts[0];
        String payload64	= idparts[1];
        String signature64	= idparts[2];

        Blob decodedPayload = EncodingUtil.base64Decode(payload64);
        String jsonpayload = decodedPayload.toString();
        
        JSONParser parser = JSON.createParser(jsonpayload);
        OAMIdToken oamIdToken = (OAMIdToken)parser.readValueAs(OAMIdToken.class);
        return oamIdToken;
    }
    
    public class OAMIdToken {
        public String iss;					
        public String aud;					
        public String iat;					
        public String exp;					
        public String sub;						
        public String email;
        public String adabas;				
        public String network_id;			
        public String employee_number;		
        public String given_name;			
        public String family_name;			
        public String phone_number;		
        public String profile_name;
        public String CNPJ;			
        public String active;			
        public String role;
        public List<String> permission_sets;
    }
    
    // Refresh Token
    public override Auth.OAuthRefreshResult refresh(Map<String,String> authProviderConfiguration, String refreshToken) {
        
        System.debug('##authProviderConfiguration==' + authProviderConfiguration);
        System.debug('##refreshToken==' + refreshToken);
        
        String tokenUrl 	        = authProviderConfiguration.get('TokenURL__c');
        String scopes 		        = authProviderConfiguration.get('Scopes__c');      
        String clientId				= authProviderConfiguration.get('ClientId__c'); 
        String clientSecret 		= authProviderConfiguration.get('ClientSecret__c');
        Blob blobCredentials		= Blob.valueOf(clientId + ':' + clientSecret);
        String authorizationHeader	= 'BASIC ' + EncodingUtil.base64Encode(blobCredentials);
        
        String headers 		= authProviderConfiguration.get('Headers__c');
        String[] headerList = headers.split(';');
                                                             
        HttpRequest req = new HttpRequest();
        req.setEndpoint(tokenUrl);
        req.setMethod('POST');
        req.setHeader('Content-Type',	'application/x-www-form-urlencoded');
        req.setHeader('Authorization', authorizationHeader);
        
        //Necessário se passar pelo API Gateway
        for (String item : headerList){
            String[] keyValue = item.split(':');
            req.setHeader(keyValue[0], keyValue[1]);
        }
        
		req.setBody('grant_type=refresh_token'  +
                    '&refresh_token='		    + refreshToken +
                    '&scope=' 		            + scopes );
        
        Http http = new Http();
        HTTPResponse res = http.send(req);
        String responseBody = res.getBody();

        Map<String,String> responseMap = responseBody2Map(responseBody);
        String newAccessToken 	= responseMap.get('access_token');
        String newRefreshToken  = responseMap.get('refresh_token');  

        System.debug('##refresh==' + 'req=' + req.toString() + '=body=' + req.getBody() + '=res=' + res.toString() + '=body=' + res.getBody());
        System.debug('##newRefreshToken=' + newRefreshToken);

        return new Auth.OAuthRefreshResult(newAccessToken, newRefreshToken);
    }
}