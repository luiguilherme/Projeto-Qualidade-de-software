global class ScheduleDeleteChatIA implements Schedulable {
    private String objName = 'ChatIA__c';
    private Datetime startDate;
    private Datetime endDate;
    private Integer numberLimit;
    
    public ScheduleDeleteChatIA(Datetime startDate, Datetime endDate, Integer numberLimit) {
        this.startDate = startDate;
        this.endDate = endDate;
        this.numberLimit = numberLimit;
    }
    global static String agendar() {
        String jobName = '';
        Datetime startDate = System.now().addMonths(-1);
        Datetime endDate = System.now();
        Integer numberLimit = 10000;
        if(Test.isRunningTest()) {
            jobName += ' - from test';
        }
        return System.schedule('DeleteChatIA' + jobName, '0 0 1 ? * SAT *', new ScheduleDeleteChatIA(startDate,endDate,numberLimit));
    }
    global void execute(SchedulableContext sc) {
        String clause = '';
        String triggerId = sc.getTriggerId();
        List<AggregateResult> listChatIAIds  = [
            SELECT  Usuario__c, MAX (CreatedDate) createdDate, MAX(Id) identify
            FROM ChatIA__c 
            WHERE CreatedDate > :this.startDate AND CreatedDate < :this.endDate
            GROUP BY Usuario__c 
        ];
        List<String> listIds = new List<String>();
        for(AggregateResult chatIAId : listChatIAIds){
            listIds.add((String) chatIAId.get('identify'));
        }
        clause = 'Id NOT IN ' + '(\'' + String.join(listIds, '\', \'') + '\')';
        DeleteObjectDataQueueable queueable = new DeleteObjectDataQueueable(this.objName,this.numberLimit, this.startDate, this.endDate, clause);
        System.enqueueJob(queueable);
        if (triggerId != null) {
            System.abortJob(triggerId);
        }
        String newSchedule = agendar();
    }
 }