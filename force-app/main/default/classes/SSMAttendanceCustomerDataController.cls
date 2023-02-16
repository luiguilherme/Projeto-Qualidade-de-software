/*
    Discontinued. Technical debt: to be removed!

    ---------------------------------------------------
    @author - Márcio Las
    @company - Telefonica  
    @date - 04/05/2022
    @description - Class Controller for SSMAttendanceCustomerData
    ---------------------------------------------------
*/
public with sharing class SSMAttendanceCustomerDataController {
    // For testing purposes only
    @AuraEnabled
    public static String getTestingPurposesOnlyMessage() {
        return (SSMAttendanceCustomerDataService.getTestingPurposesOnlyMessage());
    }

    /* 
    @AuraEnabled
    public static Map<String, Object> loadSSMAttendanceCustomerData() {
        return (SSMAttendanceCustomerDataService.loadSSMAttendanceCustomerData());
    }
    */
}
