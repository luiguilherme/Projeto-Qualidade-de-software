/*
    ---------------------------------------------------
    @author - Márcio Las
    @company - Telefonica  
    @date - 15/03/2022
    @description - Class Service for SSMAttendant
    ---------------------------------------------------
*/
public with sharing class SSMAttendantService {
    public static Map<String, Object> getPositionPicklistValues() {
        return (SSMAttendantEngine.getPositionPicklistValues());
    }

    public static Map<String, Object> getPickListAttendantPauseOptions() {
        return (SSMAttendantEngine.getPickListAttendantPauseOptions());
    }

    public static Map<String, Object> startService(String workPositionId) {
        return (SSMAttendantEngine.startService(workPositionId));
    }

    public static Map<String, Object> endService(String workPositionId) {
        return (SSMAttendantEngine.endService(workPositionId));
    }

    public static Map<String, Object> pauseService(StoreServiceManagerTO.ItemPicklistValue pauseReason) {
        return (SSMAttendantEngine.pauseService(pauseReason));
    }

    public static Map<String, Object> resumeService() {
        return (SSMAttendantEngine.resumeService());
    }
}