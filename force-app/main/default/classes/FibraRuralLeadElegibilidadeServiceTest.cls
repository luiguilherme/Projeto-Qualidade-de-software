@isTest
public class FibraRuralLeadElegibilidadeServiceTest {
    
    @testSetup
    public static void setup(){
        insert new Webservice__c(
            Name = 'API_GW_SendMailCSS',
            Endpoint__c  = 'https://api-hml-int.telefonica.com.br/enviar-email-sms/v1/enviarEmailSMSConvergente',
            ServiceOperation__c = 'POST',
            Certificate__c = 'FibraRuralHML',
            SubscriptionKey__c = '',
            ServiceProvider__c = 'APIGW'
        );
        
        insert new Lead(
            RecordTypeId = Schema.SObjectType.Lead.getRecordTypeInfosByName().get('Fibra Rural').getRecordTypeId(),
            FirstName = 'FirstName',
            LastName = 'LastName',
            Document__c = '65699762060',
            Phone = '99999999999',
            Email = 'testEmail@test.com',
            Status = 'NewFR',
            Street = 'Rua',
            City = 'Cidade',
            State = 'SP',
            Country = 'Brasil',
            PostalCode = '99999999',
            AddressNumber__c = '0',
            District__c = 'Bairro',
            PropertyName__c = 'Name',
            Reference__c = 'Ponto',
            Product__c = 'Vivo_Fiber_Rural_Areas_2P',
            Company = 'Teste'
        );
    }
    
    @isTest
    public static void testUnformatString(){
        
        List<String> testString = new List<String>();
        testString.add('unformatString,á Ä â À ã É è Ê ë Î ï Í ì Ö ó Ò ô Õ ü Ú ù Û ç Ç');
        
        Test.StartTest();
        List<String> response = FibraRuralLeadElegibilidadeService.flowMethods(testString);
        Test.StopTest();
        
        System.assertEquals(1, response.size());
        System.assertEquals('a a a a a e e e e i i i i o o o o o u u u u c c', response[0]);
        
    }
    
    @isTest
    public static void testSendEmailAPI(){
        
        Webservice__c sendMailCss = [SELECT SubscriptionKey__c FROM Webservice__c WHERE Name='API_GW_SendMailCSS' LIMIT 1];
        sendMailCss.SubscriptionKey__c = 'd1ca8d57a2984db88f01c9ce7b5862e2';
        update sendMailCss;
        
        Lead testLead = [SELECT Id FROM Lead WHERE LastName = 'LastName'];
        
        List<String> testString = new List<String>();
        testString.add('sendEmailController,Código da Mensagem,testEmail@test.com,Mr Test User,' + String.valueOf(testLead.Id));
        
        Test.StartTest();
        Test.setMock(HttpCalloutMock.class, new FibraRuralLeadElegibilidadeMock());
        FibraRuralLeadElegibilidadeCallout.sendEmailAPI(testString[0]);
        Test.StopTest();
        
    }
    
    @isTest
    public static void testSendEmailControllerError(){
        
        Webservice__c sendMailCss = [SELECT SubscriptionKey__c FROM Webservice__c WHERE Name='API_GW_SendMailCSS' LIMIT 1];
        sendMailCss.SubscriptionKey__c = '';
        update sendMailCss;
        
        Lead testLead = [SELECT Id FROM Lead WHERE LastName = 'LastName'];
        
        List<String> testString = new List<String>();
        testString.add('sendEmailController,Código da Mensagem,testEmail@test.com,Mr Test User,' + String.valueOf(testLead.Id));
        
        Test.StartTest();
        Test.setMock(HttpCalloutMock.class, new FibraRuralLeadElegibilidadeMock());
        List<String> response = FibraRuralLeadElegibilidadeService.flowMethods(testString);
        Test.StopTest();
        
    }
    
    
}