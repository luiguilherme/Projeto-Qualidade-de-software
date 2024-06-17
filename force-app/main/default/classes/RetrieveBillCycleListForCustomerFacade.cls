public with sharing class RetrieveBillCycleListForCustomerFacade {
    public static string CONST_STRING_WEBSERVICENAME = 'CustomerBillingCycleCallout';

    public static RetrieveBillCycleListForCustomerResponse findByFilters(String accountId, Boolean triggeredByCustomer, Datetime startDate, Datetime endDate){
        System.debug('accountId: ' + accountId);
        WebService__c ws = WebService__c.getInstance('CustomerBillingCycleCallout');
        String endPoint = ws.Endpoint__c;
        endPoint = endPoint.replace('{customerID}', accountId);
        endPoint += '?triggeredByCustomer='+triggeredByCustomer+'&fromCloseDate='+String.valueOf(Date.valueOf(startDate))+'&toCloseDate='+String.valueOf(Date.valueOf(endDate));
        
        HttpClient hClient = new HttpClient();
        HttpResponse response = hClient.get(ws, endPoint);

        RetrieveBillCycleListForCustomerResponse result = (RetrieveBillCycleListForCustomerResponse)JSON.deserialize(response.getBody(), RetrieveBillCycleListForCustomerResponse.class);

        return result;
    }
}