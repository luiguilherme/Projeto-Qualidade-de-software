public with sharing class SearchCustomerKeysFacade {

    public static string CONST_STRING_WEBSERVICENAME = 'SearchCustomerKeysCallout';

    public static AccountManagementResponse findByServiceId(String serviceId){

        WebService__c ws = WebService__c.getInstance(CONST_STRING_WEBSERVICENAME);
        ws.Endpoint__c = ws.Endpoint__c + '?serviceId=' + serviceId;
        HttpClient hClient = new HttpClient();
        HttpResponse response = hClient.get(ws);
		AccountManagementResponse result = (AccountManagementResponse)JSON.deserialize(response.getBody(), AccountManagementResponse.class);
		return result;

    }
}