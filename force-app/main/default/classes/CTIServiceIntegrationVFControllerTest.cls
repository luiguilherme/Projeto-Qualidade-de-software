@isTest
public class CTIServiceIntegrationVFControllerTest {
    
	@testSetup
    static void setup(){
        Account nuAcc = DataFactory.createAccount();
        
        insert nuAcc;      
        
        Case nuCase = new Case();
        nuCase.AccountId = nuAcc.Id;
        nuCase.Origin = 'Transfer';        
        
        insert nuCase;
        
        vlocity_cmt__CustomerInteraction__c nuCustomerInteraction = DataFactory.createCustomerInteraction(nuAcc.Id);
        insert nuCustomerInteraction;

        insert new CustomerInteractionTopicTree__c( Type__c = 'Palito' );

        Asset testAsset = DataFactory.createAsset(nuAcc.Id, 'Fixa');
        insert testAsset;

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
}