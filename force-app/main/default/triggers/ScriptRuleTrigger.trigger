trigger ScriptRuleTrigger on ScriptRule__c (before delete) {

    if(Trigger.isBefore){
        if(Trigger.isDelete){
            ScriptRuleTriggerHandler.validateDeleteScriptRule();
        }
    }
}