trigger CaseCommentTrigger on CaseComment__c (before update, after update, before insert, after insert) {

    CaseCommentTriggerHandler triggerHandler = new CaseCommentTriggerHandler(Trigger.new, Trigger.oldMap);

    switch on Trigger.operationType {
        when BEFORE_INSERT { /* do something */ }
        when BEFORE_UPDATE { /* do something */ }
        when AFTER_INSERT {
            triggerHandler.isAfterInsert();
        }
        when AFTER_UPDATE { /* do something */ } 
    }
}