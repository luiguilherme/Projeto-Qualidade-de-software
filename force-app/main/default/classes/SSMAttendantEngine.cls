/*
    ---------------------------------------------------
    @author - Márcio Las
    @company - Telefonica  
    @date - 22/03/2022
    @description - Class Engine for SSMAttendant
    ---------------------------------------------------
*/
public with sharing class SSMAttendantEngine {
    private static final String POINT_OF_SERVICE = 'PointOfService';
    private static final String OPERATIONAL_INFORMATIONS = 'OperationalInformations';
    
    private static final String WORK_POSITIONS = 'WorkPositions';
    private static final String ATTENDANT_PAUSE_OPTIONS = 'AttendantPauseOptions';

    private static final Integer ERROR_POSITIONS_LIST_IS_EMPTY = 611;
    private static final Integer ERROR_PAUSE_REASONS_LIST_IS_EMPTY = 621;
    private static final Integer GENERIC_ERROR_MESSAGE = 699;

    public static Map<String, Object> getPositionPicklistValues() {
        Map<String, Object> mapResponse = new Map<String, Object>();

        List<StoreServiceManagerTO.ItemPicklistValue> ltWorkPositions = 
            StoreServiceManagerService.getWorkPositionsPickList();

        if (!ltWorkPositions.isEmpty()) {
            mapResponse.put('workPositionsList', ltWorkPositions);

        } else {
            mapResponse.put('error', ERROR_POSITIONS_LIST_IS_EMPTY);
        }
 
        return (mapResponse);
    }

    public static Map<String, Object> getPickListAttendantPauseOptions() {
        Map<String, Object> mapResponse = new Map<String, Object>();

        try {
            List<StoreServiceManagerTO.ItemPicklistValue> ltAttendantPauseOptions;

            List<GenericOptionsLists__c> ltActiveAttendantPauseOptions = 
                GenericOptionsListsDAO.getByAPINameUsedInActive(OPERATIONAL_INFORMATIONS, ATTENDANT_PAUSE_OPTIONS);

            if (ltActiveAttendantPauseOptions != null && ltActiveAttendantPauseOptions.size() > 0) {
                ltAttendantPauseOptions = new List<StoreServiceManagerTO.ItemPicklistValue>();

                for (GenericOptionsLists__c activePauseOptions : ltActiveAttendantPauseOptions) {
                    StoreServiceManagerTO.ItemPicklistValue picklistValue = 
                        new StoreServiceManagerTO.ItemPicklistValue();

                    picklistValue.value = activePauseOptions.Code__c;
                    picklistValue.label = activePauseOptions.Description__c;
                    picklistValue.instruction = activePauseOptions.description2__c;

                    ltAttendantPauseOptions.add(picklistValue);
                }
            }

            if (ltAttendantPauseOptions != null && ltAttendantPauseOptions.size() > 0) {
                mapResponse.put('success', ltAttendantPauseOptions);

            } else {
                // Pause reasons list is empty
                mapResponse.put('error', ERROR_PAUSE_REASONS_LIST_IS_EMPTY);
            }

        } catch (Exception e) {
            mapResponse.clear();
    
            mapResponse.put('error', GENERIC_ERROR_MESSAGE);
        }
    
        return (mapResponse);
    }

    public static Map<String, Object> startService(String workPositionId) {
        Map<String, Object> mapResponse = new Map<String, Object>();

        try {
            mapResponse = UpdateWorkPositionCallout.execute(workPositionId, true);

        } catch (Exception e) {
            mapResponse.put('error', GENERIC_ERROR_MESSAGE);
        }
    
        return (mapResponse);
    }

    public static Map<String, Object> endService(String workPositionId) {
        Map<String, Object> mapResponse = new Map<String, Object>();

        try {
            mapResponse = UpdateWorkPositionCallout.execute(workPositionId, false);

        } catch (Exception e) {
            mapResponse.put('error', GENERIC_ERROR_MESSAGE);
        }
    
        return (mapResponse);
    }

    public static Map<String, Object> forceRestartService(String workPositionId) {
        Map<String, Object> mapResponse = endService(workPositionId);

        if (mapResponse.get('success') != null) {
            mapResponse = startService(workPositionId);
        }

        return (mapResponse);
    }

    public static Map<String, Object> pauseService(StoreServiceManagerTO.ItemPicklistValue pauseReason) {
        Map<String, Object> mapResponse = new Map<String, Object>();

        try {
            mapResponse = PointOfServiceAttendantCallout.execute(pauseReason);

        } catch (Exception e) {
            mapResponse.put('error', GENERIC_ERROR_MESSAGE);
        }
    
        return (mapResponse);
    }

    public static Map<String, Object> resumeService() {
        Map<String, Object> mapResponse = new Map<String, Object>();

        try {
            mapResponse = PointOfServiceAttendantCallout.execute();

        } catch (Exception e) {
            mapResponse.put('error', GENERIC_ERROR_MESSAGE);
        }
    
        return (mapResponse);
    }
}
