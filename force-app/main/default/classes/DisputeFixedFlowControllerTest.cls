@IsTest(SeeAllData=true)
public class DisputeFixedFlowControllerTest {
    @isTest
    public static void DisputeCheckScopeTest() {
        UserRole userR = [SELECT Id FROM UserRole WHERE DeveloperName ='AtendimentoGoldOperadorFixa'];
        Profile p = [SELECT Id FROM Profile WHERE Name='AdministracaoSistema'];
        
        User u = new User(Alias = 'SysAdmin', Email='stdstdteste@teste.com',
                          EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
                          LocaleSidKey='en_US', ProfileId = p.Id,UserRoleId = userR.Id,
                          TimeZoneSidKey='America/Sao_Paulo', UserName='stdteste@teste.com');
        Database.insert(u);
        
        System.runAs(u) {
            GeneralSetting__c gsNu = new GeneralSetting__c();
            gsNu.Name = 'Contestação';
            gsNu.OperatorSegment__c = 'Gold;Silver';
            gsNu.RecordTypeId = Schema.SObjectType.GeneralSetting__c.getRecordTypeInfosByDeveloperName().get('ServiceGroupSetting').getRecordTypeId();
            insert gsNu;
            
            Test.startTest();        
            DisputeFixedFlowController.DisputeCheckScopeInputs inputNu = new DisputeFixedFlowController.DisputeCheckScopeInputs();
            inputNu.Name = 'Contestação';
            inputNu.recortTypeName = 'ServiceGroupSetting';
            LIST<DisputeFixedFlowController.DisputeCheckScopeInputs> parameters = new LIST<DisputeFixedFlowController.DisputeCheckScopeInputs>();
            parameters.add(inputNu);
            LIST<String> response = DisputeFixedFlowController.DisputeCheckScope(parameters);
         
            Test.stopTest();
            
            System.assertEquals('Sim', response[0]);
        }
    }
        
    @isTest
    public static void restartFlowTest() {
        Case nuCase = new Case();
        insert nuCase;

        DisputedInvoice__c nuInvoice = new DisputedInvoice__c();
        nuInvoice.case__c = nuCase.Id;
        insert nuInvoice;

        DisputedItem__c nuItem = new DisputedItem__c();
        nuItem.CaseId__c = nuCase.Id;
        insert nuItem;
        
        FlowExecutionStepHistory__c nuStep = new FlowExecutionStepHistory__c();
        nuStep.CaseId__c = nuCase.Id;
        insert nuStep;
        
        Test.startTest();
            DisputeFixedFlowController.restartFlow(nuCase.Id);
        Test.stopTest();
        
    }

    @isTest
    public static void getParamsByAccountIdTest() {
        Account nuAcc = new Account();
        nuAcc.Name = 'Teste';
        insert nuAcc;
        
        Asset nuAsset = new Asset();
        nuAsset.name = 'Teste asset';
        nuAsset.SourceSystem__c = 'NEXT';
        nuAsset.ProductType__c = 'Voz';
        nuAsset.vlocity_cmt__ServiceIdentifier__c = '11991111111';
        nuAsset.AccountId = nuAcc.Id;
        insert nuAsset;

        Test.startTest();
            Map<String,String> result =  DisputeFixedFlowController.getParamsByAccountId(nuAcc.Id);
        Test.stopTest();

        System.assertEquals('11991111111', result.get('customerPhoneNumber'));
    }

    @isTest
    public static void getCaseParamTest() {
        Case nuCase = new Case();
        insert nuCase;

        Test.startTest();
            Case result =  DisputeFixedFlowController.getCaseParam(nuCase.Id);
        Test.stopTest();

        System.assert(result.Id != null);
    }

    @isTest
    public static void getCustomerInteractionsTest() {
        vlocity_cmt__CustomerInteraction__c nuCI = new vlocity_cmt__CustomerInteraction__c();
        insert nuCI;

        Case nuCase = new Case();
        nuCase.CustomerInteractionId__c = nuCI.Id;
        nuCase.Protocol__c = 'testeNumber';
        insert nuCase;

        vlocity_cmt__CustomerInteractionTopic__c nuCIT = new vlocity_cmt__CustomerInteractionTopic__c();
        nuCIT.vlocity_cmt__CustomerInteractionId__c = nuCI.Id;
        nuCIT.vlocity_cmt__CaseId__c = nuCase.Id;
        insert nuCIT;

        Test.startTest();
            Map<String,String> result =  DisputeFixedFlowController.getCustomerInteractions(nuCase.Id);
        Test.stopTest();

        System.assertEquals(nuCI.Id, result.get('interactionId'));
    }

}