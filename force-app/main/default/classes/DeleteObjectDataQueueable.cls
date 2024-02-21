public with sharing class DeleteObjectDataQueueable implements Queueable {

    public DeleteObjectDataQueueable(String objName, Integer nrOfRecords, Datetime startDate, Datetime endDate) {
        this.objectName = objName;
        this.numberOfRecords = nrOfRecords;
        this.startDate = startDate;
        this.endDate = endDate;
    }

    private String objectName;
    private Integer numberOfRecords;
    private Datetime startDate;
    private Datetime endDate;

    public void execute(QueueableContext context) {

        Boolean purgeObjects = GeneralParam__c.getInstance().PurgeObjects__c;

        String query = 'SELECT Id FROM ' + objectName + 
                       ' WHERE CreatedDate >= :startDate AND CreatedDate < :endDate LIMIT :numberOfRecords';
        
        List<SObject> purgeList = Database.query(query);
 
        delete purgeList;

        if (numberOfRecords == purgeList.size() && purgeObjects) {
            System.enqueueJob(new DeleteObjectDataQueueable(this.objectName, this.numberOfRecords, this.startDate, this.endDate));
        }
        
    }

}