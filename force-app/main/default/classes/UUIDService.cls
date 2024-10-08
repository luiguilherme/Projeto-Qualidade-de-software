public with sharing class UUIDService {
    private static final String WEBSERVICE_NAME = 'UserServiceUserProfileCallout';
    private static final String MOBILE_PRE_PAID = 'mobile_prepaid';
    private String uID;
    private String cpf;
    private HttpResponse response;
    
    private UUIDService(){}
    
    public UUIDService (String uUID,String cpf) {
        Webservice__c wsConfig = Webservice__c.getInstance(WEBSERVICE_NAME);
        String endpoint = wsConfig.Endpoint__c + '/' + uUID;
        HttpClient client = new HttpClient();
        this.response = client.get(wsConfig, endpoint);
        this.uID = uUID;
        this.cpf = cpf;

    }
    
    public Boolean uuIDIsValid (){
        if (response.getStatusCode() == 200){
            List<UserProfileWrapper> userProfileReturn = new List<UserProfileWrapper>();
            String validate = this.response.getBody().substring(0, 1);
            if(validate == '{'){
                UserProfileWrapper userProfiletoAdd = (userProfileWrapper)Json.deserialize(this.response.getBody(),userProfileWrapper.class);
                userProfileReturn.add(userProfiletoAdd);
            }else{
                userProfileReturn = (List<userProfileWrapper>)Json.deserialize(this.response.getBody(),List<userProfileWrapper>.class);
            }
            return isValidAuthentication(userProfileReturn,cpf);
    
        } else {
            return false;
        }
          
    }

    public  Boolean isPrepaid (){
        Boolean isPrePaid = false;
        if (this.response.getStatusCode() == 200) {
            List<UserProfileWrapper> userProfileReturn = new List<UserProfileWrapper>();
            String validate = this.response.getBody().substring(0, 1);
            if(validate == '{'){
                UserProfileWrapper userProfiletoAdd = (userProfileWrapper)Json.deserialize(this.response.getBody(),userProfileWrapper.class);
                userProfileReturn.add(userProfiletoAdd);
            }else{
                userProfileReturn = (List<userProfileWrapper>)Json.deserialize(this.response.getBody(),List<userProfileWrapper>.class);
            }
            if(isPhysicalPerson(userProfileReturn)){
                for( Identitie identieI : userProfileReturn[0].identities){
                    if(identieI.services.contains(MOBILE_PRE_PAID)){
                        isPrepaid = true;
                        break;
                    }    
                    
                }
            } else if(isProduct(userProfileReturn)){
                for( Identitie identieI : userProfileReturn[1].identities){
                    if(identieI.services.contains(MOBILE_PRE_PAID)){
                        isPrepaid = true;
                        break;
                    }    
                    
                }
            }    
        }
        return isPrepaid;

    }

  
    private  Boolean isPhysicalPerson(List<UserProfileWrapper> userProfileReturn ){
        return userProfileReturn !=null && userProfileReturn.size() == 1;
    } 
    
    private  Boolean isProduct(List<UserProfileWrapper> userProfileReturn ){
        return userProfileReturn !=null && userProfileReturn.size() > 1;
    } 
    
    public  Boolean isProduct(){
        if (response.getStatusCode() == 200){
        
            List<UserProfileWrapper> userProfileReturn = (List<userProfileWrapper>)Json.deserialize(this.response.getBody(),List<userProfileWrapper>.class);
            return userProfileReturn.size() > 1 ? true : false;
        
        } else {
        
            throw new AuraHandledException('Falha ao consultar Registro');
        }

    }
     
    
    

    
    private  Boolean isValidAuthentication(List<UserProfileWrapper> userProfileReturn,string cpf){
        return cpf.equals(userProfileReturn[0].id_document.value);
    }






    public class UserProfileWrapper{
        String id;
        String name;
        IdDocument id_document;
        List<Identitie> identities;

    }
    public class Identitie{
        String id;
        String type;
        String uuid;
        List<String> services;
        List<String> roles;
    }
    public class IdDocument {
        String value;
        String country;
        String type;
    }
}