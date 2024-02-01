@isTest
private class DeleteVlocityTrackingQueueableTest {
    @isTest
    private static void testDeleteVlocityTracking() {

        List<vlocity_cmt__VlocityTrackingEntry__c> vtes = new List<vlocity_cmt__VlocityTrackingEntry__c>();

        for (Integer i=0;i<100;i++) {
            vlocity_cmt__VlocityTrackingEntry__c vte = new vlocity_cmt__VlocityTrackingEntry__c(name='StepActionTime'+i);
            vtes.add(vte);
        }

        insert vtes;

        Test.startTest();
        DeleteVlocityTrackingQueueable queueableJob = new DeleteVlocityTrackingQueueable(100, 2, -2);
        Id jobId = System.enqueueJob(queueableJob);
        Test.stopTest();

        List<vlocity_cmt__VlocityTrackingEntry__c> result = [SELECT Id FROM vlocity_cmt__VlocityTrackingEntry__c];
        System.assertEquals(0, result.size(), 'Expurgo nao realizado');

    }
}