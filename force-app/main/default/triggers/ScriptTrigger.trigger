trigger ScriptTrigger on Script__c (before update, before insert) {
    if(Trigger.isBefore){
        if(Trigger.isUpdate){
            ScriptNotificationTriggerHandler.validateUpdateOfScriptRecord();
            ScriptNotificationTriggerHandler.validateScriptTypeActiveUnique(Trigger.new, (Map<Id,Script__c>) Trigger.oldMap);
        }
        if(Trigger.isInsert){
            ScriptNotificationTriggerHandler.validateScriptTypeActiveUnique(Trigger.new, (Map<Id,Script__c>) Trigger.oldMap);
        }
    }
}