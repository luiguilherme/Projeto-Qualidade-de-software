/*
* @author Diego Costa @ Deloitte
* @date 06/06/2022
* @description classe OAuthEndUserRequestConfigurator 
*/
public class OAuthEndUserRequestConfigurator implements IHttpRequestConfigurator {
    private IHttpRequestConfigurator destinationConfigurator;

    public OAuthEndUserRequestConfigurator(){
        destinationConfigurator = new QuartaPlataformaRequestConfigurator();
    }

    public OAuthEndUserRequestConfigurator(IHttpRequestConfigurator destinationConfigurator){

        this.destinationConfigurator = destinationConfigurator;
    }

    public HttpRequest configure(HttpRequest request, Webservice__c wsConfig){
        request = destinationConfigurator.configure(request, wsConfig);
        
        if(!Test.isRunningtest()){
            if (!wsConfig.ServiceAccountUser__c) {
                String accesstoken = getAccessToken();
                request.setHeader('Authorization', 'Bearer ' + accesstoken);
                if(wsConfig.HasJwt__c  == true){
                    request.setHeader('jwt', accesstoken);
                } else if(wsConfig.HasAuthToken__c == true){
                    request.setHeader('authToken', accesstoken);
                }
                if(wsConfig.HasAuthToken__c == true){
                    request.setHeader('authToken', accesstoken);
                }
            }
        } else {
            request.setHeader('Authorization', 'Bearer testBearer');
        }
        
        return request;
    } 

    public class OAMAccessToken {
        public String sub;
        public String exp;
        public String displayname;
        public String profile_name;
    }

    public String getAccessToken(){

        AuthProvider provider = [SELECT Id FROM AuthProvider WHERE DeveloperName = 'oam'];
        
        String authProviderId = provider.Id;
        String providerName = 'oam custom';

        String accesstoken = Auth.AuthToken.getAccessToken(authProviderId, providerName);

        // Verifica validade do token
        OAMAccessToken oamAccessToken = decodeAccessToken(accessToken);

        DateTime tokenValidity;
        GeneralParam__c generalParam = GeneralParam__c.getInstance();

        if(Test.isRunningtest() || (generalParam != null && generalParam.OrgTest__c)){
            tokenValidity = System.now().addDays(2);
        } else {

            if(oamAccessToken.exp == null){
                throw new AuraHandledException('Necessário fazer login via OAM para consultar as integrações');
            }

            String epochDatetime = oamAccessToken.exp + '000';
            tokenValidity = DateTime.newInstance(long.valueOf(epochDatetime));
        }
        
        //GeneralParam__c generalParam = GeneralParam__c.getInstance();
        DateTime nowValidity = (generalParam.TokenExpirationDiscount__c != null ? 
                                    System.now().addMinutes(Integer.valueOf(generalParam.TokenExpirationDiscount__c)) : System.now());

        if(nowValidity < tokenValidity){
            return accessToken;
        }

       // Refresh do token
        Map<String,String> responseMap = Auth.AuthToken.refreshAccessToken(authProviderId, providerName, accesstoken);

        return responseMap.get('AccessToken');
    }

    public OAMAccessToken decodeAccessToken(String accessToken){
        if(String.IsBlank(accessToken) || accessToken == null){
            return new OAMAccessToken();
        }

        String[] idparts    = accessToken.split('\\.');
        String header64		= idparts[0];
        String payload64	= idparts[1];
        String signature64	= idparts[2];

        Blob decodedPayload = EncodingUtil.base64Decode(payload64);
        String jsonpayload = decodedPayload.toString();
        
        JSONParser parser = JSON.createParser(jsonpayload);
        OAMAccessToken oamAccessToken = (OAMAccessToken) parser.readValueAs(OAMAccessToken.class);

        return oamAccessToken;
    }
}