@isTest
public class RetrieveContractsControllerTest {
    
    public class RetrieveContractsServiceMock implements HttpCalloutMock {

        public String response;
        public Integer statusCode;

        RetrieveContractsServiceMock(String response) {
            this.response = response;
            this.statusCode = 200;
        }

        RetrieveContractsServiceMock(String response, Integer statusCode) {
            this.response = response;
            this.statusCode = statusCode;
        }

        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody(this.response);
            res.setStatusCode(this.statusCode);
            return res;
        }
    }

    @isTest
    public static void givenValidRequestWhenCalloutThenShouldReturnSuccess() {
        String order = '123456789';
        String sourceSystem = 'GEDOC';
        String contractType = '5 - Contrato de Serviços SMP';

        WebService__c ws = new WebService__c(
            Name = 'RetrieveContractsCallout',
            AppKey__c = '36cfd2713668489bb3f7d23d042be3a3',
            SubscriptionKey__c = '89098b41c7884a3d8d55741b46389b61',
            Endpoint__c = 'https://contest.proxy.beeceptor.com/retrieveContracts/v1/contracts',
            Headers__c = 'application/json; charset=utf-8',
            switchedOn__c = true,
            HasAuthToken__c = true,
            Certificate__c = 'SingleSignOn'
        );
        
        insert ws;

        List<RetrieveContractsFacadeFilter> filters = new List<RetrieveContractsFacadeFilter>{
            new RetrieveContractsFacadeFilter(order, sourceSystem, contractType),
            new RetrieveContractsFacadeFilter()
        };

        String httpResponseMock = '{'
                + '"protocol": "74135",'
                + '"order": "64534530420241234508",'
                + '"smpContract": "645345304202412345082",'
                + '"landlineContract": "bbBERi0xKL2YYg==",'
                + '"mobileContract": "ccBERi0xKL3ZZg=="'
            +'}'
        ;

        Test.setMock(HttpCalloutMock.class, new RetrieveContractsServiceMock(httpResponseMock));
        Test.startTest();
        List<RetrieveContractsResponse> responses = RetrieveContractsController.findContractsByParams(filters);
        Test.stopTest();

        System.assertNotEquals(null, responses);
        System.assertEquals('645345304202412345082', responses[0].smpContract);
    }

    @isTest
    public static void givenServiceErrorWhenCalloutThenShouldReturnException() {
        String order = '123456789';
        String sourceSystem = 'GEDOC';
        String contractType = '5 - Contrato de Serviços SMP';

        WebService__c ws = new WebService__c(
            Name = 'RetrieveContractsCallout',
            AppKey__c = '36cfd2713668489bb3f7d23d042be3a3',
            SubscriptionKey__c = '89098b41c7884a3d8d55741b46389b61',
            Endpoint__c = 'https://contest.proxy.beeceptor.com/retrieveContracts/v1/contracts',
            Headers__c = 'application/json; charset=utf-8',
            switchedOn__c = true,
            HasAuthToken__c = true,
            Certificate__c = 'SingleSignOn'
        );
        
        insert ws;

        List<RetrieveContractsFacadeFilter> filters = new List<RetrieveContractsFacadeFilter>{
            new RetrieveContractsFacadeFilter(order, sourceSystem, contractType),
            new RetrieveContractsFacadeFilter()
        };

        String httpResponseMock = 'Error Testing';

        String expectedErrorMessage = 'Endpoint: ' + ws.Endpoint__c;
        expectedErrorMessage += '?order=' + order;
        expectedErrorMessage += '&sourceSystem=' + sourceSystem;
        expectedErrorMessage += '&contractType=' + EncodingUtil.urlEncode(contractType, 'UTF-8.');
        expectedErrorMessage += '\nStatus Code: ' + 500;
        expectedErrorMessage += '\nMensagem: ' + httpResponseMock;

        String exceptionMessage;

        Test.setMock(HttpCalloutMock.class, new RetrieveContractsServiceMock(httpResponseMock, 500));
        Test.startTest();
        try {
            List<RetrieveContractsResponse> responses = RetrieveContractsController.findContractsByParams(filters);
        } catch (Exception e) {
            exceptionMessage = e.getMessage();
        }
        Test.stopTest();

        System.assertEquals(expectedErrorMessage, exceptionMessage);
    }

    @isTest
    public static void givenInalidRequestWhenCalloutErrorThenShouldReturnEmpty() {
        String order = '123456789';
        String sourceSystem = 'GEDOC';
        String contractType = '5 - Contrato de Serviços SMP';

        List<RetrieveContractsFacadeFilter> filters = new List<RetrieveContractsFacadeFilter>{
            new RetrieveContractsFacadeFilter(order, sourceSystem, contractType),
            new RetrieveContractsFacadeFilter()
        };

        String httpResponseMock = '{'
                + '"protocol": "74135",'
                + '"order": "64534530420241234508",'
                + '"smpContract": "645345304202412345082",'
                + '"landlineContract": "bbBERi0xKL2YYg==",'
                + '"mobileContract": "ccBERi0xKL3ZZg=="'
            +'}'
        ;

        String exceptionMessage;

        Test.setMock(HttpCalloutMock.class, new RetrieveContractsServiceMock(httpResponseMock));
        Test.startTest();
        try {
            List<RetrieveContractsResponse> responses = RetrieveContractsController.findContractsByParams(filters);
        } catch (Exception e) {
            exceptionMessage = e.getMessage();
        }
        Test.stopTest();

        System.assertEquals('Não foi encontrado registro de WebService__c: RetrieveContractsCallout', exceptionMessage);
    }
}