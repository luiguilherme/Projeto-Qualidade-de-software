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
@isTest
private class CasesTriggerHandlerTest
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
    static void isBeforeInsertTest()
    {   
        Map<Id, Case> oldCases = new Map<Id, Case>([SELECT Id, RecordTypeId FROM Case LIMIT 3]);
        List<Case> newCases = new List<Case>();

        Case newCase1 = DataFactory.createCase(CasesMyRequestsB2C.HELP_WITH_BILLING_RECORD_TYPE_API_NAME, 'Test Case 1', 'add new case test');
        Case newCase2 = DataFactory.createCase(CasesMyRequestsB2C.CHARGE_OF_ADDRESS_RECORD_TYPE_API_NAME, 'Test Case 2', 'add new case test');
        Case newCase3 = DataFactory.createCase(CasesMyRequestsB2C.HELP_WITH_THE_ORDER_RECORD_TYPE_API_NAME, 'Test Case 3', 'add new case test');

        newCases.add(newCase1);
        newCases.add(newCase2);
        newCases.add(newCase3);

        CasesTriggerHandler casesTrigger = new CasesTriggerHandler(newCases, oldCases);

        casesTrigger.isBeforeInsert();

        Assert.isTrue(casesTrigger != null);
    }

    @isTest
    static void isAfterInsertTest()
    { 
        Map<Id, Case> oldCases = new Map<Id, Case>([SELECT Id, RecordTypeId FROM Case LIMIT 3]);
        List<Case> newCases = new List<Case>();

        Case newCase1 = DataFactory.createCase(CasesMyRequestsB2C.HELP_WITH_BILLING_RECORD_TYPE_API_NAME, 'Test Case 1', 'add new case test');
        Case newCase2 = DataFactory.createCase(CasesMyRequestsB2C.CHARGE_OF_ADDRESS_RECORD_TYPE_API_NAME, 'Test Case 2', 'add new case test');
        Case newCase3 = DataFactory.createCase(CasesMyRequestsB2C.HELP_WITH_THE_ORDER_RECORD_TYPE_API_NAME, 'Test Case 3', 'add new case test');

        newCases.add(newCase1);
        newCases.add(newCase2);
        newCases.add(newCase3);

        CasesTriggerHandler casesTrigger = new CasesTriggerHandler(newCases, oldCases);

        casesTrigger.isAfterInsert();

        Assert.isTrue(casesTrigger != null);
    }

    @isTest
    static void isAfterInsertUpdateRelatedInteractionTopicWithCaseIdTest() {
        // Resolves account
        Account accountTest = DataFactory.createConsumerAccount();

        insert accountTest;

        // Resolves Customer Interaction
        vlocity_cmt__CustomerInteraction__c customerInteractionTest = 		
            DataFactory.createCustomerInteraction(accountTest.Id);
    
        insert customerInteractionTest;

        // Resolves Customer Interaction Topic
        // Note that the CaseId is not being assigned
        vlocity_cmt__CustomerInteractionTopic__c interactionTopicTest = 
            new vlocity_cmt__CustomerInteractionTopic__c(
                vlocity_cmt__CustomerInteractionId__c = customerInteractionTest.Id
            );

        insert interactionTopicTest;

        // Resolves Cases
        List<Case> ltNewCasesTests = new List<Case>();
        Map<Id, Case> ltOldCasesTest = new Map<Id, Case>([SELECT Id, RecordTypeId FROM Case LIMIT 1]);

        Case caseTest = DataFactory.createCase(
            'Service', 
            'Expectation Management Case Test', 
            'Add new case test for test Trigger updateRelatedInteractionTopicWithCaseId method in CustomerInteractionTopicService class'
        );

        caseTest.CustomerInteractionTopic__c = interactionTopicTest.Id;

        ltNewCasesTests.add(caseTest);

        insert ltNewCasesTests;

        // Verify
        CasesTriggerHandler casesTrigger = new CasesTriggerHandler(ltNewCasesTests, ltOldCasesTest);

        casesTrigger.isAfterInsert();

        Assert.isTrue(casesTrigger != null);   
    }

    @isTest
    static void isAfterUpdateTest()
    { 
        List<CanalNotificacoesMinhasSolicitacoes__mdt> canais = new List<CanalNotificacoesMinhasSolicitacoes__mdt>();
        CanalNotificacoesMinhasSolicitacoes canalSelecionado = (CanalNotificacoesMinhasSolicitacoes) Test.createStub(
            CanalNotificacoesMinhasSolicitacoes.class,
            new CanalNotificacoesMinhasSolicitacoesStub(canais)
        );
        NotificadorMinhasSolicitacoes.canalSelector = canalSelecionado;
        
        Case oldCase1 = DataFactory.createCase(CasesMyRequestsB2C.HELP_WITH_BILLING_RECORD_TYPE_API_NAME, 'Test Case 1 After Update', 'add new case test');
        oldCase1.Id = TestingUtils.getFakeId(Case.getSObjectType(), 1);
        oldCase1.Status = 'New';

        Case oldCase2 = DataFactory.createCase(CasesMyRequestsB2C.HELP_WITH_BILLING_RECORD_TYPE_API_NAME, 'Test Case 2 After Update', 'add new case test');
        oldCase2.Id = TestingUtils.getFakeId(Case.getSObjectType(), 2);
        oldCase2.Status = 'New';

        Case oldCase3 = DataFactory.createCase(CasesMyRequestsB2C.HELP_WITH_BILLING_RECORD_TYPE_API_NAME, 'Test Case 3 After Update', 'add new case test');
        oldCase3.Id = TestingUtils.getFakeId(Case.getSObjectType(), 3);
        oldCase3.Status = 'New';

        Map<Id, Case> oldCases = new Map<Id, Case>();
        oldCases.put(oldCase1.Id, oldCase1);
        oldCases.put(oldCase2.Id, oldCase2);
        oldCases.put(oldCase3.Id, oldCase3);


        Case newCase1 = DataFactory.createCase(CasesMyRequestsB2C.HELP_WITH_BILLING_RECORD_TYPE_API_NAME, 'Test Case 1 After Update', 'add new case test');
        newCase1.Id = oldCase1.Id;
        newCase1.Status = 'Closed';

        Case newCase2 = DataFactory.createCase(CasesMyRequestsB2C.CHARGE_OF_ADDRESS_RECORD_TYPE_API_NAME, 'Test Case 2 After Update', 'add new case test');
        newCase2.Id = oldCase2.Id;
        newCase2.Status = 'Closed';

        Case newCase3 = DataFactory.createCase(CasesMyRequestsB2C.HELP_WITH_THE_ORDER_RECORD_TYPE_API_NAME, 'Test Case 3 After Update', 'add new case test');
        newCase3.Id = oldCase3.Id;
        newCase3.Status = 'Closed';

        List<Case> newCases = new List<Case>();
        newCases.add(newCase1);
        newCases.add(newCase2);
        newCases.add(newCase3);
        

        CasesTriggerHandler casesTrigger = new CasesTriggerHandler(newCases, oldCases);

        casesTrigger.isAfterUpdate();

        Assert.isTrue(casesTrigger != null);
    }
}