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
    private static final String SEGMENT_NOT_CUSTOMER_ID = '3';

    private static final Integer ERROR_LOADING_USER_INFORMATION = 602;
    private static final Integer ERROR_USER_NOT_RELATED_TO_STORE = 610;
    private static final Integer ERROR_POSITIONS_LIST_IS_EMPTY = 611;
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

            if (attendant == null || String.isBlank(attendant.Login__c)) {
                mapResponse.put('error', ERROR_LOADING_USER_INFORMATION);

            } else {
                Map<String, Object> mapResponseCallout = fetchPointOfService();

                if (mapResponseCallout.get('success') != null) {
                    String jsonPointOfService = (String) mapResponseCallout.get('success');

                    StoreServiceManagerResponse.PointOfService pointOfService = (StoreServiceManagerResponse.PointOfService) 
                        JSON.deserialize(jsonPointOfService, StoreServiceManagerResponse.PointOfService.class);

                    if (pointOfService != null && pointOfService.id != null) {
                        List<StoreServiceManagerTO.ItemPicklistValue> ltWorkPositions = 
                            new List<StoreServiceManagerTO.ItemPicklistValue>();
                        
                        updateUserStoreInfo(attendant, pointOfService);

                        if (pointOfService.workPosition != null) {
                            ltWorkPositions = getWorkPositionsPickList(pointOfService.workPosition);
                        }

                        mapResponse.put('attendant', attendant);
                        mapResponse.put('workPositionsList', ltWorkPositions);
                        mapResponse.put('partnerCommunityLicense', isPartnerCommunityLicense(attendant));
                        mapResponse.put('params', getParams());              

                    } else {
                        updateUserStoreInfo(attendant, null);

                        mapResponse.put('error', ERROR_USER_NOT_RELATED_TO_STORE);
                    }
                    
                } else {
                    mapResponse.put('error', mapResponseCallout.get('error'));
                }
            }

        } catch (Exception e) {
            mapResponse.clear();
    
            mapResponse.put('error', GENERIC_ERROR_MESSAGE);
        }
    
        return (mapResponse);
    }

    public static Map<String, Object> fetchPointOfService() {
        Map<String, Object> mapResponseCallout = new Map<String, Object>();

        try {
            mapResponseCallout = PointOfServiceCallout.execute();

        } catch (Exception e) {
            mapResponseCallout.clear();
    
            mapResponseCallout.put('error', GENERIC_ERROR_MESSAGE);
        }
    
        return (mapResponseCallout);
    }  
    
    public static Map<String, Object> fetchOperationalInformations() {
        Map<String, Object> mapResponseCallout = new Map<String, Object>();
        
        try {
            mapResponseCallout = OperationalInformationsCallout.execute();

            if (mapResponseCallout.get('success') != null) {
                String jsonOperationalInformations = (String) mapResponseCallout.get('success');

                StoreServiceManagerResponse.OperationalInformations operationalInformations = (StoreServiceManagerResponse.OperationalInformations) 
                    JSON.deserialize(jsonOperationalInformations, StoreServiceManagerResponse.OperationalInformations.class);

                if (operationalInformations != null) {
                    updateOperationalInformations(operationalInformations);
                }
            }

        } catch (Exception e) {
            mapResponseCallout.clear();
    
            mapResponseCallout.put('error', GENERIC_ERROR_MESSAGE);
        }

        return (mapResponseCallout);
    }

    public static Map<String, Object> fetchInformationStatus() {
		Map<String, Object> mapResponse = new Map<String, Object>();
		
		try {
			Map<String, Object> mapResponseCallout = QueueInformationStatusCallout.execute();

            if (mapResponseCallout.get('success') != null) {
                String jsonInformationStatus = (String) mapResponseCallout.get('success');
        
                List<StoreServiceManagerResponse.InformationStatus> ltInformationStatus = (List<StoreServiceManagerResponse.InformationStatus>) 
                    JSON.deserialize(jsonInformationStatus, List<StoreServiceManagerResponse.InformationStatus>.class);
        
                StoreServiceManagerTO.PositionInformationStatus informationStatus = new StoreServiceManagerTO.PositionInformationStatus();

                if (ltInformationStatus != null && !ltInformationStatus.isEmpty() && 
                    ltInformationStatus[0].O_ST_POSICAO_ATENDIMENTO != null
                ) {
                    informationStatus.workPositionId = ltInformationStatus[0].O_ST_POSICAO_ATENDIMENTO;
                    informationStatus.statusPosition = ltInformationStatus[0].O_ST_STATUS;
                }

                mapResponse.put('success', informationStatus);

            } else {
                mapResponse.put('error', mapResponseCallout.get('error'));
            }

        } catch (Exception e) {  
            mapResponse.put('error', GENERIC_ERROR_MESSAGE);
        }
		
        return (mapResponse);
    }

    public static Map<String, Object> fetchInformationAttendance() {
		Map<String, Object> mapResponse = new Map<String, Object>();

        try {
			Map<String, Object> mapResponseCallout = QueueInformationAttendanceCallout.execute();
			
            if (mapResponseCallout.get('success') != null) {
                String jsonInformationAttendance = (String) mapResponseCallout.get('success');
    
                List<StoreServiceManagerResponse.InformationAttendance> ltInformationAttendance = (List<StoreServiceManagerResponse.InformationAttendance>) 
                    JSON.deserialize(jsonInformationAttendance, List<StoreServiceManagerResponse.InformationAttendance>.class);
    
                StoreServiceManagerTO.AttendanceInformationStatus informationAttendance = new StoreServiceManagerTO.AttendanceInformationStatus();

                if (ltInformationAttendance != null && !ltInformationAttendance.isEmpty() &&
                    ltInformationAttendance[0].O_TP_STATUS != null
                ) {
                    if (ltInformationAttendance[0].O_TP_STATUS == '2' && ltInformationAttendance[0].O_ST_SENHA != null) {
                        // Get the object's ticket record ID
                        User attendant = UserDAO.getById(UserInfo.getUserId());

                        ServiceTicket__c ticket = ServiceTicketDAO.getGSSInServiceByStoreLoginAndTicketId(
                            attendant.StoreCode__c, attendant.Login__c, ltInformationAttendance[0].O_ST_SENHA
                        );

                        if (ticket != null) {
                            informationAttendance.Id = ticket.Id;
                            informationAttendance.createdDateTime = (DateTime.valueOf(ticket.CreatedDate)).formatGmt('YYYY-MM-dd HH:mm:ss');

                            informationAttendance.statusAttendance = ltInformationAttendance[0].O_TP_STATUS;
                            informationAttendance.ticketId = ltInformationAttendance[0].O_ST_SENHA;
                            
                            informationAttendance.segmentationId = (
                                (ltInformationAttendance[0].O_CD_SEGMENTACAO_CLIENTE != null) 
                                ? ltInformationAttendance[0].O_CD_SEGMENTACAO_CLIENTE 
                                : ''
                            );
                        
                            informationAttendance.segmentationName = (
                                (ltInformationAttendance[0].O_ST_SEGMENTACAO_CLIENTE != null) 
                                ? ltInformationAttendance[0].O_ST_SEGMENTACAO_CLIENTE 
                                : ''
                            );

                            informationAttendance.waitTime = (
                                (ltInformationAttendance[0].O_DT_TEMPO_ESPERA != null) 
                                ? (
                                    (ltInformationAttendance[0].O_DT_TEMPO_ESPERA.contains(' '))
                                    ? ltInformationAttendance[0].O_DT_TEMPO_ESPERA.split(' ')[1]
                                    : ltInformationAttendance[0].O_DT_TEMPO_ESPERA          
                                )
                                : ''
                            );

                            informationAttendance.duration = (
                                (ltInformationAttendance[0].O_DT_TEMPO_ATENDIMENTO != null) 
                                ? (
                                    (ltInformationAttendance[0].O_DT_TEMPO_ATENDIMENTO.contains(' '))
                                    ? ltInformationAttendance[0].O_DT_TEMPO_ATENDIMENTO.split(' ')[1]
                                    : ltInformationAttendance[0].O_DT_TEMPO_ATENDIMENTO          
                                )
                                : ''
                            );
                        
                            informationAttendance.customerCellPhone = (
                                ((ltInformationAttendance[0].O_ST_DDD != null) 
                                    ? ltInformationAttendance[0].O_ST_DDD 
                                    : ''
                                ) + 
                                ((ltInformationAttendance[0].O_ST_TELEFONE != null) 
                                    ? '-' + ltInformationAttendance[0].O_ST_TELEFONE 
                                    : ''
                                )
                            );
                        
                            informationAttendance.serviceName = (
                                (ltInformationAttendance[0].O_ST_DESCRICAO != null) 
                                ? ltInformationAttendance[0].O_ST_DESCRICAO 
                                : ''
                            );
                        
                            informationAttendance.type = (
                                (ltInformationAttendance[0].O_TP_TIPO != null) 
                                ? ltInformationAttendance[0].O_TP_TIPO 
                                : ''
                            );
                        
                            if (ticket.ServiceStart__c == null) {
                                informationAttendance.startTime = (DateTime.now()).formatGmt('YYYY-MM-dd HH:mm:ss');

                            } else {
                                informationAttendance.startTime = (DateTime.valueOf(ticket.ServiceStart__c)).formatGmt('YYYY-MM-dd HH:mm:ss');
                            }

                            informationAttendance.customerName = (
                                (ltInformationAttendance[0].O_ST_NOME != null) 
                                ? ltInformationAttendance[0].O_ST_NOME 
                                : ''
                            );

                            informationAttendance.customerDocument = (
                                (ltInformationAttendance[0].O_ST_CPF != null) 
                                ? ltInformationAttendance[0].O_ST_CPF 
                                : ''
                            );
                        }

                    } else if (ltInformationAttendance[0].O_TP_STATUS == '4') {
                        informationAttendance.pauseReasonId = '9999';
                    }
                }

                mapResponse.put('success', informationAttendance);
            }

        } catch (Exception e) {   
            mapResponse.put('error', GENERIC_ERROR_MESSAGE);
        }

        return (mapResponse);
    }

    public static List<StoreServiceManagerTO.ItemPicklistValue> getWorkPositionsPickList(List<StoreServiceManagerResponse.WorkPosition> ltPointOfServiceWorkPosition) {
            List<StoreServiceManagerTO.ItemPicklistValue> ltWorkPositions = new List<StoreServiceManagerTO.ItemPicklistValue>();

        if (ltPointOfServiceWorkPosition == null) {
            Map<String, Object> mapResponseCallout = fetchPointOfService();

            if (mapResponseCallout.get('success') != null) {                  
                String jsonPointOfService = (String) mapResponseCallout.get('success');

                StoreServiceManagerResponse.PointOfService pointOfService = (StoreServiceManagerResponse.PointOfService) 
                    JSON.deserialize(jsonPointOfService, StoreServiceManagerResponse.PointOfService.class);

                if (pointOfService != null && pointOfService.workPosition != null) {
                    ltPointOfServiceWorkPosition = pointOfService.workPosition;
                }
            }
        }

        if (ltPointOfServiceWorkPosition != null) {
            for (StoreServiceManagerResponse.WorkPosition workPosition : ltPointOfServiceWorkPosition) {
                StoreServiceManagerTO.ItemPicklistValue picklistValue = 
                    new StoreServiceManagerTO.ItemPicklistValue();

                picklistValue.value = workPosition.id;
                picklistValue.label = workPosition.id;

                ltWorkPositions.add(picklistValue);
            }
        }

        return (ltWorkPositions);
    }

    private static void updateUserStoreInfo(User attendant, StoreServiceManagerResponse.PointOfService pointOfService) {
        attendant.StoreCode__c = ((pointOfService != null) ? String.valueOf(pointOfService.id) : '');
        attendant.StoreName__c = ((pointOfService != null) ? pointOfService.name : '');
        attendant.StoreSegment__c = ((pointOfService != null) ? pointOfService.segment.name : '');
        attendant.StoreConsultationDate__c = Date.today();

        update attendant;
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

        segment.value = SEGMENT_NOT_CUSTOMER_ID;
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

    public static Boolean isPartnerCommunityLicense() {
        User currentUser = UserDAO.getById(UserInfo.getUserId());
        
        return (isPartnerCommunityLicense(currentUser));
    }

    public static Boolean isPartnerCommunityLicense(User userToCheck) {
        Boolean isPartnerCommunity = false;
        
        if (userToCheck != null) {
            try {
                isPartnerCommunity = (userToCheck.Profile.UserLicense.Name == 'Partner Community');

            } catch (Exception e) {

            }
        }

        return (isPartnerCommunity);
    }

    public static Map<String, Object> getParams() {
        Map<String, Object> mapParams = new Map<String, Object>();

        try {
            List<GeneralParam__c> ltParam = GeneralParamDAO.getLoadParams();
    
            if (!ltParam.isEmpty()) {
                mapParams.put('viewFieldService', ltParam[0].ViewFieldServiceStoreService__c);
                mapParams.put('timeAutomaticTicketCall', ltParam[0].TimeAutomaticTicketCall__c);
                mapParams.put('timeAutomaticUpdateTickets', ltParam[0].TimeAutomaticUpdateTickets__c);
            }

        } catch (Exception e) {

        }

        if (mapParams.get('viewFieldService') == null) {
            mapParams.clear();

            mapParams.put('viewFieldService', false);
            mapParams.put('timeAutomaticTicketCall', 10);
            mapParams.put('timeAutomaticUpdateTickets', 0);
        }

        return (mapParams);
    }

    public static String calculateStartTime(String elapsedTime) {
        DateTime dtCurrent = DateTime.now();
        DateTime dtStart;

        if (!String.isBlank(elapsedTime)) {
            try {
                String[] ltElapsedTime = (
                    (elapsedTime.contains(' '))
                    ? elapsedTime.split(' ')[1].split(':')
                    : elapsedTime.split(':')
                );

                dtStart = (dtCurrent
                    .addHours(-1 * Integer.valueOf(ltElapsedTime[0]))
                    .addMinutes(-1 * Integer.valueOf(ltElapsedTime[1]))
                    .addSeconds(-1 * Integer.valueOf(ltElapsedTime[2]))
                );
                
            } catch (Exception e) {

            }
        }

        if (dtStart == null) {
            dtStart = dtCurrent;
        }

        return (dtStart.formatGmt('YYYY-MM-dd HH:mm:ss'));
    }    

    public static Double calculateElapsedTimeInMilliseconds(String startTime, String finalTime) {
        Double millisecondsElapsedTime = 0;
 
        if (!String.isBlank(startTime) && !String.isBlank(finalTime) && !startTime.equals(finalTime)) {
            try {
                // Start date/time
                String[] ltStartTime = ((startTime.contains(' '))
                                        ? startTime.split(' ')[1].split(':')
                                        : startTime.split(':')
                                    );
                
                DateTime dtStartTime = Datetime.newInstanceGmt(
                    Datetime.now().year(), 
                    Datetime.now().month(), 
                    Datetime.now().day(), 
                    Integer.valueOf(ltStartTime[0]), 
                    Integer.valueOf(ltStartTime[1]), 
                    Integer.valueOf(ltStartTime[2])
                );
                
                // Final date/time
                String[] ltFinalTime = ((finalTime.contains(' '))
                                        ? finalTime.split(' ')[1].split(':')
                                        : finalTime.split(':')
                                    );
                
                DateTime dtFinalTime = Datetime.newInstanceGmt(
                    Datetime.now().year(), 
                    Datetime.now().month(), 
                    Datetime.now().day(), 
                    Integer.valueOf(ltFinalTime[0]), 
                    Integer.valueOf(ltFinalTime[1]), 
                    Integer.valueOf(ltFinalTime[2])
                );
                
                // Calculate elapsed time
                millisecondsElapsedTime = Math.abs(dtFinalTime.getTime() - dtStartTime.getTime());

            } catch (Exception e) {

            }
        }

        return (millisecondsElapsedTime);
    }

    public static String calculateElapsedTime(Double millisecondsElapsedTime) {
        String elapsedTime = '00:00:00';

        if (millisecondsElapsedTime != null && millisecondsElapsedTime > 0) {
            Integer seconds = Integer.valueOf(Math.floor(millisecondsElapsedTime / 1000));
            Integer minutes = Integer.valueOf(Math.floor(seconds / 60));
            Integer hours = Integer.valueOf(Math.floor(minutes / 60));
            
            seconds = Math.mod(seconds, 60);
            minutes = Math.mod(minutes, 60);
            hours = Math.mod(hours, 24);
            
            elapsedTime = (
                String.valueOf(hours).leftPad(2, '0') + ':' +
                String.valueOf(minutes).leftPad(2, '0') + ':' +
                String.valueOf(seconds).leftPad(2, '0').substring(0, 2)
            );
        }

        return (elapsedTime.substring(0, 8));
    }

    public static String calculateElapsedTime(String startTime, String finalTime) {
        Double elapsedTime = calculateElapsedTimeInMilliseconds(startTime, finalTime);

        return (calculateElapsedTime(elapsedTime));
    }
}
