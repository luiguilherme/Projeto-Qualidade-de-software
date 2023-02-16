/*
    ---------------------------------------------------
    @author - Márcio Las
    @company - Telefonica  
    @date - 20/04/2022
    @description - Class Conrtoller for SSMAttendance
    ---------------------------------------------------
*/
public with sharing class SSMAttendanceController {
    @AuraEnabled
    public static Map<String, Object> fetchAttendanceOperationalInformations() {
        return (SSMAttendanceService.fetchAttendanceOperationalInformations());
    }

    @AuraEnabled
    public static Map<String, Object> getAccount(String phoneNumber, String documentNumber) {
        return (SSMAttendanceService.getAccount(phoneNumber, documentNumber));
    }

    @AuraEnabled
    public static StoreServiceManagerTO.ItemPicklistValue getAccountCustomerSegmentGSS(String accountCustomerSegment) {
        return (StoreServiceManagerService.getAccountCustomerSegmentGSS(accountCustomerSegment));
    }
}
