/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an org are executed whenever Apex code is deployed
 * to a production org to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production org. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the org size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest private class CaseMyRequestsControllerTest
{
    @TestSetup
    static void makeData(){
        Account accountRec = new Account();
        accountRec.Name = 'Test Account';
        accountRec.DocumentNumber__c = '1234';
        insert accountRec;

        Contact contactRec = new Contact();
        contactRec.AccountId = accountRec.Id;
        contactRec.LastName = 'Test Contact';
        contactRec.Email = 'contact@test.com';
        contactRec.ExternalId__c = '1234';
        insert contactRec;

        Asset assetRec = new Asset();
        assetRec.AccountId = accountRec.Id;
        assetRec.Name = 'Test Asset';
        assetRec.MainProductDescription__c = 'Vivo Fibra';
        insert assetRec;
    }

    @isTest
    static void sendNotificationForCasesWithUpdatedStatusTest()
    {
        Account accountRec = [SELECT Id FROM Account WHERE DocumentNumber__c = '1234'];
        Asset assetRec = [SELECT Id FROM Asset WHERE Name = 'Test Asset'];

        Case caseRec = DataFactory.createCase(CasesMyRequestsB2C.HELP_WITH_BILLING_RECORD_TYPE_API_NAME, 'Test new Case 1', 'add new case test');
        caseRec.Protocol__c = '1234';
        caseRec.AccountId = accountRec.Id;
        caseRec.ComplainedAsset__c = assetRec.Id;
        insert caseRec;

        String notificationMessage = CaseMyRequestsController.sendEmailNotificationWhenCaseStatusUpdatedManually(caseRec.Id);

        Assert.isTrue(!String.isBlank(notificationMessage));
        Assert.areEqual('SUCCESS', notificationMessage);
    }

    @isTest
    static void sendNotificationForCasesWithUpdatedStatusFailProtocolTest()
    {

        Account accountRec = [SELECT Id FROM Account WHERE DocumentNumber__c = '1234'];
        Asset assetRec = [SELECT Id FROM Asset WHERE Name = 'Test Asset'];

        Case caseRec = DataFactory.createCase(CasesMyRequestsB2C.HELP_WITH_BILLING_RECORD_TYPE_API_NAME, 'Test new Case 1', 'add new case test');
        caseRec.AccountId = accountRec.Id;
        caseRec.ComplainedAsset__c = assetRec.Id;
        insert caseRec;

        try {
            String notificationMessage = CaseMyRequestsController.sendEmailNotificationWhenCaseStatusUpdatedManually(caseRec.Id);
        } 
        catch (CaseMyRequestsException e) {
            String expectedMessage = 'Caso sem Protocolo.';
            String atualMessage = e.getMessage();
            Assert.areEqual(expectedMessage, atualMessage);
        }   
    }

    @isTest
    static void sendNotificationForCasesWithUpdatedStatusFailRecordDependencyTest()
    {
        Case caseRec = DataFactory.createCase(CasesMyRequestsB2C.HELP_WITH_BILLING_RECORD_TYPE_API_NAME, 'Test new Case 1', 'add new case test');
        caseRec.Protocol__c = '1234';
        insert caseRec;

        try {
            String notificationMessage = CaseMyRequestsController.sendEmailNotificationWhenCaseStatusUpdatedManually(caseRec.Id);
        } 
        catch (Exception e) {
            String expectedMessage = 'List has no rows for assignment to SObject';
            String atualMessage = e.getMessage();
            Assert.areEqual(expectedMessage, atualMessage);
        }
    }

    @isTest
    static void sendNotificationForCasesWithUpdatedStatusFailEmailTest()
    {
        Account accountRec = [SELECT Id FROM Account WHERE DocumentNumber__c = '1234'];
        Asset assetRec = [SELECT Id FROM Asset WHERE Name = 'Test Asset'];

        Case caseRec = DataFactory.createCase(CasesMyRequestsB2C.HELP_WITH_BILLING_RECORD_TYPE_API_NAME, 'Test new Case 1', 'add new case test');
        caseRec.Protocol__c = '1234';
        caseRec.AccountId = accountRec.Id;
        caseRec.ComplainedAsset__c = assetRec.Id;
        insert caseRec;

        try {
            String notificationMessage = CaseMyRequestsController.sendEmailNotificationWhenCaseStatusUpdatedManually(caseRec.Id);
        } 
        catch (CaseMyRequestsException e) {
            String expectedMessage = 'Contato sem Email vinculado.';
            String atualMessage = e.getMessage();
            Assert.areEqual(expectedMessage, atualMessage);
        }
    }

    @isTest
    static void getCaseTest() {
        Account accountRec = [SELECT Id FROM Account WHERE DocumentNumber__c = '1234'];
        Asset assetRec = [SELECT Id FROM Asset WHERE Name = 'Test Asset'];

        Case caseRec = DataFactory.createCase(CasesMyRequestsB2C.HELP_WITH_BILLING_RECORD_TYPE_API_NAME, 'Test new Case 1', 'add new case test');
        caseRec.Protocol__c = '1234';
        caseRec.AccountId = accountRec.Id;
        caseRec.ComplainedAsset__c = assetRec.Id;
        insert caseRec;

        Case caseRec2 = CaseMyRequestsController.getCase(caseRec.Id);

        Assert.areEqual(caseRec.Id, caseRec2.Id);
    }

    @isTest
    static void getCaseFailTest() {
        try {
            Case caseObj2 = CaseMyRequestsController.getCase(null);
        } catch (Exception e) {
            String errorMessage = e.getMessage();
            System.debug(LoggingLevel.DEBUG, errorMessage);
            Assert.isNotNull(errorMessage);
        }
    }

    @isTest
    static void updateCaseStatusTest() {

        List<CanalNotificacoesMinhasSolicitacoes__mdt> canais = new List<CanalNotificacoesMinhasSolicitacoes__mdt>();
        CanalNotificacoesMinhasSolicitacoes canalSelecionado = (CanalNotificacoesMinhasSolicitacoes) Test.createStub(
            CanalNotificacoesMinhasSolicitacoes.class,
            new CanalNotificacoesMinhasSolicitacoesStub(canais)
        );
        NotificadorMinhasSolicitacoes.canalSelector = canalSelecionado;

        Account accountRec = [SELECT Id FROM Account WHERE DocumentNumber__c = '1234'];
        Asset assetRec = [SELECT Id FROM Asset WHERE Name = 'Test Asset'];

        Case caseRec = DataFactory.createCase(CasesMyRequestsB2C.HELP_WITH_BILLING_RECORD_TYPE_API_NAME, 'Test new Case 1', 'add new case test');
        caseRec.Status = 'New';
        caseRec.Protocol__c = '1234';
        caseRec.AccountId = accountRec.Id;
        caseRec.ComplainedAsset__c = assetRec.Id;
        insert caseRec;

        String newStatus = 'Closed';
        Test.startTest();
        String result = CaseMyRequestsController.updateCaseStatus(caseRec.Id, newStatus);
        Case caseRec2 = CaseMyRequestsController.getCase(caseRec.Id);
        Test.stopTest();
        
        Assert.areEqual(newStatus, caseRec2.Status);
    }

    @isTest
    static void updateCaseStatusFailTest() {
        try {
            String result = CaseMyRequestsController.updateCaseStatus(null, null);
        } catch (Exception e) {
            String errorMessage = e.getMessage();
            System.debug(LoggingLevel.DEBUG, errorMessage);
            Assert.isNotNull(errorMessage);
        }
    }

    @isTest
    static void sendCallOutNotificationWhenCaseIsManuallyUpdatedTest()
    {
        List<CanalNotificacoesMinhasSolicitacoes__mdt> canais = NotificadorMinhasSolicitacoesTest.obterCanaisNotificacao();
        CanalNotificacoesMinhasSolicitacoes canalSelecionado = (CanalNotificacoesMinhasSolicitacoes) Test.createStub(
            CanalNotificacoesMinhasSolicitacoes.class,
            new CanalNotificacoesMinhasSolicitacoesStub(canais)
        );
        NotificadorMinhasSolicitacoes.canalSelector = canalSelecionado;
        
        Integer responseStatusCode = 201;
        NotificadorCallOut notificadorCallOut = (NotificadorCallOut) Test.createStub(
            NotificadorCallOut.class, new NotificadorCallOutStub(responseStatusCode)
        );
        CaseMyRequestsController.notificadorCallOut = notificadorCallOut;

        Account accountRec = [SELECT Id FROM Account WHERE DocumentNumber__c = '1234'];
        Asset assetRec = [SELECT Id FROM Asset WHERE Name = 'Test Asset'];

        Case caseRec = DataFactory.createCase(CasesMyRequestsB2C.HELP_WITH_BILLING_RECORD_TYPE_API_NAME, 'Test new Case 1', 'add new case test');
        caseRec.Protocol__c = '1234';
        caseRec.AccountId = accountRec.Id;
        caseRec.ComplainedAsset__c = assetRec.Id;
        insert caseRec;

        Test.startTest();
        String notificationMessage = CaseMyRequestsController.sendCallOutNotificationWhenCaseIsManuallyUpdated(caseRec.Id);
        Test.stopTest();

        Assert.isTrue(!String.isBlank(notificationMessage));
        Assert.areEqual('SUCCESS', notificationMessage);
    }
    
    @isTest
    static void sendCallOutNotificationWhenCaseIsManuallyUpdatedFailTest()
    {
        List<CanalNotificacoesMinhasSolicitacoes__mdt> canais = NotificadorMinhasSolicitacoesTest.obterCanaisNotificacao();
        CanalNotificacoesMinhasSolicitacoes canalSelecionado = (CanalNotificacoesMinhasSolicitacoes) Test.createStub(
            CanalNotificacoesMinhasSolicitacoes.class,
            new CanalNotificacoesMinhasSolicitacoesStub(canais)
        );
        NotificadorMinhasSolicitacoes.canalSelector = canalSelecionado;

        Integer responseStatusCode = 500;
        NotificadorCallOut notificadorCallOut = (NotificadorCallOut) Test.createStub(
            NotificadorCallOut.class, new NotificadorCallOutStub(responseStatusCode)
        );
        CaseMyRequestsController.notificadorCallOut = notificadorCallOut;

        Account accountRec = [SELECT Id FROM Account WHERE DocumentNumber__c = '1234'];
        Asset assetRec = [SELECT Id FROM Asset WHERE Name = 'Test Asset'];

        Case caseRec = DataFactory.createCase(CasesMyRequestsB2C.HELP_WITH_BILLING_RECORD_TYPE_API_NAME, 'Test new Case 1', 'add new case test');
        caseRec.Protocol__c = '1234';
        caseRec.AccountId = accountRec.Id;
        caseRec.ComplainedAsset__c = assetRec.Id;
        insert caseRec;

        try {
			Test.startTest();
            String notificationMessage = CaseMyRequestsController.sendCallOutNotificationWhenCaseIsManuallyUpdated(caseRec.Id);
	        Test.stopTest();   
        } catch (AuraHandledException e) {
            String errorMessage = e.getMessage();
            System.debug(LoggingLevel.DEBUG, errorMessage);
            Assert.isNotNull(errorMessage);
        }
    }

    @isTest
    static void sendPushSmsNotificationWhenCaseIsManuallyUpdatedTest()
    {
        List<CanalNotificacoesMinhasSolicitacoes__mdt> canais = NotificadorMinhasSolicitacoesTest.obterCanaisNotificacao();
        CanalNotificacoesMinhasSolicitacoes canalSelecionado = (CanalNotificacoesMinhasSolicitacoes) Test.createStub(
            CanalNotificacoesMinhasSolicitacoes.class,
            new CanalNotificacoesMinhasSolicitacoesStub(canais)
        );
        NotificadorMinhasSolicitacoes.canalSelector = canalSelecionado;
        
        Integer responseStatusCode = 201;
        NotificadorPushSMS notificadorPushSms = (NotificadorPushSMS) Test.createStub(
            NotificadorPushSMS.class, new NotificadorPushSmsStub(responseStatusCode)
        );
        CaseMyRequestsController.notificadorPushSms = notificadorPushSms;
        
        Account accountRec = [SELECT Id FROM Account WHERE DocumentNumber__c = '1234'];
        Asset assetRec = [SELECT Id FROM Asset WHERE Name = 'Test Asset'];

        Case caseRec = DataFactory.createCase(CasesMyRequestsB2C.HELP_WITH_BILLING_RECORD_TYPE_API_NAME, 'Test new Case 1', 'add new case test');
        caseRec.Protocol__c = '1234';
        caseRec.AccountId = accountRec.Id;
        caseRec.ComplainedAsset__c = assetRec.Id;
        insert caseRec;

        Test.startTest();
        String notificationMessage = CaseMyRequestsController.sendPushSmsNotificationWhenCaseIsManuallyUpdated(caseRec.Id);
        Test.stopTest();

        Assert.isTrue(!String.isBlank(notificationMessage));
        Assert.areEqual('SUCCESS', notificationMessage);
    }
    
    @isTest
    static void sendPushSmsNotificationWhenCaseIsManuallyUpdatedFailTest()
    {
        List<CanalNotificacoesMinhasSolicitacoes__mdt> canais = NotificadorMinhasSolicitacoesTest.obterCanaisNotificacao();
        CanalNotificacoesMinhasSolicitacoes canalSelecionado = (CanalNotificacoesMinhasSolicitacoes) Test.createStub(
            CanalNotificacoesMinhasSolicitacoes.class,
            new CanalNotificacoesMinhasSolicitacoesStub(canais)
        );
        NotificadorMinhasSolicitacoes.canalSelector = canalSelecionado;
        
        Integer responseStatusCode = 500;
        NotificadorPushSMS notificadorPushSms = (NotificadorPushSMS) Test.createStub(
            NotificadorPushSMS.class, new NotificadorPushSmsStub(responseStatusCode)
        );
        CaseMyRequestsController.notificadorPushSms = notificadorPushSms;
        
        Account accountRec = [SELECT Id FROM Account WHERE DocumentNumber__c = '1234'];
        Asset assetRec = [SELECT Id FROM Asset WHERE Name = 'Test Asset'];

        Case caseRec = DataFactory.createCase(CasesMyRequestsB2C.HELP_WITH_BILLING_RECORD_TYPE_API_NAME, 'Test new Case 1', 'add new case test');
        caseRec.Protocol__c = '1234';
        caseRec.AccountId = accountRec.Id;
        caseRec.ComplainedAsset__c = assetRec.Id;
        insert caseRec;
        
        try {
			Test.startTest();
            String notificationMessage = CaseMyRequestsController.sendPushSmsNotificationWhenCaseIsManuallyUpdated(caseRec.Id);
	        Test.stopTest();   
        } catch (AuraHandledException e) {
            String errorMessage = e.getMessage();
            System.debug(LoggingLevel.DEBUG, errorMessage);
            Assert.isNotNull(errorMessage);
        }
    }
}