/*
    ---------------------------------------------------
    @author - Márcio Las
    @company - Telefonica  
    @date - 15/03/2022
    @description - Class Service for StoreServiceManager
    ---------------------------------------------------
*/
public with sharing class StoreServiceManagerService {
    public static Boolean hasPermissionSetToAccess() {
        return (StoreServiceManagerEngine.hasPermissionSetToAccess());
    }
    
    public static Map<String, Object> loadStoreServiceManager () {
        return (StoreServiceManagerEngine.loadStoreServiceManager());
    }

    public static Map<String, Object> fetchPointOfService() {
        return (StoreServiceManagerEngine.fetchPointOfService());
    }

    public static Map<String, Object> fetchOperationalInformations() {
        return (StoreServiceManagerEngine.fetchOperationalInformations());
    }

    public static Map<String, Object> fetchInformationStatus() {
        return (StoreServiceManagerEngine.fetchInformationStatus());
    }
    
    public static Map<String, Object> fetchInformationAttendance() {
        return (StoreServiceManagerEngine.fetchInformationAttendance());
    }

    public static List<StoreServiceManagerTO.ItemPicklistValue> getWorkPositionsPickList() {
        return (StoreServiceManagerEngine.getWorkPositionsPickList(null));
    }

    public static List<StoreServiceManagerTO.ItemPicklistValue> getWorkPositionsPickList(List<StoreServiceManagerResponse.WorkPosition> ltWorkPositionsResponse) {
        return (StoreServiceManagerEngine.getWorkPositionsPickList(ltWorkPositionsResponse));
    }

    public static StoreServiceManagerTO.ItemPicklistValue getAccountCustomerSegmentGSS(String accountCustomerSegment) {
        return (StoreServiceManagerEngine.getAccountCustomerSegmentGSS(accountCustomerSegment));
    }

    public static Boolean isPartnerCommunityLicense() {
        return (StoreServiceManagerEngine.isPartnerCommunityLicense());
    }

    public static Map<String, Object> getParams() {
        return (StoreServiceManagerEngine.getParams());
    }

    public static String calculateStartTime(String elapsedTime) {
        return (StoreServiceManagerEngine.calculateStartTime(elapsedTime));
    }

    public static Double calculateElapsedTimeInMilliseconds(String startTime, String finalTime) {
        return (StoreServiceManagerEngine.calculateElapsedTimeInMilliseconds(startTime, finalTime));
    }

    public static String calculateElapsedTime(Double millisecondsElapsedTime) {
        return (StoreServiceManagerEngine.calculateElapsedTime(millisecondsElapsedTime));
    }

    public static String calculateElapsedTime(String startTime, String finalTime) {
        return (StoreServiceManagerEngine.calculateElapsedTime(startTime, finalTime));
    }
}
