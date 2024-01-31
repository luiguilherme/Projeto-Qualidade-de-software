/*
    ---------------------------------------------------
    @author - Márcio Las
    @company - Telefonica  
    @date - 08/04/2022
    @description - Class Engine for SSMAttendanceOperations
    ---------------------------------------------------
*/
public with sharing class SSMAttendanceOperationsEngine {
    private static final Integer GENERIC_ERROR_MESSAGE = 699;

    public static Map<String, Object> recallTicket(StoreServiceManagerTO.ServiceTicket serviceTicket) {
        Map<String, Object> mapResponse = new Map<String, Object>();

        try {
            serviceTicket.startTime = (DateTime.now()).formatGmt('YYYY-MM-dd HH:mm:ss');
            serviceTicket.waitTime = StoreServiceManagerService.calculateElapsedTime(serviceTicket.createdDateTime, serviceTicket.startTime);

            mapResponse = PointOfServiceAttendanceCallout.execute(serviceTicket, 'Recall');

            if (mapResponse.get('success') != null) {
                updateServiceTicket(serviceTicket);

                mapResponse.clear();
                
                mapResponse.put('success', serviceTicket.startTime);
            }

        } catch (Exception e) {
            mapResponse.clear();

            mapResponse.put('error', GENERIC_ERROR_MESSAGE);
        }

        return (mapResponse);
    }

    public static Map<String, Object> returnToHome(StoreServiceManagerTO.ServiceTicket serviceTicket) {
        Map<String, Object> mapResponse = new Map<String, Object>();

        try {
            serviceTicket.status = ServiceTicketDAO.GSS_STATUS_ON_HOLD;
            serviceTicket.userLogin = '';
            serviceTicket.startTime = '';
            serviceTicket.category = '';
            serviceTicket.categoryName = '';
            serviceTicket.mainDocumentType = '';
            serviceTicket.mainDocumentTypeName = '';
            serviceTicket.documentNumber = '';
            serviceTicket.giveUpReason = '';
            serviceTicket.activities = '';
            serviceTicket.notes = '';

            mapResponse = PointOfServiceAttendanceCallout.execute(serviceTicket, 'Return');

            if (mapResponse.get('success') != null) {
                updateServiceTicket(serviceTicket);
            }

        } catch (Exception e) {
            mapResponse.clear();

            mapResponse.put('error', GENERIC_ERROR_MESSAGE);
        }

        return (mapResponse);
    }

    public static Map<String, Object> giveUp(StoreServiceManagerTO.ServiceTicket serviceTicket) {
        Map<String, Object> mapResponse = new Map<String, Object>();
        
        try {
            serviceTicket.status = ServiceTicketDAO.GSS_STATUS_CANCELED;
            serviceTicket.category = '';
            serviceTicket.categoryName = '';
            serviceTicket.mainDocumentType = '';
            serviceTicket.mainDocumentTypeName = '';
            serviceTicket.documentNumber = '';
            serviceTicket.activities = serviceTicket.giveUpReason;
            serviceTicket.notes = '';
            
            mapResponse = PointOfServiceAttendanceCallout.execute(serviceTicket, 'Canceled');

            if (mapResponse.get('success') != null) {
                updateServiceTicket(serviceTicket);
            
                if (!String.isBlank(serviceTicket.customerId)) {
                    Map<String, Object> mapCase = createAttendanceCase(serviceTicket);
            
                    if (mapCase.get('success') != null) {
                        mapResponse.clear();

                        mapResponse.put('success', mapCase.get('success'));
                    }
                }
            }

        } catch (Exception e) {
            mapResponse.clear();

            mapResponse.put('error', GENERIC_ERROR_MESSAGE);
        }

        return (mapResponse);
    }

    public static Map<String, Object> confirmService(StoreServiceManagerTO.ServiceTicket serviceTicket) {
        Map<String, Object> mapResponse = new Map<String, Object>();

        try {
            String customerCellPhone = serviceTicket.customerCellPhone.replaceAll('[a-zA-Z .]{1,}|\\-', '');

            serviceTicket.geographicAreaCode = customerCellPhone.substring(0, 2);
            serviceTicket.networkNumber = customerCellPhone.substring(2);
            serviceTicket.status = ServiceTicketDAO.GSS_STATUS_CLOSED;
            serviceTicket.finalTime = (DateTime.now()).formatGmt('YYYY-MM-dd HH:mm:ss');
            serviceTicket.duration = StoreServiceManagerService.calculateElapsedTime(serviceTicket.startTime, serviceTicket.finalTime);

            mapResponse = PointOfServiceAttendanceCallout.execute(serviceTicket, 'Closed');

            if (mapResponse.get('success') != null) {
                updateServiceTicket(serviceTicket);

                if (!String.isBlank(serviceTicket.customerId)) {
                    Map<String, Object> mapCase = createAttendanceCase(serviceTicket);

                    if (mapCase.get('success') != null) {
                        mapResponse.clear();

                        mapResponse.put('success', mapCase.get('success'));
                    }
                }
            }
            
        } catch (Exception e) {
            mapResponse.clear();
            
            mapResponse.put('error', GENERIC_ERROR_MESSAGE);
        }

        return (mapResponse);
    }

    private static Map<String, Object> createAttendanceCase(StoreServiceManagerTO.ServiceTicket serviceTicket) {
        Map<String, Object> mapResponse = new Map<String, Object>();
        
        String description = '';

        if (!String.isBlank(serviceTicket.giveUpReason)) {
            StoreServiceManagerTO.ItemPicklistValue giveUpReason = (StoreServiceManagerTO.ItemPicklistValue)
                JSON.deserialize(serviceTicket.giveUpReason, StoreServiceManagerTO.ItemPicklistValue.class);

            description = giveUpReason.label;

        } else {
            List<StoreServiceManagerTO.ItemPicklistValue> ltActivities = (List<StoreServiceManagerTO.ItemPicklistValue>)
                JSON.deserialize(serviceTicket.activities, List<StoreServiceManagerTO.ItemPicklistValue>.class);

            for (StoreServiceManagerTO.ItemPicklistValue activity : ltActivities) {
                description += (((String.isBlank(description)) ? '' : ', ') + activity.label);
            }
        }

        try {
            vlocity_cmt__CustomerInteractionTopic__c ssmvlCIT = new vlocity_cmt__CustomerInteractionTopic__c();
            
            ssmvlCIT.vlocity_cmt__CustomerInteractionId__c = serviceTicket.customerInteractionId;
            ssmvlCIT.vlocity_cmt__Reason__c = 'Atendimento - GSS';
            ssmvlCIT.Origin__c = 'GSS';            
            ssmvlCIT.TopicName__c = description;
            ssmvlCIT.remarkup__c = serviceTicket.notes;
            ssmvlCIT.vlocity_cmt__AccountId__c = serviceTicket.customerId;
            
            insert ssmvlCIT;
            
            mapResponse.put('success', ssmvlCIT.Id);
                        
            if (ssmvlCIT.Id != null) {
                vlocity_cmt__CustomerInteraction__c ssmvlCI = new vlocity_cmt__CustomerInteraction__c();

                ssmvlCI.Id = serviceTicket.customerInteractionId;
                ssmvlCI.InteractionNumber__c = serviceTicket.protocol;
                ssmvlCI.CallerPhone__c = serviceTicket.customerCellPhone;

                update ssmvlCI;

                mapResponse.put('success', ssmvlCI.Id);
            }            

        } catch (Exception e) {
            mapResponse.put('error', GENERIC_ERROR_MESSAGE);
        }

        return (mapResponse);
    }

    private static void updateServiceTicket(StoreServiceManagerTO.ServiceTicket serviceTicket) {
        ServiceTicket__c ticket = new ServiceTicket__c(
            Id = serviceTicket.Id, 
            CustomerName__c = serviceTicket.customerName, 
            Alias__c = serviceTicket.customerAlias, 
            GeographicAreaCode__c = serviceTicket.geographicAreaCode, 
            NetworkNumber__c = serviceTicket.networkNumber, 
            Status__c = serviceTicket.status, 
            Login__c = serviceTicket.userLogin, 
            WaitTime__c = serviceTicket.waitTime, 
            ServiceStart__c = (String.isBlank(serviceTicket.startTime) ? null : DateTime.valueOfGmt(serviceTicket.startTime)), 
            ServiceEnd__c = (String.isBlank(serviceTicket.finalTime) ? null : DateTime.valueOfGmt(serviceTicket.finalTime)), 
            Duration__c = serviceTicket.duration, 
            BusinessLineID__c = serviceTicket.category, 
            BusinessLineName__c = serviceTicket.categoryName, 
            MainDocumentTypeID__c = serviceTicket.mainDocumentType, 
            MainDocumentTypeName__c = serviceTicket.mainDocumentTypeName, 
            DocumentNumber__c = serviceTicket.documentNumber, 
            Activities__c = serviceTicket.activities, 
            Notes__c = serviceTicket.notes
        );

        update ticket;
    }
}
