@isTest
public with sharing class OrderManagementControllerTeste {

    
    @isTest 
    static void testFindReplaceOfferOrderByParams() {

        Webservice__c ws = new Webservice__c(
            Name = 'RetrieveOrdersListCallout',
            Endpoint__c = 'https://contest.proxy.beeceptor.com/dip/customerOrder/customerOrderManagement/v1/orderList/customer/{accountId}',
            ServiceProvider__c = 'APIGW',
            SubscriptionKey__c = '89098b41c7884a3d8d55741b46389b61',
            Headers__c = 'application/json; charset=utf-8'
        );
        insert ws;

        List<OrderManagementController.RetrieveOrdersListFilter> filters = new List<OrderManagementController.RetrieveOrdersListFilter>();
        OrderManagementController.RetrieveOrdersListFilter filter = new OrderManagementController.RetrieveOrdersListFilter();
        filter.serviceId = '12345';
        filter.customerAccountId = '67890';
        filter.status = new List<String>{'Open', 'InProgress'};
        filter.types = new List<String>{'TypeA', 'TypeB'};
        filter.startDate = Date.today().addDays(-30);
        filter.endDate = Date.today();
        filters.add(filter);

        Test.startTest();
            Test.setMock(HttpCalloutMock.class, new OrderManagementServiceMock());
            List<RetrieveOrdersListResponse.Orders> result = OrderManagementController.findReplaceOfferOrderByParams(filters);
        Test.stopTest();

        System.assertEquals(2, result.size(), 'Deveria retornar dois pedidos');
        for (RetrieveOrdersListResponse.Orders order : result) {
            for (RetrieveOrdersListResponse.OrderItems item : order.orderItems) {
                System.assertEquals('12345', item.product.serviceId, 'ServiceId deveria ser 12345');
                System.assert(item.replaceOfferIndicator, 'replaceOfferIndicator deveria ser true');
            }
        }
    }

    private class OrderManagementServiceErrorMock implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            res.setStatusCode(500);
            return res;
        }
    }

    public class OrderManagementServiceMock implements HttpCalloutMock {
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