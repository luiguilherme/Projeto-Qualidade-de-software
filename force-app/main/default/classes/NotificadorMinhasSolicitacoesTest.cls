@isTest
public class NotificadorMinhasSolicitacoesTest {

    public static List<CanalNotificacoesMinhasSolicitacoes__mdt> obterCanaisNotificacao() {
        List<CanalNotificacoesMinhasSolicitacoes__mdt> canaisConfig = new List<CanalNotificacoesMinhasSolicitacoes__mdt>{
            new CanalNotificacoesMinhasSolicitacoes__mdt(
                MasterLabel = 'Aguardando informação',
                DeveloperName = 'AguardandoInformacao',
                CallOut__c = true,
                PushSMS__c = true,
                FuncionalidadeControlada__c = 'AtualizacaoStatusCaso'
            ),
            new CanalNotificacoesMinhasSolicitacoes__mdt(
                MasterLabel = 'Closed',
                DeveloperName = 'Closed',
                CallOut__c = true,
                PushSMS__c = true,
                FuncionalidadeControlada__c = 'AtualizacaoStatusCaso'
            ),
            new CanalNotificacoesMinhasSolicitacoes__mdt(
                MasterLabel = 'New',
                DeveloperName = 'New',
                CallOut__c = false,
                PushSMS__c = false,
                FuncionalidadeControlada__c = 'AtualizacaoStatusCaso'
            ),
            new CanalNotificacoesMinhasSolicitacoes__mdt(
                MasterLabel = 'Expirado',
                DeveloperName = 'Expirado',
                CallOut__c = false,
                PushSMS__c = true,
                FuncionalidadeControlada__c = 'AtualizacaoStatusCaso'
            ),
            new CanalNotificacoesMinhasSolicitacoes__mdt(
                MasterLabel = 'Notificar Cliente',
                DeveloperName = 'NotificarCliente',
                CallOut__c = true,
                PushSMS__c = true,
                FuncionalidadeControlada__c = 'BotaoNotificarCliente'
            )
        };
        return canaisConfig;
    }

    @testSetup
    static void setupTestData() {

        // Create Webservice Records
        insert new Webservice__c(
            Name = 'UserServiceUserProfileCallout',
            Endpoint__c  = 'https://api-hml.telefonica.com.br/userprofile/v4/',
            SubscriptionKey__c = 'd1ca8d57a2984db88f01c9ce7b5862e2',
            User__c ='UserMock',
            LogServiceTransaction__c = false,
            AsyncLogServiceTransaction__c = false
        );

        insert new Webservice__c(
            Name = 'KafkaEvents',
            Endpoint__c  = 'https://api-hml.telefonica.com.br/userprofile/v4/',
            SubscriptionKey__c = 'd1ca8d57a2984db88f01c9ce7b5862e2',
            User__c ='UserMock',
            LogServiceTransaction__c = false,
            AsyncLogServiceTransaction__c = false
        );

        Account acc = new Account(Name = 'Test Account', DocumentNumber__c = '321312321');
        insert acc;

        WebServiceTestFactory.start().authOAuthProvider().create();
    }

    @isTest
    static void testUpdateSMSExpiradoChangeOfAddress() {
        List<CanalNotificacoesMinhasSolicitacoes__mdt> canaisNotificacao = obterCanaisNotificacao();
        NotificadorMinhasSolicitacoes.canalSelector = (CanalNotificacoesMinhasSolicitacoes) Test.createStub(
            CanalNotificacoesMinhasSolicitacoes.class,
            new CanalNotificacoesMinhasSolicitacoesStub(canaisNotificacao)
        );

        Test.setMock(HttpCalloutMock.class, new NotificadorMinhasSolicitacoesTest.CalloutMock());
        Account testAccount = [SELECT Name FROM Account];
        Case caseRecord = new Case(
            AccountId = testAccount.Id,
            Status = 'Test',
            ContactPhone__c = '123-456-7890',
            Protocol__c = 'ABC123',
            RecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get('ChangeOfAddress').getRecordTypeId()
        );
        insert caseRecord;
        Case insertedTestCase = [SELECT Id, AccountId, Status, Document__c, ContactPhone__c, RecordType.DeveloperName, Protocol__c, CreatedDate FROM Case];
        insertedTestCase.Status = 'Expirado';
        Test.startTest();
        update insertedTestCase;
        Test.stopTest();
        Case testCase = [SELECT Id, AccountId, Status, Document__c, ContactPhone__c, RecordType.DeveloperName, Protocol__c, CreatedDate FROM Case];
        String requestBody = NotificadorPushSMS.requestBody;
        //Verifica se os campos foram corretamentes inseridos no body.
        Map<String, Object> parsedBody = (Map<String, Object>)JSON.deserializeUntyped(requestBody);
        System.assertEquals(testCase.Document__c, parsedBody.get('KEY'));
        System.assertEquals('2', parsedBody.get('KEY_TYPE'));
        System.assertEquals('519', parsedBody.get('ID_EVENT_TYPE')); //Assumindo que o status seja igual a 'Expirado'.
        DateTime caseDateTime = testCase.CreatedDate;
        String formattedDate = caseDateTime.format('dd/MM/yyyy');
        System.assertEquals(formattedDate, parsedBody.get('DT_EVENT'));
        System.assertEquals(String.valueOf(testCase.CreatedDate.format('dd/MM/yyyy hh:mm:ss.SSS a')), parsedBody.get('DTTM_EVENT'));
        System.assertEquals('1', parsedBody.get('ID_SOURCE_TYPE'));
        System.assertEquals(String.valueOf(testCase.ContactPhone__c), parsedBody.get('DS_EVENT_ADD1'));
        System.assertEquals(testAccount.Name.split(' ')[0], parsedBody.get('DS_EVENT_ADD2'));
        System.assertEquals(testCase.RecordType.DeveloperName, parsedBody.get('DS_EVENT_ADD3'));
        System.assertEquals(testCase.Id, parsedBody.get('DS_EVENT_ADD4'));
        System.assertEquals(testCase.Protocol__c, parsedBody.get('DS_EVENT_ADD5'));
    }

    @isTest
    static void testCalloutBotaoNotificarCliente() {
        List<CanalNotificacoesMinhasSolicitacoes__mdt> canaisNotificacao = obterCanaisNotificacao();
        NotificadorMinhasSolicitacoes.canalSelector = (CanalNotificacoesMinhasSolicitacoes) Test.createStub(
            CanalNotificacoesMinhasSolicitacoes.class,
            new CanalNotificacoesMinhasSolicitacoesStub(canaisNotificacao)
        );

        Test.setMock(HttpCalloutMock.class, new NotificadorMinhasSolicitacoesTest.CalloutMock());
        Account testAccount = [SELECT Name FROM Account];
        Case caseRecord = new Case(
            AccountId = testAccount.Id,
            Status = 'Teste',
            ContactPhone__c = '123-456-7890',
            Protocol__c = 'ABC123',
            RecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get('ChangeOfAddress').getRecordTypeId()
        );
        insert caseRecord;
        Case testCase = [SELECT Id, AccountId, Status, Document__c, ContactPhone__c, RecordType.DeveloperName, Protocol__c, CreatedDate FROM Case];
        Test.startTest();
        NotificadorCallOut calloutJob = new NotificadorCallOut(String.valueOf(testCase.Id), GATILHO_DISPARO_NOTIFICACAO.BOTAO_NOTIFICAR_CLIENTE);
        calloutJob.sendNotification(String.valueOf(testCase.Id));
        Test.stopTest();
        String requestBody = NotificadorCallOut.requestBody;
        Map<String, Object> parsedBody = (Map<String, Object>)JSON.deserializeUntyped(requestBody);
        System.assertEquals('41985078965', parsedBody.get('user_id'));
        System.assertEquals('Sua solicitação foi atualizada', parsedBody.get('name'));
        System.assertEquals('Test, você tem uma nova mensagem para sua mudança do endereço de instalação', parsedBody.get('description'));
        System.assertEquals('ChangeOfAddress', parsedBody.get('status'));
        System.assertEquals('ticket_update', parsedBody.get('type'));
        System.assertEquals('true', parsedBody.get('view'));
        DateTime caseDateTime = testCase.CreatedDate;
        String formattedDate = caseDateTime.format('yyyy-MM-dd\'T\'HH:mm:ss.SSSSSS\'Z\''); 
        System.assertEquals(formattedDate, parsedBody.get('creation_date'));
    }

    @isTest
    static void testSMSRequestBodyBuilderExpirado() {
        List<CanalNotificacoesMinhasSolicitacoes__mdt> canaisNotificacao = obterCanaisNotificacao();
        NotificadorMinhasSolicitacoes.canalSelector = (CanalNotificacoesMinhasSolicitacoes) Test.createStub(
            CanalNotificacoesMinhasSolicitacoes.class,
            new CanalNotificacoesMinhasSolicitacoesStub(canaisNotificacao)
        );
        Test.setMock(HttpCalloutMock.class, new NotificadorMinhasSolicitacoesTest.CalloutMock());

        Account testAccount = [SELECT Name FROM Account];

        Case caseRecord = new Case(
            AccountId = testAccount.Id,
            Status = 'Expirado',  
            ContactPhone__c = '123-456-7890',
            Protocol__c = 'ABC123',
            RecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get('ChangeOfAddress').getRecordTypeId()
        );

        Test.startTest();
        insert caseRecord;
        Test.stopTest();

        Case testCase = [SELECT Id, AccountId, Status, Document__c, ContactPhone__c, RecordType.DeveloperName, Protocol__c, CreatedDate FROM Case];
        String requestBody = NotificadorPushSMS.requestBody; 

        //Verifica se os campos foram corretamentes inseridos no body.
        Map<String, Object> parsedBody = (Map<String, Object>)JSON.deserializeUntyped(requestBody);
        System.assertEquals(testCase.Document__c, parsedBody.get('KEY'));
        System.assertEquals('2', parsedBody.get('KEY_TYPE'));
        System.assertEquals('519', parsedBody.get('ID_EVENT_TYPE')); //Assumindo que o status seja igual a 'Expirado'.
        DateTime caseDateTime = testCase.CreatedDate;
        String formattedDate = caseDateTime.format('dd/MM/yyyy');
        System.assertEquals(formattedDate, parsedBody.get('DT_EVENT'));
        System.assertEquals(String.valueOf(testCase.CreatedDate.format('dd/MM/yyyy hh:mm:ss.SSS a')), parsedBody.get('DTTM_EVENT'));
        System.assertEquals('1', parsedBody.get('ID_SOURCE_TYPE'));
        System.assertEquals(String.valueOf(testCase.ContactPhone__c), parsedBody.get('DS_EVENT_ADD1'));
        System.assertEquals(testAccount.Name.split(' ')[0], parsedBody.get('DS_EVENT_ADD2'));
        System.assertEquals(testCase.RecordType.DeveloperName, parsedBody.get('DS_EVENT_ADD3'));
        System.assertEquals(testCase.Id, parsedBody.get('DS_EVENT_ADD4'));
        System.assertEquals(testCase.Protocol__c, parsedBody.get('DS_EVENT_ADD5'));
    }

    @isTest
    static void testSMSRequestBodyBuilderClosed() {
        List<CanalNotificacoesMinhasSolicitacoes__mdt> canaisNotificacao = obterCanaisNotificacao();
        NotificadorMinhasSolicitacoes.canalSelector = (CanalNotificacoesMinhasSolicitacoes) Test.createStub(
            CanalNotificacoesMinhasSolicitacoes.class,
            new CanalNotificacoesMinhasSolicitacoesStub(canaisNotificacao)
        );
        Test.setMock(HttpCalloutMock.class, new NotificadorMinhasSolicitacoesTest.CalloutMock());

        Account testAccount = [SELECT Name FROM Account];

        Case caseRecord = new Case(
            AccountId = testAccount.Id,
            Status = 'Closed',  
            ContactPhone__c = '123-456-7890',
            Protocol__c = 'ABC123',
            RecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get('ChangeOfAddress').getRecordTypeId()
        );

        Test.startTest();
        insert caseRecord;
        Test.stopTest();

        Case testCase = [SELECT Id, AccountId, Status, Document__c, ContactPhone__c, RecordType.DeveloperName, Protocol__c, CreatedDate FROM Case];
        String requestBody = NotificadorPushSMS.requestBody; 

        //Verifica se os campos foram corretamentes inseridos no body.
        Map<String, Object> parsedBody = (Map<String, Object>)JSON.deserializeUntyped(requestBody);
        System.assertEquals(testCase.Document__c, parsedBody.get('KEY'));
        System.assertEquals('2', parsedBody.get('KEY_TYPE'));
        System.assertEquals('520', parsedBody.get('ID_EVENT_TYPE')); //Assumindo que o status seja igual a 'Expirado'.
        DateTime caseDateTime = testCase.CreatedDate;
        String formattedDate = caseDateTime.format('dd/MM/yyyy');
        System.assertEquals(formattedDate, parsedBody.get('DT_EVENT'));
        System.assertEquals(String.valueOf(testCase.CreatedDate.format('dd/MM/yyyy hh:mm:ss.SSS a')), parsedBody.get('DTTM_EVENT'));
        System.assertEquals('1', parsedBody.get('ID_SOURCE_TYPE'));
        System.assertEquals(String.valueOf(testCase.ContactPhone__c), parsedBody.get('DS_EVENT_ADD1'));
        System.assertEquals(testAccount.Name.split(' ')[0], parsedBody.get('DS_EVENT_ADD2'));
        System.assertEquals(testCase.RecordType.DeveloperName, parsedBody.get('DS_EVENT_ADD3'));
        System.assertEquals(testCase.Id, parsedBody.get('DS_EVENT_ADD4'));
        System.assertEquals(testCase.Protocol__c, parsedBody.get('DS_EVENT_ADD5'));
    }

    @isTest
    static void testCallOutRequestBodyBuilderAguardandoChangeOfAddress() {
        List<CanalNotificacoesMinhasSolicitacoes__mdt> canaisNotificacao = obterCanaisNotificacao();
        NotificadorMinhasSolicitacoes.canalSelector = (CanalNotificacoesMinhasSolicitacoes) Test.createStub(
            CanalNotificacoesMinhasSolicitacoes.class,
            new CanalNotificacoesMinhasSolicitacoesStub(canaisNotificacao)
        );
        Test.setMock(HttpCalloutMock.class, new NotificadorMinhasSolicitacoesTest.CalloutMock());

        Account testAccount = [SELECT Id, Name FROM Account];
        Case caseRecord = new Case(
            AccountId = testAccount.Id,
            Status = 'Aguardando Informação',  
            ContactPhone__c = '123-456-7890',
            RecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get('ChangeOfAddress').getRecordTypeId(),
            Protocol__c = 'ABC123'
        );

        Test.startTest();
        insert caseRecord;
        Test.stopTest();

        Case testCase = [SELECT Id, AccountId, Status, Document__c, ContactPhone__c, RecordType.DeveloperName, Protocol__c, CreatedDate FROM Case];
        String requestBody = NotificadorCallOut.requestBody; 

        Map<String, Object> parsedBody = (Map<String, Object>)JSON.deserializeUntyped(requestBody);

        System.assertEquals('41985078965', parsedBody.get('user_id'));
        System.assertEquals('Estamos esperando seu retorno', parsedBody.get('name'));
        System.assertEquals('Test, você tem uma nova mensagem para sua mudança do endereço de instalação', parsedBody.get('description'));
        System.assertEquals('ChangeOfAddress', parsedBody.get('status'));
        System.assertEquals('ticket_update', parsedBody.get('type'));
        System.assertEquals('true', parsedBody.get('view'));
        DateTime caseDateTime = testCase.CreatedDate;
        String formattedDate = caseDateTime.format('yyyy-MM-dd\'T\'HH:mm:ss.SSSSSS\'Z\''); 
        System.assertEquals(formattedDate, parsedBody.get('creation_date'));
    }

    @isTest
    static void testCallOutRequestBodyBuilderAguardandoHelpWithBilling() {
        List<CanalNotificacoesMinhasSolicitacoes__mdt> canaisNotificacao = obterCanaisNotificacao();
        NotificadorMinhasSolicitacoes.canalSelector = (CanalNotificacoesMinhasSolicitacoes) Test.createStub(
            CanalNotificacoesMinhasSolicitacoes.class,
            new CanalNotificacoesMinhasSolicitacoesStub(canaisNotificacao)
        );
        Test.setMock(HttpCalloutMock.class, new NotificadorMinhasSolicitacoesTest.CalloutMock());

        Account testAccount = [SELECT Id, Name FROM Account];
        Case caseRecord = new Case(
            AccountId = testAccount.Id,
            Status = 'Aguardando Informação',  
            ContactPhone__c = '123-456-7890',
            RecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get('Helpwithbilling').getRecordTypeId(),
            Protocol__c = 'ABC123'
        );
        Test.startTest();
        insert caseRecord;
        Test.stopTest();

        Case testCase = [SELECT Id, AccountId, Status, Document__c, ContactPhone__c, RecordType.DeveloperName, Protocol__c, CreatedDate FROM Case];
        String requestBody = NotificadorCallOut.requestBody; 

        Map<String, Object> parsedBody = (Map<String, Object>)JSON.deserializeUntyped(requestBody);

        System.assertEquals('41985078965', parsedBody.get('user_id'));
        System.assertEquals('Estamos esperando seu retorno', parsedBody.get('name'));
        System.assertEquals('Test, você tem uma nova mensagem para sua ajuda com cobrança', parsedBody.get('description'));
        System.assertEquals('Helpwithbilling', parsedBody.get('status'));
        System.assertEquals('ticket_update', parsedBody.get('type'));
        System.assertEquals('true', parsedBody.get('view'));
        DateTime caseDateTime = testCase.CreatedDate;
        String formattedDate = caseDateTime.format('yyyy-MM-dd\'T\'HH:mm:ss.SSSSSS\'Z\'');
        System.assertEquals(formattedDate, parsedBody.get('creation_date'));
    }

    @isTest
    static void testCallOutRequestBodyBuilderAguardandoProblemWithPortability() {
        List<CanalNotificacoesMinhasSolicitacoes__mdt> canaisNotificacao = obterCanaisNotificacao();
        NotificadorMinhasSolicitacoes.canalSelector = (CanalNotificacoesMinhasSolicitacoes) Test.createStub(
            CanalNotificacoesMinhasSolicitacoes.class,
            new CanalNotificacoesMinhasSolicitacoesStub(canaisNotificacao)
        );
        Test.setMock(HttpCalloutMock.class, new NotificadorMinhasSolicitacoesTest.CalloutMock());

        Account testAccount = [SELECT Id, Name FROM Account];
        Case caseRecord = new Case(
            AccountId = testAccount.Id,
            Status = 'Aguardando Informação',  
            ContactPhone__c = '123-456-7890',
            RecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get('ProblemWithPortability').getRecordTypeId(),
            Protocol__c = 'ABC123'
        );

        Test.startTest();
        insert caseRecord;
        Test.stopTest();

        Case testCase = [SELECT Id, AccountId, Status, Document__c, ContactPhone__c, RecordType.DeveloperName, Protocol__c, CreatedDate FROM Case];
        String requestBody = NotificadorCallOut.requestBody; 

        Map<String, Object> parsedBody = (Map<String, Object>)JSON.deserializeUntyped(requestBody);

        System.assertEquals('41985078965', parsedBody.get('user_id'));
        System.assertEquals('Estamos esperando seu retorno', parsedBody.get('name'));
        System.assertEquals('Test, você tem uma nova mensagem para seu problema com portabilidade', parsedBody.get('description'));
        System.assertEquals('ProblemWithPortability', parsedBody.get('status'));
        System.assertEquals('ticket_update', parsedBody.get('type'));
        System.assertEquals('true', parsedBody.get('view'));
        DateTime caseDateTime = testCase.CreatedDate;
        String formattedDate = caseDateTime.format('yyyy-MM-dd\'T\'HH:mm:ss.SSSSSS\'Z\'');
        System.assertEquals(formattedDate, parsedBody.get('creation_date'));
    }

    @isTest
    static void testCallOutRequestBodyBuilderClosedChangeOfAddress() {
        List<CanalNotificacoesMinhasSolicitacoes__mdt> canaisNotificacao = obterCanaisNotificacao();
        NotificadorMinhasSolicitacoes.canalSelector = (CanalNotificacoesMinhasSolicitacoes) Test.createStub(
            CanalNotificacoesMinhasSolicitacoes.class,
            new CanalNotificacoesMinhasSolicitacoesStub(canaisNotificacao)
        );
        Test.setMock(HttpCalloutMock.class, new NotificadorMinhasSolicitacoesTest.CalloutMock());

        Account testAccount = [SELECT Id, Name FROM Account];
        Case caseRecord = new Case(
            AccountId = testAccount.Id,
            Status = 'Closed',  
            ContactPhone__c = '123-456-7890',
            RecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get('ChangeOfAddress').getRecordTypeId(),
            Protocol__c = 'ABC123'
        );

        Test.startTest();
        insert caseRecord;
        Test.stopTest();

        Case testCase = [SELECT Id, AccountId, Status, Document__c, ContactPhone__c, RecordType.DeveloperName, Protocol__c, CreatedDate FROM Case];
        String requestBody = NotificadorCallOut.requestBody; 

        Map<String, Object> parsedBody = (Map<String, Object>)JSON.deserializeUntyped(requestBody);

        System.assertEquals('41985078965', parsedBody.get('user_id'));
        System.assertEquals('Sua solicitação foi concluída', parsedBody.get('name'));
        System.assertEquals('Test, sua mudança do endereço de instalação foi resolvida', parsedBody.get('description'));
        System.assertEquals('ChangeOfAddress', parsedBody.get('status'));
        System.assertEquals('ticket_update', parsedBody.get('type'));
        System.assertEquals('true', parsedBody.get('view'));
        DateTime caseDateTime = testCase.CreatedDate;
        String formattedDate = caseDateTime.format('yyyy-MM-dd\'T\'HH:mm:ss.SSSSSS\'Z\'');
        System.assertEquals(formattedDate, parsedBody.get('creation_date'));
    }

    @isTest
    static void testCallOutRequestBodyBuilderClosedHelpWithBilling() {
        List<CanalNotificacoesMinhasSolicitacoes__mdt> canaisNotificacao = obterCanaisNotificacao();
        NotificadorMinhasSolicitacoes.canalSelector = (CanalNotificacoesMinhasSolicitacoes) Test.createStub(
            CanalNotificacoesMinhasSolicitacoes.class,
            new CanalNotificacoesMinhasSolicitacoesStub(canaisNotificacao)
        );
        Test.setMock(HttpCalloutMock.class, new NotificadorMinhasSolicitacoesTest.CalloutMock());

        Account testAccount = [SELECT Id, Name FROM Account];
        Case caseRecord = new Case(
            AccountId = testAccount.Id,
            Status = 'Closed',  
            ContactPhone__c = '123-456-7890',
            RecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get('Helpwithbilling').getRecordTypeId(),
            Protocol__c = 'ABC123'
        );

        Test.startTest();
        insert caseRecord;
        Test.stopTest();

        Case testCase = [SELECT Id, AccountId, Status, Document__c, ContactPhone__c, RecordType.DeveloperName, Protocol__c, CreatedDate FROM Case];
        String requestBody = NotificadorCallOut.requestBody; 

        Map<String, Object> parsedBody = (Map<String, Object>)JSON.deserializeUntyped(requestBody);

        System.assertEquals('41985078965', parsedBody.get('user_id'));
        System.assertEquals('Sua solicitação foi concluída', parsedBody.get('name'));
        System.assertEquals('Test, sua ajuda com cobrança foi resolvida', parsedBody.get('description'));
        System.assertEquals('Helpwithbilling', parsedBody.get('status'));
        System.assertEquals('ticket_update', parsedBody.get('type'));
        System.assertEquals('true', parsedBody.get('view'));
        DateTime caseDateTime = testCase.CreatedDate;
        String formattedDate = caseDateTime.format('yyyy-MM-dd\'T\'HH:mm:ss.SSSSSS\'Z\'');
        System.assertEquals(formattedDate, parsedBody.get('creation_date'));
    }

    @isTest
    static void testCallOutRequestBodyBuilderClosedProblemWithPortability() {
        List<CanalNotificacoesMinhasSolicitacoes__mdt> canaisNotificacao = obterCanaisNotificacao();
        NotificadorMinhasSolicitacoes.canalSelector = (CanalNotificacoesMinhasSolicitacoes) Test.createStub(
            CanalNotificacoesMinhasSolicitacoes.class,
            new CanalNotificacoesMinhasSolicitacoesStub(canaisNotificacao)
        );
        Test.setMock(HttpCalloutMock.class, new NotificadorMinhasSolicitacoesTest.CalloutMock());

        Account testAccount = [SELECT Id, Name FROM Account];
        Case caseRecord = new Case(
            AccountId = testAccount.Id,
            Status = 'Closed',  
            ContactPhone__c = '123-456-7890',
            RecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get('ProblemWithPortability').getRecordTypeId(),
            Protocol__c = 'ABC123'
        );

        Test.startTest();
        insert caseRecord;
        Test.stopTest();

        Case testCase = [SELECT Id, AccountId, Status, Document__c, ContactPhone__c, RecordType.DeveloperName, Protocol__c, CreatedDate FROM Case];
        String requestBody = NotificadorCallOut.requestBody; 

        Map<String, Object> parsedBody = (Map<String, Object>)JSON.deserializeUntyped(requestBody);

        System.assertEquals('41985078965', parsedBody.get('user_id'));
        System.assertEquals('Sua solicitação foi concluída', parsedBody.get('name'));
        System.assertEquals('Test, seu problema com portabilidade foi resolvido', parsedBody.get('description'));
        System.assertEquals('ProblemWithPortability', parsedBody.get('status'));
        System.assertEquals('ticket_update', parsedBody.get('type'));
        System.assertEquals('true', parsedBody.get('view'));
        DateTime caseDateTime = testCase.CreatedDate;
        String formattedDate = caseDateTime.format('yyyy-MM-dd\'T\'HH:mm:ss.SSSSSS\'Z\''); 
        System.assertEquals(formattedDate, parsedBody.get('creation_date'));
    }

    public class CalloutMock implements HttpCalloutMock {

        public HTTPResponse respond(HTTPRequest request) {
            HttpResponse response = new HttpResponse();
            response.setHeader('Content-Type', 'application/json');
            response.setBody('[{"identities":[{"services":["authentication"],"roles":["owner"],"id":"07821923940","type":"uid"},{"services":["authentication"],"roles":["owner"],"id":"nome.sobrenome@gmail.com","type":"email"},{"services":["authentication","mobile_postpaid"],"roles":["owner"],"id":"+5541985078965","type":"phone_number"},{"services":["landline"],"roles":["owner"],"id":"+554133836820","type":"uid","group_ids":["SB899994751275"]},{"services":["landline"],"roles":["owner"],"id":"+554132829225","type":"uid","group_ids":["SB899994751275"]},{"services":["iptv"],"roles":["owner"],"id":"TV-SJP-81KU1MJ7R-050","type":"uid","group_ids":["SB899994751275"]},{"services":["internet"],"roles":["owner"],"id":"SJP-30R209NP-013","type":"uid","group_ids":["SB899994751275"]}],"id":"41985078965","name":"NOME SOBRENOME","id_document":{"value":"07821923940","country":"BR","type":"CPF"},"contact_media":[{"type":"email","value":"NOME.SOBRENOME@TELEFONICA.COM"},{"type":"phone_number","value":"+554132829225"},{"type":"phone_number","value":"+5541985078965"},{"type":"phone_number","value":"+554133836820"},{"type":"email","value":"nome.sobrenome@telefonica.com"}]}]');
            response.setStatusCode(200);
            return response;
        }
    }
}