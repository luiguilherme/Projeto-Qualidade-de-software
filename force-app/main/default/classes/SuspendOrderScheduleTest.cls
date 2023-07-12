@isTest
private class SuspendOrderScheduleTest {
    
    static testmethod void testScheduledJob() {
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
        
        Test.startTest();
        // Schedule the test job
        String jobId = System.schedule('ScheduledApexTest',
            '0 0 1 * * ?',
            new SuspendOrderSchedule());
        // Verify the scheduled job has not run yet.
        //System.assertEquals('Fechado', [select Status__c from Timer__c where Name = 'Teste class' and Status__c = 'Fechado' LIMIT 1].Status__c);
        // Stopping the test will run the job synchronously
        Test.stopTest();
        
        //System.assertEquals('Fechado', [select Status__c from Timer__c where Name = 'Teste class' and Status__c = 'Fechado' LIMIT 1].Status__c);
    }
}