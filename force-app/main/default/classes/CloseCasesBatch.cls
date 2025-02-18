global with sharing class CloseCasesBatch implements Database.Batchable<sObject>{
    private GeneralParam__c param;
    private DateTime jobStartDateTime = System.now();
    private Integer  offSetUserTimeZone = UserInfo.getTimeZone().getOffset(jobStartDateTime) / (60 * 60 * 1000);
    private Integer  referenceHour = (offSetUserTimeZone == -3)  ? -4 : -3;
    private String   expirationDate = jobStartDateTime.addHours(referenceHour).format('yyyy-MM-dd\'T\'HH:mm:ss\'.000Z\'', 'GMT');
	private String   recordTypeIdFixed   = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get('FixedServiceQualification').getrecordTypeId();
    private String   recordTypeIdDispute = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get('DisputeInvoiceCase').getRecordTypeId();
    private String   recordTypeIdPre     = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get('PreDefectAndRepair').getRecordTypeId();    

    global static void start(){
        Database.executeBatch(new CloseCasesBatch());
    }

    global static void start(Integer batchSize){
        Database.executeBatch(new CloseCasesBatch(), batchSize);
    }
     
    global Database.QueryLocator start(Database.BatchableContext BC) {
        String query;

        query = 'SELECT';
        query += ' Id, CreatedDate, Status, RecordTypeId, DateTimeStatusChanged__c';
        query += ' FROM Case';
        query += ' WHERE CreatedDate <= ' + expirationDate;
        query += ' AND (Status = \'Em Atendimento\' OR Status = \'InTransfer\' OR Status = \'Consulting\')';
        query += ' AND RecordTypeId IN (\'' + recordTypeIdFixed + '\', \'' + recordTypeIdDispute + '\', \'' + recordTypeIdPre + '\')';
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, List<Case> scope) {
        Map<Id, List<DisputedItem__c>> caseToDisputedItemsMap = new Map<Id, List<DisputedItem__c>>();
        Map<Id, List<vlocity_cmt__CustomerInteractionTopic__c>> caseToInteractionTopicsMap = new Map<Id, List<vlocity_cmt__CustomerInteractionTopic__c>>();
        List<DisputedItem__c> itemsToUpdate = new List<DisputedItem__c>();
        List<vlocity_cmt__CustomerInteraction__c> interactionsToUpdate = new List<vlocity_cmt__CustomerInteraction__c>();

        Set<Id> caseIds = new Set<Id>();
        for (Case c : scope) {
            caseIds.add(c.Id);
        }

        for (DisputedItem__c item : [SELECT Id, Status__c, CaseId__c FROM DisputedItem__c WHERE CaseId__c IN :caseIds]) {
            if (!caseToDisputedItemsMap.containsKey(item.CaseId__c)) {
                caseToDisputedItemsMap.put(item.CaseId__c, new List<DisputedItem__c>());
            }
            caseToDisputedItemsMap.get(item.CaseId__c).add(item);
        }

        for (vlocity_cmt__CustomerInteractionTopic__c topic : [
                SELECT Id, vlocity_cmt__CustomerInteractionId__c, vlocity_cmt__CustomerInteractionId__r.vlocity_cmt__Status__c, vlocity_cmt__CaseId__c
                FROM vlocity_cmt__CustomerInteractionTopic__c 
                WHERE vlocity_cmt__CaseId__c IN :caseIds 
                AND vlocity_cmt__CaseId__r.RecordType.DeveloperName = 'DisputeInvoiceCase'
            ]) {
            if (!caseToInteractionTopicsMap.containsKey(topic.vlocity_cmt__CaseId__c)) {
                caseToInteractionTopicsMap.put(topic.vlocity_cmt__CaseId__c, new List<vlocity_cmt__CustomerInteractionTopic__c>());
            }
            caseToInteractionTopicsMap.get(topic.vlocity_cmt__CaseId__c).add(topic);
        }
       
        for (Case c : scope) {

            Long hoursSource = c.DateTimeStatusChanged__c!= null ? c.DateTimeStatusChanged__c.getTime() : jobStartDateTime.getTime();
            Long hoursTotal = (jobStartDateTime.getTime() - hoursSource)/(60 * 60 * 1000);
           
            if (c.Status == 'Em Atendimento') {
                if(c.RecordTypeId == recordTypeIdPre && hoursTotal > 4 ){
                	c.Status = 'InterruptedFlow';
                }else if(c.RecordTypeId == recordTypeIdFixed || c.RecordTypeId == recordTypeIdDispute){
                	c.Status = 'InterruptedFlow';                    
                }
            } else if (c.Status == 'InTransfer' || c.Status == 'Consulting') {
                if(c.RecordTypeId == recordTypeIdPre  && hoursTotal > 4){
                    c.Status = 'TransferInterrupted';
                }else if(c.RecordTypeId == recordTypeIdFixed || c.RecordTypeId == recordTypeIdDispute){
                    c.Status = 'TransferInterrupted';
                }
            }

            if (caseToDisputedItemsMap.containsKey(c.Id)) {
                for (DisputedItem__c item : caseToDisputedItemsMap.get(c.Id)) {
                    item.Status__c = 'Closed';
                    itemsToUpdate.add(item);
                }
            }

            vlocity_cmt__CustomerInteraction__c relatedCustomerInteraction = new vlocity_cmt__CustomerInteraction__c();

            if (caseToInteractionTopicsMap.containsKey(c.Id)) {
                for (vlocity_cmt__CustomerInteractionTopic__c topic : caseToInteractionTopicsMap.get(c.Id)) {
                    if (topic.vlocity_cmt__CustomerInteractionId__c != null) {
                        relatedCustomerInteraction.Id = topic.vlocity_cmt__CustomerInteractionId__c;
                        relatedCustomerInteraction.vlocity_cmt__Status__c = 'Interrupted';
                        interactionsToUpdate.add(relatedCustomerInteraction);
                    }
                }
            }
        }
        
        try {
            if (!scope.isEmpty()) {
                Map<Id, Case> casesMap = new Map<Id, Case>();
                casesMap.putAll(scope);
                update casesMap.values();
            }
            if (!itemsToUpdate.isEmpty()) {
                Map<Id, DisputedItem__c> itemsMap = new Map<Id, DisputedItem__c>();
                itemsMap.putAll(itemsToUpdate);
                update itemsMap.values();
            }
            if (!interactionsToUpdate.isEmpty()) {
                Map<Id, vlocity_cmt__CustomerInteraction__c> interactionsMap = new Map<Id, vlocity_cmt__CustomerInteraction__c>();
                interactionsMap.putAll(interactionsToUpdate);
                update interactionsMap.values();
            }
        } catch (DmlException e) {
            System.debug('An exception occurred during batch processing: ' + e.getMessage());
        }
    }

    global void finish(Database.BatchableContext BC) {
    }
}