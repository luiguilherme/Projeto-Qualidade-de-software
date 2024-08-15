@isTest
public with sharing class CancelledOrdersControllerTest {
    
    
    @IsTest
    static void findCancelledOrdersByFiltersTest() {
        
        Webservice__c ws = new Webservice__c(
            Name = 'RetrieveOrdersListCallout',
            Endpoint__c = 'https://contest.proxy.beeceptor.com/dip/customerOrder/customerOrderManagement/v1/orderList/customer/{accountId}',
            ServiceProvider__c = 'APIGW',
            SubscriptionKey__c = '89098b41c7884a3d8d55741b46389b61',
            Headers__c = 'application/json; charset=utf-8'
        );
        insert ws;

        List<CancelledOrdersController.RetrieveOrdersListFilter> filters = new List<CancelledOrdersController.RetrieveOrdersListFilter>();
        CancelledOrdersController.RetrieveOrdersListFilter filter = new CancelledOrdersController.RetrieveOrdersListFilter();
        filter.serviceId = '12345';
        filter.customerAccountId = '67980';
        filter.status = new List<String>{'CLOSED', 'SUBMITTED'};
        filter.types = new List<String>{'MV'};
        filter.startDate = Date.today().addMonths(-1);
        filter.endDate = Date.today();
        filters.add(filter);
       
        List<Orders> orders = new List<Orders>();

        Test.startTest();       
            Test.setMock(HttpCalloutMock.class, new CancelledOrdersControllerMock());
            orders = CancelledOrdersController.findCancelledOrdersByFilters(filters)[0];
            List<Orders> result = orders;

        Test.stopTest();
        
        System.assertNotEquals(null, result);
        // System.assertEquals('678041636A', result[0].orders.referenceNumber);
        // System.assertEquals('CLOSED', result[0].orders.status);
        // System.assertEquals('12345', result[0].orders.itens[0].serviceId);
        // System.assertEquals('REMOVE_PRODUCT', result[0].orders.itens[0].actionType);
    }

    private class CancelledOrdersControllerErrorMock implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            res.setStatusCode(500);
            return res;
        }
    }

    public class CancelledOrdersControllerMock implements HttpCalloutMock {
        String jsonResponse = '{'+
            '"itemsPerPage": "2",' +
            '"startIndex": "0",' +
            '"totalResults": "2",' +
            '"orders": ['+
                '{'+
                    '"referenceNumber": "678041636A",'+
                    '"creationDate": "1691513971000.00",'+
                    '"serviceRequiredDate": "1691549999000.00",'+
                    '"status": "CLOSED",'+
                    '"customer": {'+
                        '"id": "399070164"'+
                    '},'+
                    '"orderItems": ['+
                        '{'+
                            '"id": "678041686",'+
                            '"actionType": "REMOVE_PRODUCT",'+
                            '"status": "DONE",'+
                            '"product": {'+
                                '"offeringName": "VIVO CONTROLE 10GB PLN I",'+
                                '"name": "Móvel",'+
                                '"serviceId": "12345"'+
                            '},'+
                            '"replaceOfferIndicator": true'+
                        '}'+
                    ']'+
                '},'+
                '{'+
                    '"referenceNumber": "677854986A",'+
                    '"status": "CLOSED",'+
                    '"creationDate": "1691513971000.00",'+
                    '"serviceRequiredDate": "1691549999000.00",'+
                    '"customer": {'+
                        '"id": "399070164"'+
                    '},'+
                    '"orderItems": ['+
                        '{'+
                            '"id": "677855036",'+
                            '"actionType": "ADD_PRODUCT",'+
                            '"status": "DONE",'+
                            '"product": {'+
                                '"serviceId": "12345",'+
                                '"offeringName": "VIVO CONTROLE 10GB PLN I",'+
                                '"name": "Móvel"'+
                            '},'+
                            '"replaceOfferIndicator": true'+
                        '}'+
                    ']'+
                '}'+
            ']'+
        '}';

        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody(this.jsonResponse);
            res.setStatusCode(200);
            return res;
        }
    }
}