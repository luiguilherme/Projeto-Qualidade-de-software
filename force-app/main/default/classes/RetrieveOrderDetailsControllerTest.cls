@isTest
public with sharing class RetrieveOrderDetailsControllerTest {

    @isTest 
    static void testFindByAccountIdAndOrderNumberIN() {

        WebService__c ws = new WebService__c(
            Name = 'RetrieveOrderDetailsCallout',
            Endpoint__c = 'https://contest.proxy.beeceptor.com/dip/customerOrder/customerOrderManagement/v1/orderDetails/customer/{accountId}/order/{orderNumber}?location=pt_BR&salesChannel=SS&systemId=AMDOCS',
            ServiceProvider__c = 'APIGW',
            Headers__c = 'application/json; charset=utf-8',
            switchedOn__c = true,
            HasAuthToken__c = true,
            Certificate__c = 'SingleSignOn'
        );
        insert ws;

        RetrieveOrderDetailsController.RetrieveOrdersDetailsFilter filter = new RetrieveOrderDetailsController.RetrieveOrdersDetailsFilter();   
        filter.accountId = '123';
        filter.orderNumber = '123';

        List<RetrieveOrderDetailsController.RetrieveOrdersDetailsFilter> filters = new List<RetrieveOrderDetailsController.RetrieveOrdersDetailsFilter>();
        filters.add(filter);

        Test.startTest();
            Test.setMock(HttpCalloutMock.class, new RetrieveOrderDetailsServiceMock()); 
            List<OrderItemDetails> result = RetrieveOrderDetailsController.findByAccountIdAndOrderNumberIN(filters);  
        Test.stopTest();
        
    }

    @isTest 
    static void testFindByAccountIdAndOrderNumber() {

        WebService__c ws = new WebService__c(
            Name = 'RetrieveOrderDetailsCallout',
            Endpoint__c = 'https://contest.proxy.beeceptor.com/dip/customerOrder/customerOrderManagement/v1/orderDetails/customer/{accountId}/order/{orderNumber}?location=pt_BR&salesChannel=SS&systemId=AMDOCS',
            ServiceProvider__c = 'APIGW',
            Headers__c = 'application/json; charset=utf-8',
            switchedOn__c = true,
            HasAuthToken__c = true,
            Certificate__c = 'SingleSignOn'
        );
        insert ws;

        String accountId = '123';
        String orderNumber = '123';

        Test.startTest();
            Test.setMock(HttpCalloutMock.class, new RetrieveOrderDetailsServiceMock()); 
            List<OrderItemDetails> result = RetrieveOrderDetailsController.findByAccountIdAndOrderNumber(accountId, orderNumber);  
        Test.stopTest();
        
    }

    private class RetrieveOrderDetailsErrorMock implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            res.setStatusCode(500);
            return res;
        }
    }

    public class RetrieveOrderDetailsServiceMock implements HttpCalloutMock {

        String jsonResponse = '{'+
            '"orderItems": ['+
                '{'+
                    '"voiceLineMsisdn": "123",'+
                    '"productName": "123",'+
                    '"plan": {'+
                        '"catalogItemName": "123"'+
                    '},'+
                    '"serviceRequiredDate": 123,'+
                    '"oacloseDate": 123,'+
                    '"implActionTypeX9": "ADD_PRODUCT",'+
                    '"services": ['+
                        '{'+
                            '"serviceId": "123",'+
                            '"pricePackages": ['+
                                '{'+
                                '}'+
                            ']'+
                        '}'+
                    ']'+
                '}'+
            ']}';

        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody(this.jsonResponse);
            res.setStatusCode(200);
            return res;
        }
    }
}