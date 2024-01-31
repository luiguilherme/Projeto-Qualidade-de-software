/*
    ---------------------------------------------------
    @author - Márcio Las
    @company - Telefonica  
    @date - 15/03/2022
    @description - Class Controller for StoreServiceManager
    ---------------------------------------------------
*/
public with sharing class StoreServiceManagerController {
    @AuraEnabled
    public static Boolean hasPermissionSetToAccess() {
        return (StoreServiceManagerService.hasPermissionSetToAccess());
    }

	@AuraEnabled
    public static Map<String, Object> loadStoreServiceManager() {
        return (StoreServiceManagerService.loadStoreServiceManager());
    }

    @AuraEnabled
    public static Map<String, Object> fetchPointOfService() {
        return (StoreServiceManagerService.fetchPointOfService());
    }

    @AuraEnabled
    public static Map<String, Object> fetchOperationalInformations() {
        return (StoreServiceManagerService.fetchOperationalInformations());
    }

    @AuraEnabled
    public static Map<String, Object> fetchInformationStatus() {
        return (StoreServiceManagerService.fetchInformationStatus());
    }
    
    @AuraEnabled
    public static Map<String, Object> fetchInformationAttendance() {
        return (StoreServiceManagerService.fetchInformationAttendance());
    }
    
    @AuraEnabled
    public static List<StoreServiceManagerTO.ItemPicklistValue> getWorkPositionsPickList() {
        return (StoreServiceManagerService.getWorkPositionsPickList(null));
    }
    
    @AuraEnabled
    public static StoreServiceManagerTO.ItemPicklistValue getAccountCustomerSegmentGSS(String accountCustomerSegment) {
        return (StoreServiceManagerService.getAccountCustomerSegmentGSS(accountCustomerSegment));
    }

    @AuraEnabled
    public static Boolean isPartnerCommunityLicense() {
        return (StoreServiceManagerService.isPartnerCommunityLicense());
    }

    @AuraEnabled
    public static Map<String, Object> getParams() {
        return (StoreServiceManagerService.getParams());
    }

    @AuraEnabled
    public static String calculateStartTime(String elapsedTime) {
        return (StoreServiceManagerService.calculateStartTime(elapsedTime));
    }

    @AuraEnabled
    public static Double calculateElapsedTimeInMilliseconds(String startTime, String finalTime) {
        return (StoreServiceManagerService.calculateElapsedTimeInMilliseconds(startTime, finalTime));
    }

    @AuraEnabled
    public static String calculateElapsedTime(Double millisecondsElapsedTime) {
        return (StoreServiceManagerService.calculateElapsedTime(millisecondsElapsedTime));
    }
    
    @AuraEnabled
    public static String calculateElapsedTime(String startTime, String finalTime) {
        return (StoreServiceManagerService.calculateElapsedTime(startTime, finalTime));
    }
}
