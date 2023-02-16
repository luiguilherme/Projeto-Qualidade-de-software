/*
    Discontinued. Technical debt: to be removed!

    ---------------------------------------------------
    @author - Márcio Las
    @company - Telefonica  
    @date - 04/05/2022
    @description - Class Engine for SSMAttendanceCustomerData
    ---------------------------------------------------
*/
public with sharing class SSMAttendanceCustomerDataEngine {
    // For testing purposes only
    public static String getTestingPurposesOnlyMessage() {
        return ('For testing purposes only');
    }

    /* 
    private static final String OPERATIONAL_INFORMATIONS = 'OperationalInformations';
    
    private static final String BUSINESS_LINES = 'BusinessLines';
    private static final String DOCUMENT_TYPES = 'DocumentTypes';

    private static final Integer ERROR_LOADING_COMPONENT = 601;

    public static Map<String, Object> loadSSMAttendanceCustomerData() {
        Map<String, Object> mapResponse = new Map<String, Object>();

        Map<String, Object> mapCategories = getCategoriesList();
        
        if (mapCategories.get('success') != null) {
            mapResponse.put('categories', mapCategories.get('success'));
            
        } else {
            mapResponse.put('error', mapCategories.get('error'));
        }

        Map<String, Object> mapDocumentTypes = getDocumentTypesList();

        if (mapDocumentTypes.get('success') != null) {
            mapResponse.put('documentTypes', mapDocumentTypes.get('success'));

        } else {
            if (mapResponse.get('error') == null) {
                mapResponse.put('error', mapDocumentTypes.get('error'));
            }
        }

        return (mapResponse);
    }

    public static Map<String, Object> getCategoriesList() {
        Map<String, Object> mapResponse = getPicklistValuesList(OPERATIONAL_INFORMATIONS, BUSINESS_LINES);

        return (mapResponse);
    }

    public static Map<String, Object> getDocumentTypesList() {
        Map<String, Object> mapResponse = getPicklistValuesList(DOCUMENT_TYPES, DOCUMENT_TYPES);

        return (mapResponse);
    }

    public static Map<String, Object> getPicklistValuesList(String apiName, String usedIn) {
        Map<String, Object> mapResponse = new Map<String, Object>();

        List<StoreServiceManagerTO.ItemPicklistValue> ltPicklistValues = 
            new List<StoreServiceManagerTO.ItemPicklistValue>();

        List<GenericOptionsLists__c> ltGenericOptions = 
            GenericOptionsListsDAO.getByAPINameUsedInActive(apiName, usedIn);

        if (ltGenericOptions != null && ltGenericOptions.size() > 0) {
            for (GenericOptionsLists__c genericOption : ltGenericOptions) {
                StoreServiceManagerTO.ItemPicklistValue itemPicklist = 
                    new StoreServiceManagerTO.ItemPicklistValue();

                itemPicklist.label = genericOption.Description__c;
                itemPicklist.value = genericOption.Code__c;
                itemPicklist.instruction = genericOption.description2__c;

                ltPicklistValues.add(itemPicklist);
            }
        }
        
        if (ltPicklistValues.size() > 0) {
            mapResponse.put('success', ltPicklistValues);

        } else {
            mapResponse.put('error', ERROR_LOADING_COMPONENT);
        }

        return (mapResponse);
    }
    */
}
