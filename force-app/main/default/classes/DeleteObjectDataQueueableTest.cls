@isTest
private class DeleteObjectDataQueueableTest {
    
    @isTest
    private static void testDeleteObjectData() {

        List<vlocity_cmt__Party__c> vcps = new List<vlocity_cmt__Party__c>();

        for (Integer i=0;i<100;i++) {
            vlocity_cmt__Party__c vcp = new vlocity_cmt__Party__c(name='Test '+i);
            vcps.add(vcp);
        }

        insert vcps;

        Test.startTest();
        DeleteObjectDataQueueable queueableJob = new DeleteObjectDataQueueable('vlocity_cmt__Party__c', 100, System.today().addDays(-2), System.today().addDays(2));
        Id jobId = System.enqueueJob(queueableJob);
        Test.stopTest();

        List<vlocity_cmt__Party__c> result = [SELECT Id FROM vlocity_cmt__Party__c];
        System.assertEquals(0, result.size(), 'Expurgo nao realizado');
    }
}