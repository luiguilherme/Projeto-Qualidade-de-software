@isTest
private class NewProductHighOrdersDetailsControlTeste {

    @isTest 
    static void testFindNewProductHighOrdersDetailsByFilters() {
        Webservice__c ws = new Webservice__c(
            Name = 'RetrieveOrderDetailsCallout',
            Endpoint__c = 'https://contest.proxy.beeceptor.com/dip/customerOrder/customerOrderManagement/v1/orderDetails/customer/{accountId}/order/{orderNumber}?location=pt_BR&salesChannel=SS&systemId=AMDOCS',
            ServiceProvider__c = 'APIGW',
            // SubscriptionKey__c = '89098b41c7884a3d8d55741b46389b61',
            Headers__c = 'application/json; charset=utf-8',
            switchedOn__c = true
        );
        insert ws;

        String ordersListJson = '['+
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
        ']';

        List<NewProductHighOrdersDetailsController.RetrieveOrdersDetailsListFilter> filters = new List<NewProductHighOrdersDetailsController.RetrieveOrdersDetailsListFilter>();
        NewProductHighOrdersDetailsController.RetrieveOrdersDetailsListFilter filter = new NewProductHighOrdersDetailsController.RetrieveOrdersDetailsListFilter();
        filter.customerAccountId = '67890';
        filter.orderNumber = '12345';
        filters.add(filter);

        Test.startTest();
            Test.setMock(HttpCalloutMock.class, new OrderManagementServiceMock());
            List<NewProductHighOrdersDetailsController.NewProductHighOrdersDetailsResponse> result = NewProductHighOrdersDetailsController.findNewProductHighOrdersDetailsByFilters(filters);
        Test.stopTest();

        System.assertNotEquals(null, result);
    }

    private class OrderManagementServiceErrorMock implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            res.setStatusCode(500);
            return res;
        }
    }

    public class OrderManagementServiceMock implements HttpCalloutMock {
        // String jsonResponse = '{' +
        //     '"serviceId": "12345",' +
        //     '"itemName": "TV",' +
        //     '"plan": "plan",' +
        //     '"action": "Adicionar",' +
        //     '"creationDate": "2024-07-18T12:34:56.000Z",' +
        //     '"closedDate": "2024-07-19T12:34:56.000Z",' +
        //     '"implActionTypeX9": "PR",' +
        //     '"children": [' +
        //         '{' +
        //             '"serviceId": "12347",' +
        //             '"itemName": "Banda Larga",' +
        //             '"plan": "plan",' +
        //             '"action": "Test",' +
        //             '"creationDate": "2024-07-18T12:34:56.000Z",' +
        //             '"closedDate": "2024-07-19T12:34:56.000Z",' +
        //             '"implActionTypeX9": "PR",' +
        //             '"children": []' +
        //         '}' +
        //     ']' +
        // '}';

            String jsonResponse = '{'+
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