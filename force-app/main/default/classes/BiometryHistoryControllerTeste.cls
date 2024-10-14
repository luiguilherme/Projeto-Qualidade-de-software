@isTest
private class BiometryHistoryControllerTeste {

    @isTest
    static void testFindBiometryHistoryByParams() {
        Webservice__c ws = new Webservice__c(
            Name = 'BiometryHistoryCallout',
            Endpoint__c = 'https://contest.proxy.beeceptor.com/dip/digitalIdentityManagement/v1/biometryHistory?biometryDate={biometryDate}&documentNumber={docNumber}&orderId={orderId}',
            ServiceProvider__c = 'APIGW',
            // SubscriptionKey__c = '89098b41c7884a3d8d55741b46389b61',
            Headers__c = 'application/json; charset=utf-8',
            switchedOn__c = true
        );
        insert ws;

        List<BiometryHistoryController.RetrieveBiometryHistoryFilter> filters = new List<BiometryHistoryController.RetrieveBiometryHistoryFilter>();
        BiometryHistoryController.RetrieveBiometryHistoryFilter filter = new BiometryHistoryController.RetrieveBiometryHistoryFilter();
        filter.biometryDate = System.today();
        filter.documentNumber = '12345';
        filter.orderId = '123';
        filters.add(filter);

        Test.startTest();
            Test.setMock(HttpCalloutMock.class, new BiometryHistoryServiceMock());
            List<String> result = BiometryHistoryController.findBiometryHistoryByParams(filters);
        Test.stopTest();

        System.assertNotEquals(null, result); 
    }

    private class BiometryHistoryServiceErrorMock implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            res.setStatusCode(500);
            return res;
        }
    }

    public class BiometryHistoryServiceMock implements HttpCalloutMock {
        String jsonResponse = '{'+
            '"businessInteraction": {'+
                '"status": "01-sucesso",'+
                '"resultCode": "200",'+
                '"resultMessage": "Biometria encontrada"'+
            '},'+
            '"items": ['+
                '{'+
                    '"nationalIdentityCardIdentification": {'+
                        '"cardNr": "82663707295"'+
                    '},'+
                    '"protocol": {'+
                        '"id": "70209"'+
                    '},'+
                    '"timePeriod": {'+
                        '"biometryDateTime": "02/01/2024 11:20:12"'+
                    '},'+
                    ' "adabasId": "DGT-MEUVIVO",'+
                    '"channel": {'+
                        '"id": "Meu Vivo"'+
                    '},'+
                    '"motorStatus": "APROVADO"'+
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