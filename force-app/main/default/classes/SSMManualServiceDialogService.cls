/*
    ---------------------------------------------------
    @author - Márcio Las
    @company - Telefonica  
    @date - 14/04/2022
    @description - Class Service for SSMManualServiceDialog
    ---------------------------------------------------
*/
public with sharing class SSMManualServiceDialogService {
    public static Map<String, Object> generateTicket(String workPositionId, Boolean displayAlert, String scheduleTime, String cellPhone) {
        return (SSMManualServiceDialogEngine.generateTicket(workPositionId, displayAlert, scheduleTime, cellPhone));
    }   
}