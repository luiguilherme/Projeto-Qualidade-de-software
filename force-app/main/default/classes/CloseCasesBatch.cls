global with sharing class CloseCasesBatch implements Database.Batchable<sObject>{
    private GeneralParam__c param;

    global static void start(){
        Database.executeBatch(new CloseCasesBatch());
    }

    global static void start(Integer batchSize){
        Database.executeBatch(new CloseCasesBatch(), batchSize);
    }
     
    global Database.QueryLocator start(Database.BatchableContext BC) {
        String query;

        Integer gmtCompensation = 3;
        DateTime expirationDate = System.now().addHours(gmtCompensation).addHours(-4);
        String expirationDatePlusCompesation = expirationDate.format('yyyy-MM-dd\'T\'HH:mm:ss');
        expirationDatePlusCompesation += '.000Z';
        String recordTypeIdFixed = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get('FixedServiceQualification').getrecordTypeId();
        String recordTypeIdDispute = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get('DisputeInvoiceCase').getRecordTypeId();
        
        query = 'SELECT';
        query += ' Id, CreatedDate, Status, RecordTypeId ';
        query += ' FROM Case';
        query += ' WHERE CreatedDate <= ' + expirationDatePlusCompesation;
        query += ' AND (Status = \'Em Atendimento\' OR Status = \'InTransfer\' OR Status = \'Consulting\')';
        query += ' AND RecordTypeId IN (\'' + recordTypeIdFixed + '\', \'' + recordTypeIdDispute + '\')';
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
            if (c.Status == 'Em Atendimento') {
                c.Status = 'InterruptedFlow';
            } else if (c.Status == 'InTransfer' || c.Status == 'Consulting') {
                c.Status = 'TransferInterrupted';
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