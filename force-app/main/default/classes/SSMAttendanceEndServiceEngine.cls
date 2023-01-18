/*
    ---------------------------------------------------
    @author - Márcio Las
    @company - Telefonica  
    @date - 05/05/2022
    @description - Class Engine for SSMAttendanceEndService
    ---------------------------------------------------
*/
public with sharing class SSMAttendanceEndServiceEngine {
    private static final String OPERATIONAL_INFORMATIONS = 'OperationalInformations';
    private static final String INTERACTIONS = 'Interactions';

    private static final Integer ERROR_LOADING_COMPONENT = 601;

    public static Map<String, Object> loadSSMAttendanceEndService() {
        Map<String, Object> mapResponse = new Map<String, Object>();

        List<StoreServiceManagerTO.ItemPicklistValue> ltActivities = 
            new List<StoreServiceManagerTO.ItemPicklistValue>();

        List<GenericOptionsLists__c> ltInteractions = 
            GenericOptionsListsDAO.getByAPINameUsedInActive(OPERATIONAL_INFORMATIONS, INTERACTIONS);

        if (ltInteractions != null && ltInteractions.size() > 0) {
            for (GenericOptionsLists__c interaction : ltInteractions) {
                StoreServiceManagerTO.ItemPicklistValue activity = 
                    new StoreServiceManagerTO.ItemPicklistValue();

                activity.label = interaction.Description__c;
                activity.value = interaction.Code__c;
                activity.instruction = interaction.description2__c;

                ltActivities.add(activity);
            }
        }
        
        if (ltActivities.size() > 0) {
            mapResponse.put('success', ltActivities);

        } else {
            mapResponse.put('error', ERROR_LOADING_COMPONENT);
        }

        return (mapResponse);
    }
}