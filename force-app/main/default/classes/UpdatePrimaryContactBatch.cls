public without sharing class UpdatePrimaryContactBatch implements Database.Batchable<sObject>, Schedulable, Database.Stateful {

    public Database.QueryLocator start(Database.BatchableContext bc) {
        Integer recordsUpdated = Integer.valueOf(GeneralParam__c.getInstance().UpdatedPrimaryContactLimit__c);
        Integer daysUpdated = Integer.valueOf(GeneralParam__c.getInstance().UpdatedPrimaryContactDays__c);
        Id consumerRT = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Consumer').getRecordTypeId();
        Datetime startDate = System.today().addDays(-daysUpdated);
        return Database.getQueryLocator(getContacts());
    }

    public void execute(SchedulableContext sc)
    { 
      Database.executeBatch(new UpdatePrimaryContactBatch());
    }

    public void execute(Database.BatchableContext bc, List<Account> scope) {
        List<Account> accounts = new List<Account>(); 
        for (Account acc : scope) {
            if (acc.Contacts.size() > 0) {
                acc.vlocity_cmt__PrimaryContactId__c = acc.Contacts[0].Id;
                accounts.add(acc);
            }
        }
        update accounts;
    }

    public void finish(Database.BatchableContext bc) {
        System.debug('Job finished.');
    }

    private String getContacts() {

        return 'SELECT Id, vlocity_cmt__PrimaryContactId__c, (SELECT Id FROM Contacts) Contacts ' +
                'FROM Account ' + 
                'WHERE Id in (SELECT AccountId  ' +
                             'FROM Contact ' +
                             'WHERE Account.CreatedDate >= :startDate ' +
                              'AND Account.vlocity_cmt__PrimaryContactId__c = null ' +
                              'AND Account.RecordTypeId = :consumerRT ' +
                              'AND AccountId <> null) ' +
                'LIMIT :recordsUpdated';

    }

}