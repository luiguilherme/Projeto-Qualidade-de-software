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
            mapResponse = PointOfServiceAttendanceCallout.execute(serviceTicket, 'Recall');

        } catch (Exception e) {
            mapResponse.clear();

            mapResponse.put('error', GENERIC_ERROR_MESSAGE);
        }

        return (mapResponse);
    }

    public static Map<String, Object> returnToHome(StoreServiceManagerTO.ServiceTicket serviceTicket) {
        Map<String, Object> mapResponse = new Map<String, Object>();

        try {
            mapResponse = PointOfServiceAttendanceCallout.execute(serviceTicket, 'Return');

        } catch (Exception e) {
            mapResponse.clear();

            mapResponse.put('error', GENERIC_ERROR_MESSAGE);
        }

        return (mapResponse);
    }

    public static Map<String, Object> giveUp(StoreServiceManagerTO.ServiceTicket serviceTicket) {
        Map<String, Object> mapResponse = new Map<String, Object>();
        
        try {
            mapResponse = PointOfServiceAttendanceCallout.execute(serviceTicket, 'Canceled');

            if (mapResponse.get('success') != null && !String.isBlank(serviceTicket.customerId)) {
                Map<String, Object> mapCase = createAttendanceCase(serviceTicket);
        
                if (mapCase.get('success') != null) {
                    mapResponse.clear();

                    mapResponse.put('success', mapCase.get('success'));
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
            mapResponse = PointOfServiceAttendanceCallout.execute(serviceTicket, 'Closed');

            if (mapResponse.get('success') != null && !String.isBlank(serviceTicket.customerId)) {
                Map<String, Object> mapCase = createAttendanceCase(serviceTicket);

                if (mapCase.get('success') != null) {
                    mapResponse.clear();

                    mapResponse.put('success', mapCase.get('success'));
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
}
