public with sharing class SenderCaseNotificationSchedule implements Schedulable {
    public void execute(SchedulableContext sc) {
        SenderCaseNotificationBatchable batch = new SenderCaseNotificationBatchable(); 
        
        ID batchProcessId = Database.executeBatch(batch);
    }
}