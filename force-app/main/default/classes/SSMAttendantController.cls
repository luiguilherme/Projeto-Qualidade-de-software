/*
    ---------------------------------------------------
    @author - Márcio Las
    @company - Telefonica  
    @date - 15/03/2022
    @description - Class Controller for SSMAttendant
    ---------------------------------------------------
*/
public with sharing class SSMAttendantController {
    @AuraEnabled
    public static Map<String, Object> getPositionPicklistValues() {
        return (SSMAttendantService.getPositionPicklistValues());
    }

    @AuraEnabled
    public static Map<String, Object> fetchOperationalInformations() {
        return (StoreServiceManagerService.fetchOperationalInformations());
    }

    @AuraEnabled
    public static Map<String, Object> getPickListAttendantPauseOptions() {
        return (SSMAttendantService.getPickListAttendantPauseOptions());
    }

    @AuraEnabled
    public static Map<String, Object> startService(String workPositionId) {
        return (SSMAttendantService.startService(workPositionId));
    }

    @AuraEnabled
    public static Map<String, Object> endService(String workPositionId) {
        return (SSMAttendantService.endService(workPositionId));
    }
   
    @AuraEnabled
    public static Map<String, Object> pauseService(StoreServiceManagerTO.ItemPicklistValue pauseReason) {
        return (SSMAttendantService.pauseService(pauseReason));
    }

    @AuraEnabled
    public static Map<String, Object> resumeService() {
        return (SSMAttendantService.resumeService());
    }
}
