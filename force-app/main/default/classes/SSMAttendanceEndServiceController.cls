/*
    ---------------------------------------------------
    @author - Márcio Las
    @company - Telefonica  
    @date - 05/05/2022
    @description - Class Controller for SSMAttendanceEndService
    ---------------------------------------------------
*/
public with sharing class SSMAttendanceEndServiceController {
    @AuraEnabled
    public static Map<String, Object> loadSSMAttendanceEndService() {
        return (SSMAttendanceEndServiceService.loadSSMAttendanceEndService());
    }
}