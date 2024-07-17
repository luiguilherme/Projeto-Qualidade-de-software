trigger CaseTrigger on Case (before update, after update) {
    if(trigger.isBefore && trigger.isUpdate) {
        HDECasesService.validateNewOwnerSegment(Trigger.new);
    }
}