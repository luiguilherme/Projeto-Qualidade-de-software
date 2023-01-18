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
    public static StoreServiceManagerTO.ItemPicklistValue getAccountCustomerSegmentGSS(String accountCustomerSegment) {
        return (StoreServiceManagerService.getAccountCustomerSegmentGSS(accountCustomerSegment));
    }
}