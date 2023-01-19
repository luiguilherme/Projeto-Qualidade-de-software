/*
    ---------------------------------------------------
    @author - Márcio Las
    @company - Telefonica  
    @date - 14/04/2022
    @description - Class Controller for SSMManualServiceDialog
    ---------------------------------------------------
*/
public with sharing class SSMManualServiceDialogController {
    @AuraEnabled
    public static Map<String, Object> generateTicket(String workPositionId, Boolean displayAlert, String scheduleTime, String cellPhone) {
        return (SSMManualServiceDialogService.generateTicket(workPositionId, displayAlert, scheduleTime, cellPhone));
    }
}