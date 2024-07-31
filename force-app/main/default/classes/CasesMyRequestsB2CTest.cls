@isTest
public with sharing class CasesMyRequestsB2CTest
{
    @TestSetup
    static void makeData()
    {
        Account accountObj1 = new Account();
        accountObj1.Name = 'Validate Test';
        insert accountObj1;

        Account accountObj2 = new Account();
        accountObj2.Name = 'Validate Test';
        insert accountObj2;
        
        Account accountObj3 = new Account();
        accountObj3.Name = 'Validate Test';
        insert accountObj3;
        

        Asset assetObj1 = new Asset();
        assetObj1.AccountId = accountObj1.Id;
        assetObj1.Name = 'Validate Test';
        insert assetObj1;

        Asset assetObj2 = new Asset();
        assetObj2.AccountId = accountObj2.Id;
        assetObj2.Name = 'Validate Test';
        insert assetObj2;

        Asset assetObj3 = new Asset();
        assetObj3.AccountId = accountObj3.Id;
        assetObj3.Name = 'Validate Test';
        insert assetObj3;


        Case oldCase1 = DataFactory.createCase(CasesMyRequestsB2C.HELP_WITH_BILLING_RECORD_TYPE_API_NAME, 'Test Case 1', 'add old case test');
        oldCase1.AccountId = accountObj1.Id;
        oldCase1.ComplainedAsset__c = assetObj1.Id;

        Case oldCase2 = DataFactory.createCase(CasesMyRequestsB2C.CHARGE_OF_ADDRESS_RECORD_TYPE_API_NAME, 'Test Case 2', 'add old case test');
        oldCase2.AccountId = accountObj2.Id;
        oldCase2.ComplainedAsset__c = assetObj2.Id;

        Case oldCase3 = DataFactory.createCase(CasesMyRequestsB2C.HELP_WITH_THE_ORDER_RECORD_TYPE_API_NAME, 'Test Case 3', 'add old case test');
        oldCase3.AccountId = accountObj3.Id;
        oldCase3.ComplainedAsset__c = assetObj3.Id;

        insert oldCase1;
        insert oldCase2;
        insert oldCase3;
    }

    @isTest
    public static void classInstantiationTest()
    {
        Map<Id, Case> oldCases = new Map<Id, Case>([SELECT Id, RecordTypeId FROM Case LIMIT 3]);
        List<Case> newCases = new List<Case>();

        Case newCase1 = DataFactory.createCase(CasesMyRequestsB2C.HELP_WITH_BILLING_RECORD_TYPE_API_NAME, 'Test Case 1', 'add new case test');
        Case newCase2 = DataFactory.createCase(CasesMyRequestsB2C.CHARGE_OF_ADDRESS_RECORD_TYPE_API_NAME, 'Test Case 2', 'add new case test');
        Case newCase3 = DataFactory.createCase(CasesMyRequestsB2C.HELP_WITH_THE_ORDER_RECORD_TYPE_API_NAME, 'Test Case 3', 'add new case test');

        newCases.add(newCase1);
        newCases.add(newCase2);
        newCases.add(newCase3);

        CasesMyRequestsB2C casesMyRequests = new CasesMyRequestsB2C();
        CasesMyRequestsB2C newCasesMyRequests = new CasesMyRequestsB2C(newCases);
        CasesMyRequestsB2C oldCasesMyRequests = new CasesMyRequestsB2C(oldCases);
        CasesMyRequestsB2C newAndOldCasesMyRequests = new CasesMyRequestsB2C(newCases, oldCases);

        Assert.areEqual(0, casesMyRequests.newCasesSize(), 'newCases deve iniciar vazio');
        Assert.areEqual(0, casesMyRequests.oldCasesSize(), 'oldCases deve iniciar vazio');
        Assert.areEqual(3, newCasesMyRequests.newCasesSize(), 'newCases deve iniciar com três registros');
        Assert.areEqual(0, newCasesMyRequests.oldCasesSize(), 'oldCases deve iniciar vazio');
        Assert.areEqual(0, oldCasesMyRequests.newCasesSize(), 'newCases deve iniciar vazio');
        Assert.areEqual(3, oldCasesMyRequests.oldCasesSize(), 'oldCases deve iniciar com três registros');
        Assert.areEqual(3, newAndOldCasesMyRequests.newCasesSize(), 'newCases deve iniciar com três registros');
        Assert.areEqual(3, newAndOldCasesMyRequests.oldCasesSize(), 'newCases deve iniciar com três registros');
        
    }

    @isTest
    public static void addNewCaseTest()
    {
        CasesMyRequestsB2C casesMyRequests = new CasesMyRequestsB2C();
        
        Case newCase1 = DataFactory.createCase(CasesMyRequestsB2C.HELP_WITH_BILLING_RECORD_TYPE_API_NAME, 'Test Case 1', 'add new case test');
        Case newCase2 = DataFactory.createCase(CasesMyRequestsB2C.CHARGE_OF_ADDRESS_RECORD_TYPE_API_NAME, 'Test Case 2', 'add new case test');
        Case newCase3 = DataFactory.createCase(CasesMyRequestsB2C.HELP_WITH_THE_ORDER_RECORD_TYPE_API_NAME, 'Test Case 3', 'add new case test');
        
        casesMyRequests.addNewCase(newCase1);
        casesMyRequests.addNewCase(newCase2);
        casesMyRequests.addNewCase(newCase3);
        
        Assert.areEqual(3, casesMyRequests.newCasesSize(), 'newCases deve ter três registros');
    }

    @isTest
    public static void addOldCaseTest()
    {
        CasesMyRequestsB2C casesMyRequests = new CasesMyRequestsB2C();
        
        Case oldCase1 = DataFactory.createCase(CasesMyRequestsB2C.PROBLEM_WITH_PORTABILITY_RECORD_TYPE_API_NAME, 'Test Case 1', 'add old case test');
        oldCase1.Id = TestingUtils.getFakeId(Case.getSObjectType(), 100);
        casesMyRequests.addOldCase(oldCase1); 

        Case oldCase2 = DataFactory.createCase(CasesMyRequestsB2C.HELP_WITH_INVOICING_OR_BILLING_RECORD_TYPE_API_NAME, 'Test Case 2', 'add old case test');
        oldCase2.Id = TestingUtils.getFakeId(Case.getSObjectType(), 200);
        casesMyRequests.addOldCase(oldCase2);
        
        Case oldCase3 = DataFactory.createCase(CasesMyRequestsB2C.INVOICE_OR_RECHARGE_COLECTION_RECORD_TYPE_API_NAME, 'Test Case 3', 'add old case test');
        oldCase3.Id = TestingUtils.getFakeId(Case.getSObjectType(), 300);
        casesMyRequests.addOldCase(oldCase3);
        
        Assert.areEqual(3, casesMyRequests.oldCasesSize(), 'oldCases deve ter três registros');
    }

    @isTest
    public static void validadeTest()
    {
        Test.startTest();

        Account accountObj = new Account();
        accountObj.Name = 'Validate Test';
        insert accountObj;

        Asset assetObj = new Asset();
        assetObj.AccountId = accountObj.Id;
        assetObj.Name = 'Validate Test';
        insert assetObj;

        CustomerInteractionTopicTree__c topicTreeObj1 = new CustomerInteractionTopicTree__c();
        insert topicTreeObj1;

        CustomerInteractionTopicTree__c topicTreeObj2 = new CustomerInteractionTopicTree__c();
        insert topicTreeObj2;

        CasesMyRequestsB2C casesMyRequests = new CasesMyRequestsB2C();

        Case newCase1 = DataFactory.createCase(CasesMyRequestsB2C.HELP_WITH_BILLING_RECORD_TYPE_API_NAME, 'Test New Case 1', 'add new case test');
        newCase1.AccountId = accountObj.Id;
        newCase1.ComplainedAsset__c = assetObj.Id;
        newCase1.CustomerInteractionTopicTree__c = topicTreeObj1.Id;
        insert newCase1;

        Case newCase2 = DataFactory.createCase(CasesMyRequestsB2C.CHARGE_OF_ADDRESS_RECORD_TYPE_API_NAME, 'Test New Case 2', 'add new case test');
        newCase2.AccountId = accountObj.Id;
        newCase2.ComplainedAsset__c = assetObj.Id;
        newCase2.CustomerInteractionTopicTree__c = topicTreeObj2.Id;
        insert newCase2;



        Case newCase3 = DataFactory.createCase(CasesMyRequestsB2C.HELP_WITH_BILLING_RECORD_TYPE_API_NAME, 'Test New Case 3', 'add new case test');
        newCase3.AccountId = accountObj.Id;
        newCase3.ComplainedAsset__c = assetObj.Id;
        newCase3.CustomerInteractionTopicTree__c = topicTreeObj1.Id;
        casesMyRequests.addNewCase(newCase3);

        Case newCase4 = DataFactory.createCase(CasesMyRequestsB2C.CHARGE_OF_ADDRESS_RECORD_TYPE_API_NAME, 'Test New Case 4', 'add new case test');
        newCase4.AccountId = accountObj.Id;
        newCase4.ComplainedAsset__c = assetObj.Id;
        newCase4.CustomerInteractionTopicTree__c = topicTreeObj2.Id;
        casesMyRequests.addNewCase(newCase4);
        
        
        casesMyRequests.validade();

        List<Case> newCases = casesMyRequests.getNewCases();

        for (Case newCase: newCases)
        {
            System.debug(LoggingLevel.INFO, newCase.getErrors());
            Assert.isTrue(newCase.hasErrors(), 'Deve gerar erro de registro duplicado.');
        }

        Test.stopTest();
    }

    @isTest
    public static void sendNotificationForCreatedCasesTest()
    {
        CasesMyRequestsB2C casesMyRequests = new CasesMyRequestsB2C();

        Case newCase1 = DataFactory.createCase(CasesMyRequestsB2C.HELP_WITH_BILLING_RECORD_TYPE_API_NAME, 'Test New Case 1', 'add new case test');
        Case newCase2 = DataFactory.createCase(CasesMyRequestsB2C.CHARGE_OF_ADDRESS_RECORD_TYPE_API_NAME, 'Test New Case 2', 'add new case test');
        Case newCase3 = DataFactory.createCase(CasesMyRequestsB2C.HELP_WITH_THE_ORDER_RECORD_TYPE_API_NAME, 'Test New Case 3', 'add new case test');

        casesMyRequests.addNewCase(newCase1);  
        casesMyRequests.addNewCase(newCase2);
        casesMyRequests.addNewCase(newCase3);

        casesMyRequests.sendNotificationForCreatedCases();
        Assert.areEqual(3, casesMyRequests.newCasesSize());
    }

    @isTest
    public static void sendNotificationForCreatedCasesFailTest()
    {
        CasesMyRequestsB2C casesMyRequests = new CasesMyRequestsB2C();

        Case newCase1 = DataFactory.createCase(CasesMyRequestsB2C.HELP_WITH_BILLING_RECORD_TYPE_API_NAME, 'Test New Case 1', 'add new case test');
        Case newCase2 = DataFactory.createCase(CasesMyRequestsB2C.CHARGE_OF_ADDRESS_RECORD_TYPE_API_NAME, 'Test New Case 2', 'add new case test');
        Case newCase3 = DataFactory.createCase(CasesMyRequestsB2C.HELP_WITH_THE_ORDER_RECORD_TYPE_API_NAME, 'Test New Case 3', 'add new case test');

        newCase1.Id = TestingUtils.getFakeId(Case.SObjectType, 1);
        newCase2.Id = TestingUtils.getFakeId(Case.SObjectType, 2);
        newCase3.Id = TestingUtils.getFakeId(Case.SObjectType, 3);

        casesMyRequests.addNewCase(newCase1);  
        casesMyRequests.addNewCase(newCase2);
        casesMyRequests.addNewCase(newCase3);

        casesMyRequests.addOldCase(newCase1);  
        casesMyRequests.addOldCase(newCase2);
        casesMyRequests.addOldCase(newCase3);

        casesMyRequests.sendNotificationForCreatedCases();
        Assert.areEqual(3, casesMyRequests.newCasesSize());
        Assert.areEqual(3, casesMyRequests.oldCasesSize());
    }

    @isTest
    public static void sendNotificationForCasesWithUpdatedStatusTest()
    {

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

        CasesMyRequestsB2C casesMyRequests = new CasesMyRequestsB2C();

        Case caseRec1 = DataFactory.createCase(CasesMyRequestsB2C.HELP_WITH_BILLING_RECORD_TYPE_API_NAME, 'Test new Case 1', 'add new case test');
        Case caseRec2 = DataFactory.createCase(CasesMyRequestsB2C.CHARGE_OF_ADDRESS_RECORD_TYPE_API_NAME, 'Test new Case 2', 'add new case test');
        Case caseRec3 = DataFactory.createCase(CasesMyRequestsB2C.HELP_WITH_THE_ORDER_RECORD_TYPE_API_NAME, 'Test new Case 3', 'add new case test');

        caseRec1.Id = TestingUtils.getFakeId(Case.SObjectType, 1);
        caseRec1.Status = 'New';
        caseRec1.Protocol__c = '1234';
        caseRec1.AccountId = accountRec.Id;
        caseRec1.ComplainedAsset__c = assetRec.Id;

        caseRec2.Id = TestingUtils.getFakeId(Case.SObjectType, 2);
        caseRec2.Status = 'New';
        caseRec2.Protocol__c = '12345';
        caseRec2.AccountId = accountRec.Id;
        caseRec2.ComplainedAsset__c = assetRec.Id;
        
        caseRec3.Id = TestingUtils.getFakeId(Case.SObjectType, 3);
        caseRec3.Status = 'New';
        caseRec3.Protocol__c = '123456';
        caseRec3.AccountId = accountRec.Id;
        caseRec3.ComplainedAsset__c = assetRec.Id;

        casesMyRequests.addNewCase(caseRec1);  
        casesMyRequests.addNewCase(caseRec2);
        casesMyRequests.addNewCase(caseRec3);

        Case oldCaseRec1 = DataFactory.createCase(CasesMyRequestsB2C.HELP_WITH_BILLING_RECORD_TYPE_API_NAME, 'Test new Case 1', 'add new case test');
        Case oldCaseRec2 = DataFactory.createCase(CasesMyRequestsB2C.CHARGE_OF_ADDRESS_RECORD_TYPE_API_NAME, 'Test new Case 2', 'add new case test');
        Case oldCaseRec3 = DataFactory.createCase(CasesMyRequestsB2C.HELP_WITH_THE_ORDER_RECORD_TYPE_API_NAME, 'Test new Case 3', 'add new case test');

        oldCaseRec1.Id = caseRec1.Id;
        oldCaseRec1.Status = 'Closed';
        oldCaseRec1.AccountId = accountRec.Id;
        oldCaseRec1.ComplainedAsset__c = assetRec.Id;

        oldCaseRec2.Id = caseRec2.Id;
        oldCaseRec2.Status = 'Aguardando Informação';
        oldCaseRec2.AccountId = accountRec.Id;
        oldCaseRec2.ComplainedAsset__c = assetRec.Id;
        
        oldCaseRec3.Id = caseRec3.Id;
        oldCaseRec3.Status = 'Expirado';
        oldCaseRec3.AccountId = accountRec.Id;
        oldCaseRec3.ComplainedAsset__c = assetRec.Id;

        casesMyRequests.addOldCase(oldCaseRec1);  
        casesMyRequests.addOldCase(oldCaseRec2);
        casesMyRequests.addOldCase(oldCaseRec3);

        casesMyRequests.sendNotificationForCasesWithUpdatedStatus();
        Assert.areEqual(3, casesMyRequests.newCasesSize());
        Assert.areEqual(3, casesMyRequests.oldCasesSize());
    }

    @isTest
    public static void sendNotificationForCasesWithUpdatedStatusFailTest()
    {
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

        CasesMyRequestsB2C casesMyRequests = new CasesMyRequestsB2C();

        Case caseRec1 = DataFactory.createCase(CasesMyRequestsB2C.HELP_WITH_BILLING_RECORD_TYPE_API_NAME, 'Test new Case 1', 'add new case test');
        Case caseRec2 = DataFactory.createCase(CasesMyRequestsB2C.CHARGE_OF_ADDRESS_RECORD_TYPE_API_NAME, 'Test new Case 2', 'add new case test');
        Case caseRec3 = DataFactory.createCase(CasesMyRequestsB2C.HELP_WITH_THE_ORDER_RECORD_TYPE_API_NAME, 'Test new Case 3', 'add new case test');

        caseRec1.Id = TestingUtils.getFakeId(Case.SObjectType, 1);
        caseRec1.Status = 'New';
        caseRec1.AccountId = accountRec.Id;
        caseRec1.ComplainedAsset__c = assetRec.Id;

        caseRec2.Id = TestingUtils.getFakeId(Case.SObjectType, 2);
        caseRec2.Status = 'New';
        caseRec2.AccountId = accountRec.Id;
        caseRec2.ComplainedAsset__c = assetRec.Id;
        
        caseRec3.Id = TestingUtils.getFakeId(Case.SObjectType, 3);
        caseRec3.Status = 'New';
        caseRec3.AccountId = accountRec.Id;
        caseRec3.ComplainedAsset__c = assetRec.Id;

        casesMyRequests.addNewCase(caseRec1);  
        casesMyRequests.addNewCase(caseRec2);
        casesMyRequests.addNewCase(caseRec3);

        casesMyRequests.addOldCase(caseRec1);  
        casesMyRequests.addOldCase(caseRec2);
        casesMyRequests.addOldCase(caseRec3);

        casesMyRequests.sendNotificationForCasesWithUpdatedStatus();
        Assert.areEqual(3, casesMyRequests.newCasesSize());
        Assert.areEqual(3, casesMyRequests.oldCasesSize());
    }

    @isTest
    public static void sendEmailNotificationTest()
    {
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

        Case caseRec1 = DataFactory.createCase(CasesMyRequestsB2C.HELP_WITH_BILLING_RECORD_TYPE_API_NAME, 'Test Case 1', 'add case test');
        Case caseRec2 = DataFactory.createCase(CasesMyRequestsB2C.CHARGE_OF_ADDRESS_RECORD_TYPE_API_NAME, 'Test Case 2', 'add case test');
        Case caseRec3 = DataFactory.createCase(CasesMyRequestsB2C.HELP_WITH_THE_ORDER_RECORD_TYPE_API_NAME, 'Test Case 3', 'add case test');

        caseRec1.Status = 'New';
        caseRec1.AccountId = accountRec.Id;
        caseRec1.ComplainedAsset__c = assetRec.Id;
        
        caseRec2.Status = 'New';
        caseRec2.AccountId = accountRec.Id;
        caseRec2.ComplainedAsset__c = assetRec.Id;
        
        caseRec3.Status = 'New';
        caseRec3.AccountId = accountRec.Id;
        caseRec3.ComplainedAsset__c = assetRec.Id;

        List<Case> cases = new List<Case>();
        cases.add(caseRec1);
        cases.add(caseRec2);
        cases.add(caseRec3);

        CasesMyRequestsB2C.sendEmailNotification(cases);
        Assert.areEqual(3, cases.size());
    }

    @isTest
    public static void sendEmailNotificationFailTest()
    {
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

        Case caseRec1 = DataFactory.createCase(CasesMyRequestsB2C.HELP_WITH_BILLING_RECORD_TYPE_API_NAME, 'Test Case 1', 'add case test');
        Case caseRec2 = DataFactory.createCase(CasesMyRequestsB2C.CHARGE_OF_ADDRESS_RECORD_TYPE_API_NAME, 'Test Case 2', 'add case test');
        Case caseRec3 = DataFactory.createCase(CasesMyRequestsB2C.HELP_WITH_THE_ORDER_RECORD_TYPE_API_NAME, 'Test Case 3', 'add case test');

        // Caso com status invalido
        caseRec1.Status = 'Invalid Status';
        caseRec1.AccountId = accountRec.Id;
        caseRec1.ComplainedAsset__c = assetRec.Id;
        
        // Caso sem Conta e Produto vinculada
        caseRec2.Status = 'New';
        caseRec2.AccountId = null;
        caseRec2.ComplainedAsset__c = null;
        
        // Caso normal
        caseRec3.Status = 'New';
        caseRec3.AccountId = accountRec.Id;
        caseRec3.ComplainedAsset__c = assetRec.Id;

        List<Case> cases = new List<Case>();
        cases.add(caseRec1);
        cases.add(caseRec2);
        cases.add(caseRec3);

        CasesMyRequestsB2C.sendEmailNotification(cases);
        Assert.areEqual(3, cases.size());
    }
    
    public static void requestAllocationOfAttendantsForCasesWithUpdatedStatusTest() {
		Test.startTest();        
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

        Asset assetRec1 = new Asset();
        assetRec1.AccountId = accountRec.Id;
        assetRec1.Name = 'Test Asset 1';
        assetRec1.MainProductDescription__c = 'Vivo Fibra';
        insert assetRec1;
        
        Asset assetRec2 = new Asset();
        assetRec2.AccountId = accountRec.Id;
        assetRec2.Name = 'Test Asset 2';
        assetRec2.MainProductDescription__c = 'Vivo Fibra';
        insert assetRec2;
        
        // Caso sem Protocolo
        Case caseRec3 = DataFactory.createCase(CasesMyRequestsB2C.HELP_WITH_THE_ORDER_RECORD_TYPE_API_NAME, 'Test Case 3', 'add case test');
        
        caseRec3.Status = 'New';
        caseRec3.Protocol__c = '';
        caseRec3.AccountId = accountRec.Id;
        caseRec3.ComplainedAsset__c = assetRec1.Id;
        insert caseRec3;

        // Caso valido
        Case caseRec1 = DataFactory.createCase(CasesMyRequestsB2C.HELP_WITH_BILLING_RECORD_TYPE_API_NAME, 'Test Case 1', 'add case test');
        caseRec1.Status = 'New';
        caseRec1.Protocol__c = '1234';
        caseRec1.AccountId = accountRec.Id;
        caseRec1.ComplainedAsset__c = assetRec2.Id;
        insert caseRec1;
        
        caseRec3.Status = 'Cancelamento solicitado';
		caseRec1.Status = 'Em fila';
        
        update caseRec3;
        update caseRec1;
        
        Test.stopTest();        
    }

    @isTest
    public static void processFieldsTest() {
		Test.startTest();
        
        String waitingforRoutingQueueId = CasesMyRequestsB2CService.getWaitingForRoutingQueueId();
        String userId = UserInfo.getUserId();
        
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

        Asset assetRec1 = new Asset();
        assetRec1.AccountId = accountRec.Id;
        assetRec1.Name = 'Test Asset 1';
        assetRec1.MainProductDescription__c = 'Vivo Fibra';
        insert assetRec1;
        
        Case caseRec1 = DataFactory.createCase(CasesMyRequestsB2C.HELP_WITH_THE_ORDER_RECORD_TYPE_API_NAME, 'Test Case 3', 'add case test');
        caseRec1.OwnerId = userId;
        caseRec1.AccountId = accountRec.Id;
        caseRec1.ComplainedAsset__c = assetRec1.Id;
        caseRec1.Status = 'New';
        caseRec1.Protocol__c = '12345';
        insert caseRec1;
        
        Case insertedCaseRec1 = [SELECT Id, Status, OwnerId FROM Case WHERE Id =: caseRec1.Id];
        Assert.areEqual('Em fila', insertedCaseRec1.Status);
        Assert.areEqual(waitingforRoutingQueueId, insertedCaseRec1.OwnerId, 'Mudança do Status para "Em fila" e Owner para "WaitingforRouting"');
        
        
        caseRec1.OwnerId = userId;
        update caseRec1;

        caseRec1.Status = 'Aguardando informação';
        update caseRec1;
        
        Case insertedCaseRec2 = [SELECT Id, Status, OwnerId FROM Case WHERE Id =: caseRec1.Id];
        Assert.areEqual('Aguardando informação', insertedCaseRec2.Status);
        Assert.areEqual(waitingforRoutingQueueId, insertedCaseRec2.OwnerId, 'Mudança do Status "Aguardando informação" e Owner para "WaitingforRouting"');
        
        

        caseRec1.OwnerId = userId;
        update caseRec1;

        caseRec1.Status = 'Escalated';
        update caseRec1;
        
        Case insertedCaseRec3 = [SELECT Id, Status, OwnerId FROM Case WHERE Id =: caseRec1.Id];
        Assert.areEqual('Escalated', insertedCaseRec3.Status);
        Assert.areEqual(waitingforRoutingQueueId, insertedCaseRec3.OwnerId, 'Mudança do Status "Escalated" e Owner para "WaitingforRouting"');
        
        
        
        caseRec1.OwnerId = userId;
        update caseRec1;

        caseRec1.Status = 'Cancelamento solicitado';
        update caseRec1;
        
        Case insertedCaseRec4 = [SELECT Id, Status, OwnerId FROM Case WHERE Id =: caseRec1.Id];
        Assert.areEqual('Cancelamento solicitado', insertedCaseRec4.Status);
        Assert.areEqual(waitingforRoutingQueueId, insertedCaseRec4.OwnerId, 'Mudança do Status "Cancelamento solicitado" e Owner para "WaitingforRouting"');
        
        Test.stopTest();
    }
}