/*
    @author         Márcio Las
    @company        Telefónica | Vivo
    @date           30/10/2023
    @description    DAO Class for ServiceTicket__c
*/
public with sharing class ServiceTicketDAO {
    public static final String GSS_RECORD_TYPE_NAME = 'StoreServiceManager';
    public static final Id GSS_RECORD_TYPE_ID = getRecordTypeId(GSS_RECORD_TYPE_NAME);

    public static final String GSS_STATUS_ON_HOLD = 'On Hold';
    public static final String GSS_STATUS_IN_SERVICE = 'In Service';
    public static final String GSS_STATUS_CANCELED = 'Canceled';
    public static final String GSS_STATUS_CLOSED = 'Closed';

    public static Id getRecordTypeId(String recordTypeName) {
        return (SObjectType.ServiceTicket__c.getRecordTypeInfosByDeveloperName().get(recordTypeName).getRecordTypeId());
    }

    public static ServiceTicket__c getById(Id serviceTicketId) {
        List<ServiceTicket__c> lstServiceTicket = getByIds(new Set<Id>{serviceTicketId});

        return ((lstServiceTicket == null || lstServiceTicket.isEmpty()) ? null : lstServiceTicket[0]);
    }

    public static List<ServiceTicket__c> getByIds(Set<Id> serviceTicketId) {
        if (serviceTicketId == null) {
            return (new List<ServiceTicket__c>());
        }

        return ([
            SELECT
                Id, 
                CreatedDate, 
                RecordTypeId, 
                Store__c, 
                TicketId__c, 
                ExternalID__c, 
                SpecialNeeds__c, 
                Priority__c, 
                CustomerName__c, 
                Alias__c, 
                Document__c, 
                GeographicAreaCode__c, 
                NetworkNumber__c, 
                SegmentID__c, 
                SegmentName__c, 
                Activity__c, 
                ActivityPriority__c, 
                Protocol__c, 
                WaitTime__c, 
                Status__c, 
                Login__c, 
                ServiceStart__c, 
                ServiceEnd__c, 
                Duration__c, 
                InteractionID__c, 
                InteractionName__c, 
                BusinessLineID__c, 
                BusinessLineName__c, 
                MainDocumentTypeID__c, 
                MainDocumentTypeName__c, 
                DocumentNumber__c, 
                Activities__c, 
                Notes__c 
            FROM 
                ServiceTicket__c
            WHERE (
                Id IN :serviceTicketId
            )
        ]);
    }

    public static List<ServiceTicket__c> getByRecordTypeStoreAndStatus(String recordTypeName, String store, String status) {
        if (String.isBlank(recordTypeName)) {
            return (new List<ServiceTicket__c>());
        }

        Id recordTypeId = getRecordTypeId(recordTypeName);

        return (getByRecordTypeStoreAndStatus(recordTypeId, store, status));
    }

    public static List<ServiceTicket__c> getByRecordTypeStoreAndStatus(Id recordTypeId, String store, String status) {
        if (recordTypeId == null) {
            return (new List<ServiceTicket__c>());
        }

        if (String.isBlank(store)) {
            return (new List<ServiceTicket__c>());
        }

        if (String.isBlank(status)) {
            return (new List<ServiceTicket__c>());
        }

        return ([
            SELECT
                Id, 
                CreatedDate, 
                RecordTypeId, 
                Store__c, 
                TicketId__c, 
                ExternalID__c, 
                SpecialNeeds__c, 
                Priority__c, 
                CustomerName__c, 
                Alias__c, 
                Document__c, 
                GeographicAreaCode__c, 
                NetworkNumber__c, 
                SegmentID__c, 
                SegmentName__c, 
                Activity__c, 
                ActivityPriority__c, 
                Protocol__c, 
                WaitTime__c, 
                Status__c, 
                Login__c, 
                ServiceStart__c, 
                ServiceEnd__c, 
                Duration__c, 
                InteractionID__c, 
                InteractionName__c, 
                BusinessLineID__c, 
                BusinessLineName__c, 
                MainDocumentTypeID__c, 
                MainDocumentTypeName__c, 
                DocumentNumber__c, 
                Activities__c, 
                Notes__c 
            FROM 
                ServiceTicket__c 
            WHERE (
                RecordTypeId = :recordTypeId AND 
                Store__c = :store AND 
                Status__c = :status AND 
                CreatedDate = TODAY
            ) 
            ORDER BY 
                Priority__c, 
                ActivityPriority__c, 
                CreatedDate
        ]);
    }

    public static List<ServiceTicket__c> getGSSOnHoldByStore(String store) {
        return (getByRecordTypeStoreAndStatus(GSS_RECORD_TYPE_ID, store, GSS_STATUS_ON_HOLD));
    }

    public static ServiceTicket__c getGSSInServiceByStoreLoginAndTicketId(String store, String login, String ticketId) {
        List<ServiceTicket__c> lstServiceTicket = [
            SELECT
                Id, 
                CreatedDate, 
                RecordTypeId, 
                Store__c, 
                Login__c, 
                TicketId__c, 
                Status__c, 
                ServiceStart__c 
            FROM 
                ServiceTicket__c 
            WHERE (
                RecordTypeId = :GSS_RECORD_TYPE_ID AND 
                Store__c = :store AND 
                Login__c = :login AND 
                TicketId__c = :ticketId AND 
                Status__c = :GSS_STATUS_IN_SERVICE AND 
                CreatedDate = TODAY
            )
        ];
        
        return ((lstServiceTicket == null || lstServiceTicket.isEmpty()) ? null : lstServiceTicket[0]);
    }
}