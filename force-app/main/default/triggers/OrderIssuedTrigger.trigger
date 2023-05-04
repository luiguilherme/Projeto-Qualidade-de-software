trigger OrderIssuedTrigger on OrderIssued__c (before insert, before update) {
    
    if(trigger.isBefore){ //ids nao estao disponiveis no before insert
        if(Trigger.isUpdate){
            OrderIssuedManagement.checkOrderError(trigger.oldMap, trigger.new);
        }
        if(Trigger.isInsert){
            OrderIssuedManagement.checkOrderError(trigger.oldMap, trigger.new);
        }
    }
}