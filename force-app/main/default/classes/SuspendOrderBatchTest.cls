/**
 * Classe de teste responsável por testar a classe: SuspendOrderBatch
 * Criação: US-418 - 26/01/2023
 * @author: diogsousa@deloitte.com 
 */
@isTest
private class SuspendOrderBatchTest {
    @testSetup
    static void setup() {
         //Account
        Account account = new Account();
        account.name = 'testAccount';
        insert account;

        //Order
        Order order = new Order();
        order.AccountId = account.Id;
        order.EffectiveDate = Date.today();
        order.Status = 'Draft';
        order.Pricebook2Id = test.getStandardPricebookId();
        insert order;
        
        //Timer__c
        Timer__c timerTest = new Timer__c();
        timerTest.Name = 'Teste class';
        timerTest.OrderId__c =  order.Id;
        timerTest.StartDate__c = System.now().addDays(-11);
        timerTest.Type__c = 'Timer Cadastro';
        insert timerTest;
    }
    @isTest static void test() {
        Test.startTest();
        SuspendOrderBatch b = new SuspendOrderBatch('Suspensão Hab Remota', 'Timer Cadastro');
        System.assertEquals('Aberto', [select Status__c from Timer__c where Name = 'Teste class' and Status__c = 'Aberto' LIMIT 1].Status__c);
        Id batchId = Database.executeBatch(b);
        Test.stopTest();
        System.debug([select Status__c from Timer__c where Name = 'Teste class' and Status__c = 'Aberto' LIMIT 1]);
        
    }
}