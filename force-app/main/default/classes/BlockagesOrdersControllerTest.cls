@isTest
public class BlockagesOrdersControllerTest {

    @isTest 
    static void testFindBlockagesOrdersByFilters() {
        // Criação de um Webservice de teste
        Webservice__c ws = new Webservice__c(
            Name = 'RetrieveOrdersListCallout',
            Endpoint__c = 'https://contest.proxy.beeceptor.com/dip/customerOrder/customerOrderManagement/v1/orderList/customer/{accountId}',
            ServiceProvider__c = 'APIGW',
            SubscriptionKey__c = '89098b41c7884a3d8d55741b46389b61',
            Headers__c = 'application/json; charset=utf-8'
        );
        insert ws;

        // Configuração dos filtros de teste
        List<BlockagesOrdersController.RetrieveOrdersListFilter> filters = new List<BlockagesOrdersController.RetrieveOrdersListFilter>();
        BlockagesOrdersController.RetrieveOrdersListFilter filter = new BlockagesOrdersController.RetrieveOrdersListFilter();
        filter.serviceId = '12345';
        filter.customerAccountId = '399070164';
        filter.status = new List<String>{ 'CLOSED' };
        filter.types = new List<String>{ 'FS', 'SU', 'SC', 'SR', 'LS', 'SL' };
        filter.startDate = Date.today().addDays(-30);
        filter.endDate = Date.today();
        filters.add(filter);

        // Execução do teste com mock de HTTP Callout
        Test.startTest();
            Test.setMock(HttpCalloutMock.class, new OrderManagementServiceMock());
            List<list<Orders>> responses = BlockagesOrdersController.findBlockagesOrdersByFilters(filters);
        Test.stopTest();

        // Verificações do resultado
        System.assertNotEquals(null, responses, 'A resposta não deveria ser nula');
        //System.assertEquals(2, responses.size(), 'Deveria retornar dois pedidos');
        for(List<Orders> reponseList : responses){
        for (Orders response : reponseList) {
            System.assertEquals('CLOSED', response.status, 'O status deveria ser CLOSED');
            for (OrderItemList item : response.itens) {
                System.assertEquals('12345', item.serviceId, 'O serviceId deveria ser 12345');
                //System.assertNotEquals(null, item.implOrderTypeX9, 'implOrderTypeX9 não deveria ser nulo');
                //System.assert(item.implOrderTypeX9 != null, 'implOrderTypeX9 não deveria ser nulo');
                System.assertEquals('FS',item.implOrderTypeX9, 'implOrderTypeX9 não deveria ser nulo');
                system.System.debug('Meyteste '+ item.implOrderTypeX9);
            }
        }
    }
    }
    // Mock de resposta de erro do serviço
    private class OrderManagementServiceErrorMock implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            res.setStatusCode(500);
            return res;
        }
    }

    // Mock de resposta de sucesso do serviço
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
            				'"implOrderTypeX9": "FS",'+
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
            				'"implOrderTypeX9": "FS",'+
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