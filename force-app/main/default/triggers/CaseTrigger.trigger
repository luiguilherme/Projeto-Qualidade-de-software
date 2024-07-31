trigger CaseTrigger on Case (before update, after update, before insert, after insert) {
    
    CasesTriggerHandler casesTriggerHandler = new CasesTriggerHandler(Trigger.new, Trigger.oldMap);

    switch on Trigger.operationType
    {
        when BEFORE_INSERT
        {
            casesTriggerHandler.isBeforeInsert();
        }
        when BEFORE_UPDATE
        {
            HDECasesService.validateNewOwnerSegment(Trigger.new);
            casesTriggerHandler.isBeforeUpdate();
        }
        when AFTER_INSERT
        {
            casesTriggerHandler.isAfterInsert();
        }
        when AFTER_UPDATE
        {
            casesTriggerHandler.isAfterUpdate();
        } 
    }
}