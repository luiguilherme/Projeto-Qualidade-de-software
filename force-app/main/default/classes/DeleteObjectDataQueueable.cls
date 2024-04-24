public with sharing class DeleteObjectDataQueueable implements Queueable {

    public DeleteObjectDataQueueable(String objName, Integer nrOfRecords, Datetime startDate, Datetime endDate) {
        this.objectName = objName;
        this.numberOfRecords = nrOfRecords;
        this.startDate = startDate;
        this.endDate = endDate;
        this.additionalFilter = '';
    }

    public DeleteObjectDataQueueable(String objName, Integer nrOfRecords, Datetime startDate, Datetime endDate, 
                                     String additionalFilter) {
        this.objectName = objName;
        this.numberOfRecords = nrOfRecords;
        this.startDate = startDate;
        this.endDate = endDate;
        this.additionalFilter = additionalFilter;
    }

    private String objectName;
    private Integer numberOfRecords;
    private Datetime startDate;
    private Datetime endDate;
    private String additionalFilter;

    public void execute(QueueableContext context) {

        Boolean purgeObjects = GeneralParam__c.getInstance().PurgeObjects__c;

        List<SObject> purgeList = getPurgeList(startDate, endDate); 

        delete purgeList;

        if (numberOfRecords == purgeList.size() && purgeObjects) {
            System.enqueueJob(new DeleteObjectDataQueueable(this.objectName, this.numberOfRecords, this.startDate, this.endDate, this.additionalFilter));
        }
        
    }

    private List<SObject> getPurgeList(Datetime startDate, Datetime endDate) {
       
        String filter = '';
        if (!String.isBlank(this.additionalFilter)) {
            filter = ' AND ' + this.additionalFilter;
        }

        String query = 'SELECT Id FROM ' + this.objectName + 
                       ' WHERE CreatedDate >= :this.startDate AND CreatedDate < :this.endDate' +
                       filter + ' LIMIT ' + this.numberOfRecords;
        System.debug('Query: ' + query);
        List<SObject> purgeList = Database.query(query);
        return purgeList;

    }

}