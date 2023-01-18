/*
    ---------------------------------------------------
    @author - Márcio Las
    @company - Telefonica  
    @date - 04/05/2022
    @description - Class Controller for SSMAttendanceCustomerData
    ---------------------------------------------------
*/
public with sharing class SSMAttendanceCustomerDataController {
    @AuraEnabled
    public static Map<String, Object> loadSSMAttendanceCustomerData() {
        return (SSMAttendanceCustomerDataService.loadSSMAttendanceCustomerData());
    }
}