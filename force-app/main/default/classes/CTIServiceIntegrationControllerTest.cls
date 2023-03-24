@isTest
public class CTIServiceIntegrationControllerTest {
	
    @testSetup
    public static void setup(){
        Account acc = DataFactory.createAccount();
        insert acc;
    }

    @isTest
    public static void createCTICaseTest1(){
        String accountId = [SELECT Id FROM Account LIMIT 1].id;
        
        Case transferCase = new Case();
        
        transferCase.AccountId = accountId;
        transferCase.Status = 'InTransfer';
        transferCase.Origin = 'Transfer';
        
        insert transferCase;
        
        String str = JSON.serialize(transferCase);
        
        test.startTest();
        	String caseId = CTIServiceIntegrationController.createCTICase(str, 'CTIService', transferCase.Id, 'Sem Observação');
        test.stopTest();
        
        Case newCase = [SELECT id FROM Case WHERE Id =: caseId];
        
        System.assert(newCase != null);
        
    }
    
    @isTest
    public static void createCTICaseTest2(){
        
        String accountId = [SELECT Id FROM Account LIMIT 1].id;
        
        Case transferCase = new Case();
        
        transferCase.AccountId = accountId;
        transferCase.Status = 'Closed';
        transferCase.Origin = 'Ura';
        
        insert transferCase;
        
        Case transferCase2 = new Case();
        
        transferCase2.AccountId = accountId;
        
        String str = JSON.serialize(transferCase2);
        
        test.startTest();
        	String caseId = CTIServiceIntegrationController.createCTICase(str, 'CTIService', transferCase.Id, 'Sem Observação');
        test.stopTest();
        
        Case newCase = [SELECT id, Description FROM Case WHERE Id =: caseID];
        
        System.assertEquals(newCase.Description,'Sem Observação');
    }
    
    @isTest
    public static void createCTICaseTest3(){
         test.startTest();
            try {
                String caseId = CTIServiceIntegrationController.createCTICase(null, 'CTIService', null, 'Sem Observação');
            } catch (Exception e) {
                String expectedException = 'Script-thrown exception';
                System.assertEquals(expectedException, e.getMessage());
            }
        test.stopTest();

    }

    @isTest
    public static void closeCTICaseTest() {
        String accountId = [SELECT Id FROM Account LIMIT 1].id;
        
        Case transferCase = new Case();
        
        transferCase.AccountId = accountId;
        transferCase.Status = 'InTransfer';
        transferCase.Origin = 'Transfer';
        
        insert transferCase;

        String protocol = 'protocol';

        test.startTest();

        CTIServiceIntegrationController.closeCTITransferCase(transferCase.Id, protocol);

        Case closedCase = [SELECT Status FROM Case WHERE Id =: transferCase.Id LIMIT 1][0];
        
        System.assertEquals('Closed', closedCase.Status);

        test.stopTest();
    }

    @isTest
    public static void closeCTICaseTestWithoutCaseId() {
        String accountId = [SELECT Id FROM Account LIMIT 1].id;

        String protocol = 'protocol';

        test.startTest();

        try {
            CTIServiceIntegrationController.closeCTITransferCase('', protocol);
        } catch (Exception e) {
            String expectedException = 'Script-thrown exception';

            System.assertEquals(expectedException, e.getMessage());
        }

        test.stopTest();
    }

    @isTest
    public static void saveCallDroppedCTICase() {
        String accountId = [SELECT Id FROM Account LIMIT 1].id;

        Case transferCase = new Case();
        
        transferCase.AccountId = accountId;
        transferCase.Status = 'Closed';
        transferCase.Origin = 'Ura';
        
        insert transferCase;
        
        Case callDroppedCase = new Case();
        
        callDroppedCase.AccountId = accountId;
        callDroppedCase.Status = 'Closed';
        callDroppedCase.Origin = 'CallDropped';
        callDroppedCase.Subject = 'Ligação Caiu';
        callDroppedCase.Description = 'Identificado queda da ligação durante o atendimento.';
        callDroppedCase.ServiceReason__c = 'Informação > Atendimento > Ligação > Ligação Caiu';

        String str = JSON.serialize(callDroppedCase);
        
        test.startTest();
        	String caseId = CTIServiceIntegrationController.createCTICase(str, 'CTIService', transferCase.Id, 'Sem Observação');
        test.stopTest();
        
        Case resultCase = [SELECT Origin FROM Case WHERE Id =: caseId];
        
        System.assertEquals('CallDropped', resultCase.Origin);
    }
}