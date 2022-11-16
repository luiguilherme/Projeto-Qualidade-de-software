trigger ScriptConfigTrigger on ScriptConfig__c (after insert, before update) {

    if (Trigger.isAfter) {
        if (Trigger.isInsert) {
            ScriptConfigTriggerHandler.createRoute(Trigger.new);
        }
    }

    if (Trigger.isBefore) {
        if (Trigger.isUpdate) {
            ScriptConfigTriggerHandler.createGroupToRoute(Trigger.new);
        }
    }
}