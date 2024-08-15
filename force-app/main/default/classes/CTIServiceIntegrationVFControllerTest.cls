@isTest
public class CTIServiceIntegrationVFControllerTest {
    
	@testSetup
    static void setup(){
        Account nuAcc = DataFactory.createAccount();
        insert nuAcc;

        Account fixedAccount = DataFactory.createAccount();
        fixedAccount.Name = 'Fixed Test Account 1';
        fixedAccount.ExternalId__c = '899941326813';
        fixedAccount.DocumentNumber__c = '11111111111113';
        insert fixedAccount;

        Account mobileAccount = DataFactory.createAccount();
        mobileAccount.Name = 'Mobile Test Account';
        mobileAccount.ExternalId__c = '899941326812';
        mobileAccount.DocumentNumber__c = '11111111111112';
        insert mobileAccount;
        
        Case nuCase = new Case();
        nuCase.AccountId = nuAcc.Id;
        nuCase.Origin = 'Transfer';
        
        insert nuCase;
        
        vlocity_cmt__CustomerInteraction__c nuCustomerInteraction = DataFactory.createCustomerInteraction(nuAcc.Id);
        nuCustomerInteraction.IdentifierNumber__c = '123123';
        insert nuCustomerInteraction;

        vlocity_cmt__CustomerInteraction__c fixedCustomerInteraction = DataFactory.createCustomerInteraction(fixedAccount.Id);
        fixedCustomerInteraction.IdentifierNumber__c = '1231234';
        insert fixedCustomerInteraction;

        insert new CustomerInteractionTopicTree__c( Type__c = 'Palito' );

        Asset testAsset = DataFactory.createAsset(nuAcc.Id, 'Fixa');
        insert testAsset;

        Asset fixedTestAssetOne = DataFactory.createAsset(fixedAccount.Id, 'Fixa');
        fixedTestAssetOne.vlocity_cmt__ServiceIdentifier__c = '1231234';
        fixedTestAssetOne.SourceSystem__c = 'SIEBEL';
        insert fixedTestAssetOne;

        Asset mobileAsset = DataFactory.createAsset(nuAcc.Id, 'Movel');
        mobileAsset.vlocity_cmt__ServiceIdentifier__c = '123123';
        mobileAsset.SourceSystem__c = 'NEXT';
        insert mobileAsset;

        Id mobileRTId = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get('CallDroped').getrecordTypeId();
        insert new Case (
            Origin = 'SFA Script - Next',
            Status = 'Aberto',
            RecordTypeId = mobileRTId,
            AccountId = mobileAccount.Id
        );

        insert new Webservice__c(
            Name = 'ServiceFlowGPSCreateSSCallout',
            Endpoint__c = 'http://test:7001/gps/crm/api/v3/diagnostic/',
            SubscriptionKey__c = 'd1ca8d57a2984db88f01c9ce7b5862e2',
            HasAuthToken__c = true,
            Headers__c = 'sistemaOrigem:LEGADO'
        );

        insert new GenericOptionsLists__c(
            Name = 'LigacaoCaiu',
            Code__c = 'LIG_CAIU',
            Description__c = 'Teste',
            Description2__c = 'Teste2',            
            APIDateTime__c = Date.today(),
            UsedIn__c = 'ServiceContainer',
            Active__c = true
        );
    }
    
    @isTest
    public static void vfTest(){
        Case nuCase = [SELECT id FROM Case LIMIT 1];
        
        Test.StartTest();
 
             PageReference pageRef = Page.CTIServiceIntegration;
                Test.setCurrentPage(pageRef);
                
                ApexPages.currentPage().getParameters().put('referer', 'teste/teste');
              
             	CTIServiceIntegrationVFController controller = new CTIServiceIntegrationVFController();
               	String accId = CTIServiceIntegrationVFController.getAccountId(nuCase.Id);
         
               	controller.init();    
            	
        		
             System.assert(accId != null); //assertion
        Test.StopTest();
    }

    @isTest
    public static void shouldSendCaseToQueue(){
        Case testCase = [SELECT id FROM Case LIMIT 1];

        Test.StartTest();
            CTIServiceIntegrationVFController controller = new CTIServiceIntegrationVFController();
            Map<String, String> payload = new Map<String, String>();
            payload.put('CaseId__c', testCase.Id);
            Boolean response = CTIServiceIntegrationVFController.sendCaseToQueue(payload);

            System.assert(response == true, 'Erro ao enviar caso à fila de CTI.');
        Test.StopTest();
    }

    @isTest
    public static void shouldSetCaseOwnerAsCurrentUser(){
        Case testCase = [SELECT id FROM Case LIMIT 1];

        Test.StartTest();
            CTIServiceIntegrationVFController controller = new CTIServiceIntegrationVFController();
            Map<String, String> payload = new Map<String, String>();
            payload.put('CaseId__c', testCase.Id);
            Boolean response = CTIServiceIntegrationVFController.setCaseOwnerAsCurrentUser(payload);

            System.assert(response == true, 'Erro ao definir owner do caso ao usuário atual.');
        Test.StopTest();
    }

    @isTest
    public static void shouldNotSendCaseToQueue(){
        Test.StartTest();
            CTIServiceIntegrationVFController controller = new CTIServiceIntegrationVFController();
            Map<String, String> payload = new Map<String, String>();
            Boolean response = CTIServiceIntegrationVFController.sendCaseToQueue(payload);

            System.assert(response == false, 'Caso inválido não deve ser enviado à fila de CTI.');
        Test.StopTest();
    }

    @isTest
    public static void shouldUpdateCaseWdeDirectTransfer(){
        Case testCase = [SELECT id FROM Case LIMIT 1];

        Test.StartTest();
            CTIServiceIntegrationVFController controller = new CTIServiceIntegrationVFController();
            Map<String, String> payload = new Map<String, String>();
            payload.put('CaseId__c', testCase.Id);            
            payload.put('OperationType__c', 'DirectTransfer');
            Boolean response = CTIServiceIntegrationVFController.updateWdeCase(payload);

            System.assert(response == true, 'Erro ao atualizar o caso com operação DirectTransfer.');
        Test.StopTest();
    }

    @isTest
    public static void shouldUpdateCaseWdePerformConsult(){
        Case testCase = [SELECT id FROM Case LIMIT 1];

        Test.StartTest();
            CTIServiceIntegrationVFController controller = new CTIServiceIntegrationVFController();
            Map<String, String> payload = new Map<String, String>();
            payload.put('CaseId__c', testCase.Id);        	
            payload.put('OperationType__c', 'PerformConsult');
            payload.put('OriginCell__c', 'XYZ');
            payload.put('DestinyCell__c', 'ZYX');
            Boolean response = CTIServiceIntegrationVFController.updateWdeCase(payload);

            System.assert(response == true, 'Erro ao atualizar o caso com operação PerformConsult.');
        Test.StopTest();
    }

    @isTest
    public static void shouldUpdateCaseWdeTalkToTheCustomer(){
        Case testCase = [SELECT id FROM Case LIMIT 1];

        Test.StartTest();
            CTIServiceIntegrationVFController controller = new CTIServiceIntegrationVFController();
            Map<String, String> payload = new Map<String, String>();
            payload.put('CaseId__c', testCase.Id);        	
            payload.put('OperationType__c', 'TalkToTheCustomer');
            Boolean response = CTIServiceIntegrationVFController.updateWdeCase(payload);

            System.assert(response == true, 'Erro ao atualizar o caso com operação TalkToTheCustomer.');
        Test.StopTest();
    }

    @isTest
    public static void shouldUpdateCaseWdeFinalizeConsult(){
        Case testCase = [SELECT id FROM Case LIMIT 1];

        Test.StartTest();
            CTIServiceIntegrationVFController controller = new CTIServiceIntegrationVFController();
            Map<String, String> payload = new Map<String, String>();
            payload.put('CaseId__c', testCase.Id);        	
            payload.put('OperationType__c', 'FinalizeConsult');
            Boolean response = CTIServiceIntegrationVFController.updateWdeCase(payload);

            System.assert(response == true, 'Erro ao atualizar o caso com operação FinalizeConsult.');
        Test.StopTest();
    }

    @isTest
    public static void shouldUpdateCaseWdeFinishAssistedTransfer(){
        Case testCase = [SELECT id FROM Case LIMIT 1];

        Test.StartTest();
            CTIServiceIntegrationVFController controller = new CTIServiceIntegrationVFController();
            Map<String, String> payload = new Map<String, String>();
            payload.put('CaseId__c', testCase.Id);        	
            payload.put('OperationType__c', 'FinishAssistedTransfer');
            Boolean response = CTIServiceIntegrationVFController.updateWdeCase(payload);

            System.assert(response == true, 'Erro ao atualizar o caso com operação FinishAssistedTransfer.');
        Test.StopTest();
    }

    @isTest
    public static void shouldUpdateCaseWdeCallDropped(){
        Case testCase = [SELECT id FROM Case LIMIT 1];
        Asset testAsset = [SELECT Id FROM Asset LIMIT 1];
        CustomerInteractionTopicTree__c testTopicTree = [SELECT Id FROM CustomerInteractionTopicTree__c LIMIT 1];

        Test.StartTest();
            Test.setMock(HttpCalloutMock.class, new ServiceFlowGPSCalloutMock());
            CTIServiceIntegrationVFController controller = new CTIServiceIntegrationVFController();
            Map<String, String> payload = new Map<String, String>();
            payload.put('CaseId__c', testCase.Id);        	
            payload.put('OperationType__c', 'CallDropped');
            payload.put('selectedAssetInstance', 'XYAZ');
            payload.put('selectedAssetId', testAsset.Id);
            payload.put('selectedTopicTreeId', testTopicTree.Id); 	
            Boolean response = CTIServiceIntegrationVFController.updateWdeCase(payload);

            System.assert(response == true, 'Erro ao atualizar o caso com operação CallDropped.');
        Test.StopTest();
    }

    @isTest
    public static void shouldCreateCase(){        
        Asset testAsset = [SELECT Id FROM Asset LIMIT 1];
        Account testAccount = [SELECT id FROM Account LIMIT 1];
        vlocity_cmt__CustomerInteraction__c testCustomerInteraction = [SELECT Id FROM vlocity_cmt__CustomerInteraction__c LIMIT 1];


        Test.StartTest();
            Test.setMock(HttpCalloutMock.class, new ServiceFlowGPSCalloutMock());
            CTIServiceIntegrationVFController controller = new CTIServiceIntegrationVFController();
            Map<String, String> payload = new Map<String, String>();
            payload.put('CustomerInteractionId__c', testCustomerInteraction.Id);
        	//payload.put('AccountId__c', testAccount.Id);        	
            //payload.put('OperationType__c', 'CallDropped');
            //payload.put('selectedAssetInstance', 'XYAZ');
            //payload.put('selectedAssetId', testAsset.Id);    
            Boolean response = CTIServiceIntegrationVFController.createCase(payload);

            System.assert(response == true, 'Erro ao criar o caso.');
        Test.StopTest();
    }

    @isTest
    public static void shouldCreateCaseOnWDECallDrop() {
        CTIServiceIntegrationVFController serviceController = new CTIServiceIntegrationVFController();
        Map<String, Object> payloadWithoutLine = new Map<String, String>();
        Map<String, Object> payloadFullWithoutLine = new Map<String, String>();
        Map<String, Object> payloadWithLine = new Map<String, String>();

        Account account = [SELECT Id FROM Account WHERE Name = 'Mobile Test Account' LIMIT 1];
        vlocity_cmt__CustomerInteraction__c customerInteraction = [SELECT Id, Name FROM vlocity_cmt__CustomerInteraction__c WHERE Name = 'Test Customer Interaction' LIMIT 1];
        Asset mobileAsset = [SELECT Id, vlocity_cmt__ServiceIdentifier__c FROM Asset WHERE vlocity_cmt__ServiceIdentifier__c = '123123'];

        vlocity_cmt__CustomerInteraction__c mobileCustomerInteraction = DataFactory.createCustomerInteraction(account.Id);
        insert mobileCustomerInteraction;

        payloadWithoutLine.put('Line', '{Line}');
        payloadWithoutLine.put('CustomerInteractionId__c', mobileCustomerInteraction.Id);
        
        payloadFullWithoutLine.put('Line', '{Line}');
        payloadFullWithoutLine.put('CustomerInteractionId__c', customerInteraction.Id);

        payloadWithLine.put('Line', mobileAsset.Id);
        payloadWithLine.put('CustomerInteractionId__c', customerInteraction.Id);

        Test.startTest();

        Map<String, Object> resultWithoutLine = CTIServiceIntegrationVFController.createMobileNextDisputeCase(payloadWithoutLine);
        Map<String, Object> resultFullWithoutLine = CTIServiceIntegrationVFController.createMobileNextDisputeCase(payloadFullWithoutLine);
        Map<String, Object> resultWithLine = CTIServiceIntegrationVFController.createMobileNextDisputeCase(payloadWithLine);

        Test.stopTest();

        System.assertEquals(false, resultWithoutLine.get('error'));
        System.assertEquals(false, resultFullWithoutLine.get('error'));
        System.assertEquals(false, resultWithLine.get('error'));
    }

    @isTest
    public static void shouldTriggerExceptionOnWDECallDrop() {
        CTIServiceIntegrationVFController serviceController = new CTIServiceIntegrationVFController();
        Map<String, Object> payloadCreate = new Map<String, String>();
        Map<String, Object> payloadUpdate = new Map<String, String>();

        vlocity_cmt__CustomerInteraction__c customerInteraction = [SELECT Id, Name FROM vlocity_cmt__CustomerInteraction__c WHERE Name = 'Test Customer Interaction' LIMIT 1];

        payloadCreate.put('Line', customerInteraction.Id);
        payloadCreate.put('CustomerInteractionId__c', customerInteraction.Id);

        Test.startTest();

        Map<String, Object> resultCreate = CTIServiceIntegrationVFController.createMobileNextDisputeCase(payloadCreate);
        Map<String, Object> resultUpdate = CTIServiceIntegrationVFController.updateMobileNextDisputeCase(payloadUpdate);

        Test.stopTest();

        System.assertEquals(true, resultCreate.get('error'));
        System.assertEquals(true, resultCreate.get('error'));
    }

    @isTest
    public static void shouldUpdateCaseOnWDECallDrop() {
        Account mobileAccount = [SELECT Id FROM Account WHERE ExternalId__c = '899941326812' LIMIT 1];
        Case originalCase = [SELECT Id FROM Case WHERE AccountId =: mobileAccount.Id LIMIT 1];
        
        Map<String, Object> payload = new Map<String, String>();
        payload.put('CaseId__c', originalCase.Id);
        
        Test.startTest();
        
        Map<String, Object> response = CTIServiceIntegrationVFController.updateMobileNextDisputeCase(payload);
        
        Test.stopTest();

        Case updatedCase = [SELECT Id, Status, Closure__c FROM Case WHERE AccountId =: mobileAccount.Id LIMIT 1];
        
        System.assertEquals(false, response.get('error'));
        System.assertEquals(true, response.get('updatedCase'));

        System.assertEquals('CallDropped', updatedCase.Status);
        System.assertEquals('Informação > Atendimento > Ligação > Caiu', updatedCase.Closure__c);
    }

    @isTest
    public static void shouldCreateCaseWithParameters(){

        vlocity_cmt__CustomerInteraction__c testCustomerInteraction = [SELECT Id FROM vlocity_cmt__CustomerInteraction__c WHERE IdentifierNumber__c = '1231234' LIMIT 1];

        Test.setMock(HttpCalloutMock.class, new ServiceFlowGPSCalloutMock());
        
        Test.StartTest();

        CTIServiceIntegrationVFController controller = new CTIServiceIntegrationVFController();
        Map<String, String> payload = new Map<String, String>();
        payload.put('CustomerInteractionId__c', testCustomerInteraction.Id);
        Boolean response = CTIServiceIntegrationVFController.createCase(payload);
        
        Test.StopTest();

        System.assert(response == true, 'Erro ao criar o caso.');
    }
}