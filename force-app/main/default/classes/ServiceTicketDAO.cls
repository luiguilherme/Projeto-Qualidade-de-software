public with sharing class ServiceTicketDAO {
    public static final String SOBJECT_NAME = 'ServiceTicket__c';

    public static final String FIELD_ID = 'Id'; 
    public static final String FIELD_CREATEDDATE = 'CreatedDate'; 
    public static final String FIELD_RECORDTYPEID = 'RecordTypeId'; 
    public static final String FIELD_EXTERNALID = 'ExternalID__c'; 
    public static final String FIELD_STORE = 'Store__c'; 
    public static final String FIELD_TICKETID = 'TicketId__c'; 
    public static final String FIELD_STATUS = 'Status__c'; 
    public static final String FIELD_SPECIALNEEDS = 'SpecialNeeds__c'; 
    public static final String FIELD_PRIORITY = 'Priority__c'; 
    public static final String FIELD_CUSTOMERNAME = 'CustomerName__c'; 
    public static final String FIELD_ALIAS = 'Alias__c'; 
    public static final String FIELD_DOCUMENT = 'Document__c'; 
    public static final String FIELD_GEOGRAPHICAREACODE = 'GeographicAreaCode__c'; 
    public static final String FIELD_NETWORKNUMBER = 'NetworkNumber__c'; 
    public static final String FIELD_SEGMENTID = 'SegmentID__c'; 
    public static final String FIELD_SEGMENTNAME = 'SegmentName__c'; 
    public static final String FIELD_ACTIVITY = 'Activity__c'; 
    public static final String FIELD_ACTIVITYPRIORITY = 'ActivityPriority__c'; 
    public static final String FIELD_PROTOCOL = 'Protocol__c'; 
    public static final String FIELD_INTERACTIONID = 'InteractionID__c'; 
    public static final String FIELD_INTERACTIONNAME = 'InteractionName__c'; 
    public static final String FIELD_WAITTIME = 'WaitTime__c'; 
    public static final String FIELD_LOGIN = 'Login__c'; 
    public static final String FIELD_SERVICESTART = 'ServiceStart__c'; 
    public static final String FIELD_SERVICEEND = 'ServiceEnd__c'; 
    public static final String FIELD_DURATION = 'Duration__c'; 
    public static final String FIELD_BUSINESSLINEID = 'BusinessLineID__c'; 
    public static final String FIELD_BUSINESSLINENAME = 'BusinessLineName__c'; 
    public static final String FIELD_MAINDOCUMENTTYPEID = 'MainDocumentTypeID__c'; 
    public static final String FIELD_MAINDOCUMENTTYPENAME = 'MainDocumentTypeName__c'; 
    public static final String FIELD_DOCUMENTNUMBER = 'DocumentNumber__c'; 
    public static final String FIELD_ACTIVITIES = 'Activities__c'; 
    public static final String FIELD_NOTES = 'Notes__c'; 
    public static final String FIELD_SFPRIORITY = 'SFPriority__c'; 

    public static final String[] DEFAULT_FIELDS = new String[] {
        FIELD_ID, 
        FIELD_CREATEDDATE, 
        FIELD_RECORDTYPEID, 
        FIELD_EXTERNALID, 
        FIELD_STORE, 
        FIELD_TICKETID, 
        FIELD_STATUS, 
        FIELD_SPECIALNEEDS, 
        FIELD_PRIORITY, 
        FIELD_CUSTOMERNAME, 
        FIELD_ALIAS, 
        FIELD_DOCUMENT, 
        FIELD_GEOGRAPHICAREACODE, 
        FIELD_NETWORKNUMBER, 
        FIELD_SEGMENTID, 
        FIELD_SEGMENTNAME, 
        FIELD_ACTIVITY, 
        FIELD_ACTIVITYPRIORITY, 
        FIELD_PROTOCOL, 
        FIELD_INTERACTIONID, 
        FIELD_INTERACTIONNAME, 
        FIELD_WAITTIME, 
        FIELD_LOGIN, 
        FIELD_SERVICESTART, 
        FIELD_SERVICEEND, 
        FIELD_DURATION, 
        FIELD_BUSINESSLINEID, 
        FIELD_BUSINESSLINENAME, 
        FIELD_MAINDOCUMENTTYPEID, 
        FIELD_MAINDOCUMENTTYPENAME, 
        FIELD_DOCUMENTNUMBER, 
        FIELD_ACTIVITIES, 
        FIELD_NOTES, 
        FIELD_SFPRIORITY
    };

    public static final String GSS_RECORD_TYPE_NAME = 'StoreServiceManager';

    public static final String GSS_STATUS_ON_HOLD = 'On hold';
    public static final String GSS_STATUS_IN_SERVICE = 'In Service';
    public static final String GSS_STATUS_CANCELED = 'Canceled';
    public static final String GSS_STATUS_CLOSED = 'Closed';

    private static String[] ignoredFields = new String[]{};

    public static Schema.DescribeSObjectResult getSchemaDescribe() {
        return (Schema.getGlobalDescribe().get(SOBJECT_NAME).getDescribe());
    }

    public static Boolean isAccessible() {       
        return (getSchemaDescribe().isAccessible());
    }

    public static Schema.DescribeFieldResult getSchemaFieldDescribe(String fieldName) {
        return (getSchemaDescribe().fields.getMap().get(fieldName).getDescribe());
    }

    public static Boolean isFieldAccessible(String fieldName) {
        return (getSchemaFieldDescribe(fieldName).isAccessible());
    }

    public static Id getRecordTypeId(String recordTypeName) {
        return (SObjectType.ServiceTicket__c.getRecordTypeInfosByDeveloperName().get(recordTypeName).getRecordTypeId());
    }

    public static Id getGSSRecordTypeId() {
        return (SObjectType.ServiceTicket__c.getRecordTypeInfosByDeveloperName().get(GSS_RECORD_TYPE_NAME).getRecordTypeId());
    }

    private static String getFields(String[] fieldNames) {
        String[] fields = new String[]{};

        ignoredFields = new String[]{};

        if (fieldNames == null || fieldNames.size() == 0) {
            fieldNames = DEFAULT_FIELDS;
        }

        for (String field : fieldNames) {
            /*if (isFieldAccessible(field)) {*/
                fields.add(field);

            /*} else {
                ignoredFields.add(field);
            }*/
        }

        return (fields.size() > 0 ? String.join(fields, ', ') : '');
    }

    private static String getStandardQueryCmd() {
        return (getStandardQueryCmd(DEFAULT_FIELDS));
    }

    private static String getStandardQueryCmd(String[] fieldNames) {
        /*if (!isAccessible()) {
            return ('');
        }*/

        String fields = getFields(fieldNames);

        if (String.isBlank(fields)) {
            return ('');
        }

        return ('SELECT ' + fields + ' FROM ' + SOBJECT_NAME);
    }

    public static ServiceTicket__c getById(Id serviceTicketId) {
        return (getById(serviceTicketId, DEFAULT_FIELDS));
    }

    public static ServiceTicket__c getById(Id serviceTicketId, String[] fieldNames) {
        List<ServiceTicket__c> lstServiceTicket = getByIds(new Set<Id>{serviceTicketId}, fieldNames);

        return ((lstServiceTicket == null || lstServiceTicket.isEmpty()) ? null : lstServiceTicket[0]);
    }

    public static List<ServiceTicket__c> getByIds(Set<Id> serviceTicketId) {
        return (getByIds(serviceTicketId, DEFAULT_FIELDS));
    }

    public static List<ServiceTicket__c> getByIds(Set<Id> serviceTicketId, String[] fieldNames) {
        String queryCmd = getStandardQueryCmd(fieldNames);

        if (String.isBlank(queryCmd)) {
            return (new List<ServiceTicket__c>());
        }

        String whereCondition = (' WHERE ' + 
            FIELD_ID + ' IN :serviceTicketId'
        );

        queryCmd = (queryCmd + whereCondition);

        return (Database.query(queryCmd));
    }

    public static List<ServiceTicket__c> getByRecordTypeAndStoreAndStatus(String recordTypeName, String store, String status, String[] fieldNames) {
        Id recordTypeId = getRecordTypeId(recordTypeName);

        String queryCmd = getStandardQueryCmd();

        if (String.isBlank(queryCmd)) {
            return (new List<ServiceTicket__c>());
        }

        String whereCondition = (' WHERE ' + 
            FIELD_RECORDTYPEID + ' = \'' + recordTypeId + '\' AND ' + 
            FIELD_STORE + ' = \'' + store + '\' AND ' + 
            FIELD_STATUS + ' = \'' + status + '\' AND ' + 
            FIELD_CREATEDDATE + ' = TODAY'
        );

        String orderBy = (' ORDER BY ' + 
            FIELD_SFPRIORITY + ', ' + FIELD_ACTIVITYPRIORITY + ', ' + FIELD_CREATEDDATE
        );

        queryCmd = (queryCmd + whereCondition + orderBy);

        return (Database.query(queryCmd));
    }

    public static List<ServiceTicket__c> getGSSOnHold(String store) {
        return (getByRecordTypeAndStoreAndStatus(GSS_RECORD_TYPE_NAME, store, GSS_STATUS_ON_HOLD, DEFAULT_FIELDS));
    }
}