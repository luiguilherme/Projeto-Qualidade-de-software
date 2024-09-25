@isTest
public class ServiceRequestsHandlerTest {

    @testSetup 
    static void setup() {
        // Configura o Custom Setting com um endpoint fictício para testes
        WebService__c wsSetting = new WebService__c();
        wsSetting.Name = 'CamundaTicketInformation';  // Defina um valor para o campo Name
        wsSetting.Endpoint__c = 'callout:APITelefonicaESim/camundaTicketInformation/v1';
        wsSetting.Timeout__c = 60000; // Valor fictício para o Timeout (Decimal)
        wsSetting.Headers__c = 'Authorization: Bearer token'; // Valor fictício para os Headers
        wsSetting.CommitTransactionsList__c = true; // Defina conforme necessário
         wsSetting.SubscriptionKey__c='re';
        insert wsSetting;

        // Criação do RecordType "HandlingInconsistencies"
        RecordType rt = [SELECT Id FROM RecordType WHERE DeveloperName = 'Tsuru' AND SObjectType = 'ServiceRequest__c' LIMIT 1];

        // Criação de dados de teste no objeto ServiceRequest__c
        ServiceRequest__c sr = new ServiceRequest__c();
        sr.Status__c = 'NotStarted';
        sr.VivoMaestro_ID__c = '123456789';
        sr.OwnerId = UserInfo.getUserId();
        sr.RecordTypeId = rt.Id;
        insert sr;
 
        // Recupera o registro para obter o campo `Name` gerado
        sr = [SELECT Id, Name FROM ServiceRequest__c WHERE Id = :sr.Id LIMIT 1];
        
        // Use o registro para suas necessidades de teste
        System.debug('Record Name: ' + sr.Name);
    }

    @isTest
    static void testServiceRequestHandler() {
        // Adicione o Mock para simular a chamada da API
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
         ServiceRequestsHandler.ServicoDTO servico = new ServiceRequestsHandler.ServicoDTO();
        
        // Definindo valores para os atributos
        servico.motivo = 'Teste de Motivo';
        servico.nrSolicitacaoServico = '123456';
        servico.status = 'Pendente';
        servico.owner = true;
                ServiceRequest__c serviceRequests2 = [SELECT Id, Status__c, Name, VivoMaestro_ID__c, OwnerId FROM ServiceRequest__c WHERE Status__c = 'NotStarted' limit 1];

serviceRequests2.Status__c = 'InProgress';
        update serviceRequests2;
        List<ServiceRequest__c> serviceRequests = [SELECT Id, Status__c, Name, VivoMaestro_ID__c, OwnerId FROM ServiceRequest__c WHERE Status__c = 'InProgress'];

        Test.startTest();
        ServiceRequestsHandler.processServiceRequests(new list<String>{serviceRequests[0].id});
        Test.stopTest();

        // Verificações (assertions)
        // Exemplo: System.assertEquals(expected, actual, 'Mensagem de erro se a condição falhar');
    }

    // Classe de Mock para simular a resposta da API
    private class MockHttpResponseGenerator implements HttpCalloutMock {
        public HttpResponse respond(HttpRequest req) {
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"status": "success"}');
            res.setStatusCode(200);
            return res;
        }
    }
}