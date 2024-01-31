/*
    ---------------------------------------------------
    @author - Márcio Las
    @company - Telefonica  
    @date - 14/04/2022
    @description - Class Engine for SSMManualServiceDialog
    ---------------------------------------------------
*/
public with sharing class SSMManualServiceDialogEngine {
    private static final String MANUAL_ATTENDANCE = 'MANUAL';

    private static final Integer GENERIC_ERROR_MESSAGE = 699;

    public static Map<String, Object> generateTicket(String workPositionId, Boolean displayAlert, String scheduleTime, String cellPhone) {
        Map<String, Object> mapResponse = new Map<String, Object>();

        try {
            String cellPhoneNumbers = cellPhone.replaceAll('[a-zA-Z .]{1,}|\\-', '');

            Map<String, Object> mapResponseCallout = PointOfServiceTicketsCallout.execute(scheduleTime, cellPhoneNumbers);

            if (mapResponseCallout.get('success') != null) {
                User attendant = UserDAO.getById(UserInfo.getUserId());

                String jsonTicket = (String) mapResponseCallout.get('success');

                StoreServiceManagerResponse.Ticket generatedTicket = (StoreServiceManagerResponse.Ticket) 
                    JSON.deserialize(jsonTicket, StoreServiceManagerResponse.Ticket.class);

                String geographicAreaCode = cellPhoneNumbers.substring(0, 2);
                String networkNumber = cellPhoneNumbers.substring(2);
                String createdDateTime = (DateTime.now()).formatGmt('YYYY-MM-dd HH:mm:ss');
                String externalId = createdDateTime.replaceAll('[- :]', '');

                StoreServiceManagerTO.ServiceTicket serviceTicket = new StoreServiceManagerTO.ServiceTicket();

                serviceTicket.createdDateTime = createdDateTime;
                serviceTicket.type = MANUAL_ATTENDANCE;
                serviceTicket.view = '';
                serviceTicket.store = attendant.StoreCode__c;
                serviceTicket.workPositionId = workPositionId;
                serviceTicket.displayAlert = displayAlert;
                serviceTicket.ticketId = generatedTicket.id;
                serviceTicket.externalId = ('SF' + serviceTicket.type + generatedTicket.id + externalId);
                serviceTicket.customerSpecialNeeds = false;
                serviceTicket.customerPriority = 2;
                serviceTicket.customerInteractionId = '';
                serviceTicket.customerId = '';
                serviceTicket.customerName = '';
                serviceTicket.customerAlias = '';
                serviceTicket.customerDocument = '';
                serviceTicket.geographicAreaCode = geographicAreaCode;
                serviceTicket.networkNumber = networkNumber;
                serviceTicket.customerCellPhone = cellPhone;
                serviceTicket.segmentation = '';
                serviceTicket.segmentationName = '';
                serviceTicket.activity = '';
                serviceTicket.protocol = '';
                serviceTicket.waitTime = '00:00:00';
                serviceTicket.status = ServiceTicketDAO.GSS_STATUS_IN_SERVICE;
                serviceTicket.userLogin = attendant.Login__c;
                serviceTicket.startTime = createdDateTime;
                serviceTicket.finalTime = '';
                serviceTicket.duration = '';
                serviceTicket.service = '';
                serviceTicket.serviceName = '';
                serviceTicket.activityPriority = 1;
                serviceTicket.category = '';
                serviceTicket.categoryName = '';
                serviceTicket.mainDocumentType = '';
                serviceTicket.mainDocumentTypeName = '';
                serviceTicket.documentNumber = '';
                serviceTicket.giveUpReason = '';
                serviceTicket.activities = '';
                serviceTicket.notes = '';

                Id newTicketId = registerServiceTicket(serviceTicket);

                serviceTicket.Id = newTicketId;

                mapResponse.put('success', serviceTicket);

            } else {
                mapResponse.put('error', mapResponseCallout.get('error'));
            }

        } catch (Exception e) {
            mapResponse.clear();
    
            mapResponse.put('error', GENERIC_ERROR_MESSAGE);
        }

        return (mapResponse);
    }

    private static Id registerServiceTicket(StoreServiceManagerTO.ServiceTicket serviceTicket) {
        ServiceTicket__c ticket = new ServiceTicket__c(
            RecordTypeId = ServiceTicketDAO.GSS_RECORD_TYPE_ID, 
            Store__c = serviceTicket.store, 
            TicketId__c = serviceTicket.ticketId, 
            ExternalID__c = serviceTicket.externalId, 
            SpecialNeeds__c = serviceTicket.customerSpecialNeeds, 
            Priority__c = serviceTicket.customerPriority, 
            GeographicAreaCode__c = serviceTicket.geographicAreaCode, 
            NetworkNumber__c = serviceTicket.networkNumber, 
            Status__c = serviceTicket.status, 
            Login__c = serviceTicket.userLogin, 
            ServiceStart__c = DateTime.valueOfGmt(serviceTicket.startTime), 
            WaitTime__c = serviceTicket.waitTime, 
            ActivityPriority__c = serviceTicket.activityPriority
        );

        insert ticket;

        return (ticket.Id);
    }
}
