trigger CartAccountTrigger on CartAccount__c (before update, after update) {

    if(trigger.isBefore && trigger.isUpdate) {
        CartAccountTriggerHandler.validateCartOfferEquality(Trigger.new,Trigger.oldMap);
        CartAccountTriggerHandler.validate(Trigger.new,Trigger.oldMap);
    }

    if(trigger.isAfter && trigger.isUpdate) {     
        CartAccountTriggerHandler.executeFromUpdate(Trigger.new,Trigger.oldMap);        
    }                                     
}