public without sharing class UserProfileController {
    private static final String WEBSERVICE_NAME = 'FourthPlataformUserProfileCallout';
    
        @AuraEnabled
        public static String getUserId(Id recordId){
            List<Account> lstAccount = new List<Account>();
            lstAccount = AccountDAO.getAccountUserIdById(CustomerInteractionDAO.getAccountIdById(recordId));
            
            if(lstAccount.isEmpty() || lstAccount[0].UserId__c != null){
                return null;
            } 

            Webservice__c wsConfig = Webservice__c.getInstance(WEBSERVICE_NAME);
    
            if (wsConfig == null) {
                return 'CustomerPlataformaDigitalCallout: Webservice not found.';
            }
    
            String parameters = '?id_document.type=CPF&id_document.value=' + lstAccount[0].DocumentNumber__c ;
            String endpoint = wsConfig.Endpoint__c + parameters;
            List<UserProfileTO> lstUserProfile = new List<UserProfileTO>();
    
            HttpClient client = new HttpClient();
            HttpResponse response = client.get(wsConfig, endpoint);
            ServiceResponse serviceResponse = new ServiceResponse();
    
            if (response.getStatusCode()/100 == 2) {
                String result = response.getBody();
                serviceResponse.body = result;
                serviceResponse.success = true;
            } else {
                serviceResponse.success = false;
            }
            
            if (serviceResponse.success) {
                lstUserProfile = (List<UserProfileTO>)Json.deserialize(serviceResponse.body, List<UserProfileTO>.class);
            }        
            
            if(!lstUserProfile.isEmpty()){
                for(UserProfileTO result : lstUserProfile){
                    lstAccount[0].UserId__c = result.id;
                    break;
                }
            }
            
            update lstAccount;
            return (lstAccount[0] != null && lstAccount[0].UserId__c != null) ? 'true' : 'false';
        }
    }