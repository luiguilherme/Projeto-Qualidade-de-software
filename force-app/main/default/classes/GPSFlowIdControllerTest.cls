@isTest
public class GPSFlowIdControllerTest {                          
    @testSetup
    static void setup() {
        Account lAccount = DataFactory.createAccount();
        insert lAccount;

        insert new Webservice__c(
            Name = 'GPSQueryServiceFlowsCallout',
            Endpoint__c = 'http://svuxqa1soa134:7001/gps/crm/api/v3/diagnostic/search/',
            SubscriptionKey__c = 'd1ca8d57a2984db88f01c9ce7b5862e2',
            HasAuthToken__c = true,
            Headers__c = 'sistemaOrigem:LEGADO'
        );
        
        insert new CustomerInteractionTopicTree__c(
            Name = 'Teste de Fluxo de Atendimento',
            Active__c = true,
            GPSId__c = '',
            OperatorSegment__c = 'Gold',
            ProductType__c = 'Fixed',
            Instance__c = 'Banda Larga;TV',
			Type__c = 'Palito'            
        );

        insert new CustomerInteractionTopicTree__c(
            Name = 'Teste de Fluxo de Atendimento 2',
            Active__c = true,
            GPSId__c = '',
            OperatorSegment__c = '',
            Instance__c = ''
        );
        
        WebServiceTestFactory.start().authOAuthProvider().create();
    }

    @isTest
    public static void gpsFlowIdGetListFlowInvalidTest() {                
        Test.startTest();

        Test.setMock(HttpCalloutMock.class, new GPSFlowIdCalloutMock());        
        Map<String, Object> mapResult = GPSFlowIdController.getGPSFlow(null);
        
        Test.stopTest();        

        System.assertEquals(Label.ServiceFlowEndFlowValidationMessage, mapResult.get('error'));
    }
    
    @isTest
    public static void gpsFlowIdGetListFlowTest() {
        CustomerInteractionTopicTree__c customerInteractionTopicTree = [SELECT Id, Instance__c, GpsId__c, GpsFlow__c FROM CustomerInteractionTopicTree__c LIMIT 1];
        
        Test.startTest();

        Test.setMock(HttpCalloutMock.class, new GPSFlowIdCalloutMock());
        Map<String, Object> mapResult = GPSFlowIdController.getGPSFlow(customerInteractionTopicTree.Id);
        
        Test.stopTest();        

        System.assertNotEquals(null, mapResult.get('success'));
    }
    
    @isTest
    public static void gpsFlowIdUpdateFlowIdTest() {
        CustomerInteractionTopicTree__c customerInteractionTopicTree = [SELECT Id, Instance__c, GpsId__c, GpsFlow__c FROM CustomerInteractionTopicTree__c LIMIT 1];
        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new GPSFlowIdCalloutMock());
        
        GPSFlowIdController.updateGPSFlowId(customerInteractionTopicTree.Id, '1234', 'Fluxo Teste');
        Test.stopTest();
        
        CustomerInteractionTopicTree__c customerInteractionTopicTreeFlowUpdated = [SELECT Id, GpsId__c, GpsFlow__c FROM CustomerInteractionTopicTree__c LIMIT 1];
        
        System.assertEquals('Fluxo Teste', customerInteractionTopicTreeFlowUpdated.GPSFlow__c);
        System.assertEquals('1234', customerInteractionTopicTreeFlowUpdated.GPSId__c);
    }
}