/*
    ---------------------------------------------------
    @author - Márcio Las
    @company - Telefonica  
    @date - 15/03/2022
    @description - Class Engine for  StoreServiceManager
    ---------------------------------------------------
*/
public with sharing class StoreServiceManagerEngine {
    private static final String POINT_OF_SERVICE = 'PointOfService';
    private static final String OPERATIONAL_INFORMATIONS = 'OperationalInformations';

    private static final String WORK_POSITIONS = 'WorkPositions';
    private static final String ATTENDANT_PAUSE_OPTIONS = 'AttendantPauseOptions';
    private static final String BUSINESS_LINES = 'BusinessLines';
    private static final String QUITTING_REASONS = 'QuittingReasons';
    private static final String INTERACTIONS = 'Interactions';
    private static final String DOCUMENT_TYPES = 'DocumentTypes';

    private static final String CUSTOMER_SEGMENT = 'CustomerSegment';
    private static final String SEGMENT_NORMAL_CUSTOMER_ID = '3';

    private static final Integer ERROR_LOADING_USER_INFORMATION = 602;
    private static final Integer ERROR_USER_NOT_RELATED_TO_STORE = 610;
    private static final Integer GENERIC_ERROR_MESSAGE = 699;

    public static Boolean hasPermissionSetToAccess() {
        List<PermissionSetAssignment> ltPSA = PermissionSetAssigmentDAO.getCurrentPSA(
            UserInfo.getUserId(), 
            System.Label.NameOfPermissionSetToAccessStoreServiceManager
        );

        return (!ltPSA.isEmpty());
    }
    
    public static Map<String, Object> loadStoreServiceManager() {
        Map<String, Object> mapResponse = new Map<String, Object>();

        try {
            User attendant = UserDAO.getById(UserInfo.getUserId());

            if (attendant == null) {
                mapResponse.put('error', ERROR_LOADING_USER_INFORMATION);

            } else {
                if (String.isBlank(attendant.StoreCode__c) || 
                    String.isBlank(attendant.StoreSegment__c) || 
                    attendant.StoreConsultationDate__c == null || 
                    Date.today() > attendant.StoreConsultationDate__c
                ) {
                    Map<String, Object> mapResponseCallout = fetchPointOfService(attendant);

                    if (mapResponseCallout.get('success') != null) {
                        if (String.isBlank(attendant.StoreCode__c)) {
                            mapResponse.put('error', ERROR_USER_NOT_RELATED_TO_STORE);
                        }
                        
                    } else {
                        mapResponse.put('error', mapResponseCallout.get('error'));
                    }
                }

                if (mapResponse.get('error') == null) {
                    mapResponse.put('success', attendant);
                }
            }

        } catch (Exception e) {
            mapResponse.clear();
    
            mapResponse.put('error', GENERIC_ERROR_MESSAGE);
        }
    
        return (mapResponse);
    }

    public static Map<String, Object> fetchPointOfService() {
        Map<String, Object> mapResponse = new Map<String, Object>();

        try {
            mapResponse = fetchPointOfService(null);

        } catch (Exception e) {
            mapResponse.clear();
    
            mapResponse.put('error', GENERIC_ERROR_MESSAGE);
        }
    
        return (mapResponse);
    }

    public static Map<String, Object> fetchPointOfService(User attendant) {
        Map<String, Object> mapResponseCallout = PointOfServiceCallout.execute();

        if (mapResponseCallout.get('success') != null) {
            String jsonPointOfService = (String) mapResponseCallout.get('success');

            StoreServiceManagerResponse.PointOfService pointOfService = (StoreServiceManagerResponse.PointOfService) 
                JSON.deserialize(jsonPointOfService, StoreServiceManagerResponse.PointOfService.class);

            List<StoreServiceManagerResponse.WorkPosition> ltWorkPositions;

            if (pointOfService != null && pointOfService.workPosition != null) {
                ltWorkPositions = pointOfService.workPosition;
            }
        
            if (attendant != null && pointOfService != null && pointOfService.id != null) {
                updateUserStoreInfo(attendant, pointOfService);
            }

            updateWorkPositions(ltWorkPositions);
        }

        return (mapResponseCallout);
    }

    private static void updateUserStoreInfo(User attendant, StoreServiceManagerResponse.PointOfService pointOfService) {
        attendant.StoreCode__c = String.valueOf(pointOfService.id);
        attendant.StoreName__c = pointOfService.name;
        attendant.StoreSegment__c = pointOfService.segment.name;
        attendant.StoreConsultationDate__c = Date.today();

        update attendant;
    }

    private static void updateWorkPositions(List<StoreServiceManagerResponse.WorkPosition> ltAPIWorkPositions) {
        List<GenericOptionsLists__c> ltWorkPositions = GenericOptionsListsDAO.getByAPINameUsedIn(POINT_OF_SERVICE, WORK_POSITIONS);
        
        Map<String, String> itemDefinition;
        
        if (!ltWorkPositions.isEmpty()) {
            for (Integer i = 0; i < ltWorkPositions.size(); i++) {
                ltWorkPositions[i].Active__c = false;
                ltWorkPositions[i].APIDateTime__c = Date.today();
            }
        }

        for (StoreServiceManagerResponse.WorkPosition workPosition : ltAPIWorkPositions) {
            itemDefinition = new Map<String, String>();
            
            itemDefinition.put('name', (WORK_POSITIONS + workPosition.id));
            itemDefinition.put('code', workPosition.id);
            itemDefinition.put('description', workPosition.id);
            itemDefinition.put('description2', '');
            itemDefinition.put('apiName', POINT_OF_SERVICE);
            itemDefinition.put('usedIn', WORK_POSITIONS);
    
            addGenericOptionsListsItem(ltWorkPositions, itemDefinition);
        }
    
        if (ltWorkPositions.size() > 0) {
            upsert ltWorkPositions;
        }
    }

    public static Map<String, Object> fetchOperationalInformations() {
        Map<String, Object> mapResponse = new Map<String, Object>();
        
        try {
            mapResponse = OperationalInformationsCallout.execute();

            if (mapResponse.get('success') != null) {
                String jsonOperationalInformations = (String) mapResponse.get('success');

                StoreServiceManagerResponse.OperationalInformations operationalInformations = (StoreServiceManagerResponse.OperationalInformations) 
                    JSON.deserialize(jsonOperationalInformations, StoreServiceManagerResponse.OperationalInformations.class);

                if (operationalInformations != null) {
                    updateOperationalInformations(operationalInformations);
                }
            }

        } catch (Exception e) {
            mapResponse.clear();
    
            mapResponse.put('error', GENERIC_ERROR_MESSAGE);
        }

        return (mapResponse);
    }

    private static void updateOperationalInformations(StoreServiceManagerResponse.OperationalInformations apiOperationalInformations) {
        List<GenericOptionsLists__c> ltOperationalInformations = GenericOptionsListsDAO.getByAPIName(OPERATIONAL_INFORMATIONS);

        if (!ltOperationalInformations.isEmpty()) {
            for (Integer i = 0; i < ltOperationalInformations.size(); i++) {
                ltOperationalInformations[i].Active__c = false;
                ltOperationalInformations[i].APIDateTime__c = Date.today();
            }
        }

        if (apiOperationalInformations.attendantPauseOptions != null) {
            addGenericOptionsListsItemTypeRootEntity(
                apiOperationalInformations.attendantPauseOptions, ltOperationalInformations, ATTENDANT_PAUSE_OPTIONS
            );
        }

        if (apiOperationalInformations.businessLines != null) {
            addGenericOptionsListsItemTypeRootEntity(
                apiOperationalInformations.businessLines, ltOperationalInformations, BUSINESS_LINES
            );
        }

        if (apiOperationalInformations.quittingReasons != null) {
            addGenericOptionsListsItemTypeRootEntity(
                apiOperationalInformations.quittingReasons, ltOperationalInformations, QUITTING_REASONS
            );
        }

        if (apiOperationalInformations.interactions != null) {
            addGenericOptionsListsItemTypeInteraction(
                apiOperationalInformations.interactions, ltOperationalInformations
            );
        }

        if (ltOperationalInformations.size() > 0) {
            upsert ltOperationalInformations;
        }
    }

    private static void addGenericOptionsListsItemTypeRootEntity(List<StoreServiceManagerResponse.RootEntity> ltAPIRootEntity, List<GenericOptionsLists__c> ltOperationalInformations, String usedIn) {
        Map<String, String> itemDefinition;

        for (StoreServiceManagerResponse.RootEntity rootEntity : ltAPIRootEntity) {
            itemDefinition = new Map<String, String>();
            
            itemDefinition.put('name', (usedIn + rootEntity.id));
            itemDefinition.put('code', rootEntity.id);

            itemDefinition.put('description', 
                ((usedIn == ATTENDANT_PAUSE_OPTIONS || usedIn == BUSINESS_LINES) 
                    ? rootEntity.name 
                    : rootEntity.description
                )
            );

            itemDefinition.put('description2',
                ((usedIn == ATTENDANT_PAUSE_OPTIONS || usedIn == BUSINESS_LINES) 
                    ? ((!String.isBlank(rootEntity.description)) ? rootEntity.description : '')
                    : ''
                )
            );

            itemDefinition.put('apiName', OPERATIONAL_INFORMATIONS);
            itemDefinition.put('usedIn', usedIn);

            addGenericOptionsListsItem(ltOperationalInformations, itemDefinition);
        }
    }

    private static void addGenericOptionsListsItemTypeInteraction(List<StoreServiceManagerResponse.Interaction> ltAPIInteraction, List<GenericOptionsLists__c> ltOperationalInformations) {
        Map<String, String> itemDefinition;

        for (StoreServiceManagerResponse.Interaction interaction : ltAPIInteraction) {
            itemDefinition = new Map<String, String>();

            itemDefinition.put('name', (INTERACTIONS + interaction.id));
            itemDefinition.put('code', interaction.id);
            itemDefinition.put('description', interaction.name);
            itemDefinition.put('description2', interaction.businessLine.name);
            itemDefinition.put('apiName', OPERATIONAL_INFORMATIONS);
            itemDefinition.put('usedIn', INTERACTIONS);

            addGenericOptionsListsItem(ltOperationalInformations, itemDefinition);
        }
    }

    private static void addGenericOptionsListsItem(List<GenericOptionsLists__c> ltGenericOptionsLists, Map<String, String> itemDefinition) {
        Boolean existGenericOptionsListItem = false;

        String itemAPIName = itemDefinition.get('apiName');
        String itemUsedIn = itemDefinition.get('usedIn');
        String itemCode = itemDefinition.get('code');

        if (!ltGenericOptionsLists.isEmpty()) {
            for (Integer i = 0; i < ltGenericOptionsLists.size(); i++) {
                if (ltGenericOptionsLists[i].APIName__c == itemAPIName &&
                    ltGenericOptionsLists[i].UsedIn__c == itemUsedIn &&
                    ltGenericOptionsLists[i].Code__c == itemCode
                ) {
                    ltGenericOptionsLists[i].Description__c = itemDefinition.get('description');
                    ltGenericOptionsLists[i].Description2__c = itemDefinition.get('description2');
                    ltGenericOptionsLists[i].APIDateTime__c = Date.today();
                    ltGenericOptionsLists[i].Active__c = true;

                    existGenericOptionsListItem = true;
 
                    break;
                }
            }
        }

        if (!existGenericOptionsListItem) {
            GenericOptionsLists__c genericOptionsListItem = new GenericOptionsLists__c(
                Name = itemDefinition.get('name'), 
                Code__c = itemCode, 
                Description__c = itemDefinition.get('description'), 
                Description2__c = itemDefinition.get('description2'), 
                APIName__c = itemAPIName, 
                APIDateTime__c = Date.today(), 
                UsedIn__c = itemUsedIn, 
                Active__c = true
            );

            ltGenericOptionsLists.add(genericOptionsListItem);
        }
    }

    public static StoreServiceManagerTO.ItemPicklistValue getAccountCustomerSegmentGSS(String accountCustomerSegment) {
        StoreServiceManagerTO.ItemPicklistValue segment = new StoreServiceManagerTO.ItemPicklistValue();

        segment.value = SEGMENT_NORMAL_CUSTOMER_ID;
        segment.label = '';

        if (!String.isBlank(accountCustomerSegment)) {
            List<GenericOptionsLists__c> ltCustomerSegmentName = GenericOptionsListsDAO.getByAPINameUsedInName(
                CUSTOMER_SEGMENT, CUSTOMER_SEGMENT, accountCustomerSegment
            );

            if (ltCustomerSegmentName.size() > 0) {
                segment.value = ltCustomerSegmentName[0].Description2__c;
                segment.label = ltCustomerSegmentName[0].Description__c;
            }
        }

        if (String.isBlank(segment.label)) {
            List<GenericOptionsLists__c> ltCustomerSegmentDescription2 = GenericOptionsListsDAO.getByAPINameUsedInDescription2(
                CUSTOMER_SEGMENT, CUSTOMER_SEGMENT, segment.value
            );

            if (ltCustomerSegmentDescription2.size() > 0) {
                segment.label = ltCustomerSegmentDescription2[0].Description__c;
            }
        }

        return (segment);
    }
}