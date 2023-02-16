/*
    Discontinued. Technical debt: to be removed!
    
    ---------------------------------------------------
    @author - Márcio Las
    @company - Telefonica  
    @date - 05/05/2022
    @description - Class Controller for SSMAttendanceEndService
    ---------------------------------------------------
*/
public with sharing class SSMAttendanceEndServiceController {
    // For testing purposes only
    @AuraEnabled
    public static String getTestingPurposesOnlyMessage() {
        return (SSMAttendanceEndServiceService.getTestingPurposesOnlyMessage());
    }

    /*
    @AuraEnabled
    public static Map<String, Object> loadSSMAttendanceEndService() {
        return (SSMAttendanceEndServiceService.loadSSMAttendanceEndService());
    }
    */
}
