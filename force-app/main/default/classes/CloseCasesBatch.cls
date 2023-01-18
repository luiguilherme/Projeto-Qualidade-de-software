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
        DateTime expirationDate = System.now().addHours(-4);
        String recordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get('FixedServiceQualification').getrecordTypeId();
        
        query = 'SELECT';
        query += ' Id, CreatedDate, Status ';
        query += ' FROM Case';
        query += ' WHERE CreatedDate <= '+ expirationDate.format('yyyy-MM-dd\'T\'hh:mm:ss\'Z\'');
        query += ' AND (Status = \'Em Atendimento\' OR Status = \'InTransfer\' OR Status = \'Consulting\')';
        query += ' AND RecordTypeId = \'' + recordTypeId + '\'';
        System.debug('query = ' + query);
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, List<Case> scope) {

        for(Case c : scope){
            if(c.Status == 'Em Atendimento'){
                c.Status = 'InterruptedFlow';
            }else if(c.Status == 'InTransfer' || c.Status == 'Consulting'){
                c.Status = 'TransferInterrupted';
            }
        }

        update scope;
    }

    global void finish(Database.BatchableContext BC) {
    }
}