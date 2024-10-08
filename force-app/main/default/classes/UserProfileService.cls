public without sharing class UserProfileService {
    private static final String WEBSERVICE_NAME = 'UserServiceUserProfileCallout';
    public static List<UserProfileTO> getUserProfileByAccountId(Id recordId){
        List<Account> listAccount = AccountDAO.getAccountById(recordId);

        Webservice__c wsConfig = Webservice__c.getInstance(WEBSERVICE_NAME);
        String endpoint = wsConfig.Endpoint__c + '?id_document.type=CPF&id_document.value=' + listAccount[0].DocumentNumber__c;
        HttpClient client = new HttpClient();
        HttpResponse response = client.get(wsConfig, endpoint);

        List<UserProfileTO> listUserProfile = (List<UserProfileTO>)Json.deserialize(response.getBody(), List<UserProfileTO>.class);
        return listUserProfile;
    }
}