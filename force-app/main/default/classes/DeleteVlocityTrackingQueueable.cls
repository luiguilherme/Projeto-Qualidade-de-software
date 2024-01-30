public with sharing class DeleteVlocityTrackingQueueable implements Queueable {

    public DeleteVlocityTrackingQueueable(Integer nrOfRecords, Integer startDay, Integer endDay) {
        numberOfRecords = nrOfRecords;
        //retentionDays = retDays;
        startPurgeDay = startDay;
        endPurgeDay = endDay;
        
    }

    private Integer numberOfRecords;
    private Integer retentionDays;
    private Integer startPurgeDay;
    private Integer endPurgeDay;

    public void execute(QueueableContext context) {

        Boolean purgeTrackingEntry = GeneralParam__c.getInstance().PurgeVlocityTrackingEntry__c;

        Date startDate = System.today().addDays(-startPurgeDay);
        Date endDate = System.today().addDays(-endPurgeDay);

        List<vlocity_cmt__VlocityTrackingEntry__c> entries = [SELECT Id 
                                                              FROM vlocity_cmt__VlocityTrackingEntry__c 
                                                              WHERE CreatedDate >= :startDate
                                                                AND CreatedDate < :endDate
                                                              LIMIT :numberOfRecords];

        delete entries;

        // Timezone is relative to the user enqueueing the job
        Datetime now = Datetime.now();

        if (numberOfRecords == entries.size() && purgeTrackingEntry) {
            System.enqueueJob(new DeleteVlocityTrackingQueueable(numberOfRecords, startPurgeDay, endPurgeDay));
        }
    }
}