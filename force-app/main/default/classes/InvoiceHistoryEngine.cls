/*
* @description classe de integração InvoiceHistory 
*/
public with sharing class InvoiceHistoryEngine {
    //private static final String CONST_STRING_WEBSERVICENAME = 'FourthPlataformInvoiceCalloutv1';
    private static final String CONST_STRING_WEBSERVICENAME = 'FourthPlataformInvoiceCallout';

    public static ServiceResponse callIntegration(String userId){
    
        WebService__c webServiceObj = Util.getWebService(CONST_STRING_WEBSERVICENAME);
        GeneralParam__c generalParamObj = GeneralParam__c.getInstance();

        String startDate = String.valueOf(Date.Today().addDays(Integer.valueOf(generalParamObj.SearchRangeInvoice__c)*-1));    
        webServiceObj.Endpoint__c = webServiceObj.Endpoint__c.replace('{user_id}',userId).replace('{start_date}',startDate).replace('{end_date}',String.valueOf(Date.today()));

        HttpClient client = new HttpClient();
        HttpResponse response = client.get(webServiceObj);
        ServiceResponse serviceResponseObj = new ServiceResponse();
        
        if (response.getStatusCode()/100 == 2) {
            String result = response.getBody();
            serviceResponseObj.body = result;
            serviceResponseObj.success = true;
        }else{
            serviceResponseObj.success = false;
        }

        return serviceResponseObj;
    }

    public static List<InvoiceServiceReturn> deserializeInvoiceServiceReturn(ServiceResponse serviceResponseObj){
        return (List<InvoiceServiceReturn>) Json.deserialize(serviceResponseObj.body, List<InvoiceServiceReturn>.class);
    }
}