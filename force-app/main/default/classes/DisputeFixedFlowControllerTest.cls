@IsTest(SeeAllData=true)
public class DisputeFixedFlowControllerTest {
    @isTest
    public static void DisputeCheckScopeTest() {
        UserRole userR = [SELECT Id FROM UserRole WHERE DeveloperName ='AtendimentoGoldOperadorFixa'];
        Profile p = [SELECT Id FROM Profile WHERE Name='Administrador do sistema'];
        
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
}