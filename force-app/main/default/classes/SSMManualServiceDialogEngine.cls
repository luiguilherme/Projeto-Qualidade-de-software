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
                String jsonTicket = (String) mapResponseCallout.get('success');

                StoreServiceManagerResponse.Ticket generatedTicket = (StoreServiceManagerResponse.Ticket) 
                    JSON.deserialize(jsonTicket, StoreServiceManagerResponse.Ticket.class);

                StoreServiceManagerTO.ServiceTicket serviceTicket = new StoreServiceManagerTO.ServiceTicket();

                serviceTicket.type = MANUAL_ATTENDANCE;
                serviceTicket.workPositionId = workPositionId;
                serviceTicket.displayAlert = displayAlert;
                serviceTicket.ticketId = generatedTicket.id;
                serviceTicket.customerSpecialNeeds = false;
                serviceTicket.customerPriority = 2;
                serviceTicket.customerId = '';
                serviceTicket.customerName = '';
                serviceTicket.customerAlias = '';
                serviceTicket.customerCellPhone = cellPhone;
                serviceTicket.customerDocument = '';
                serviceTicket.segmentation = '';
                serviceTicket.segmentationName = '';
                serviceTicket.activity = '';
                serviceTicket.protocol = '';
                serviceTicket.waitTime = calculateElapsedTime(scheduleTime);
                serviceTicket.startTime = (DateTime.now()).format();
                serviceTicket.finalTime = '';
                serviceTicket.duration = '';
                serviceTicket.service = '';
                serviceTicket.serviceName = '';
                serviceTicket.category = '';
                serviceTicket.categoryName = '';
                serviceTicket.mainDocumentType = '';
                serviceTicket.documentNumber = '';
                serviceTicket.giveUpReason = '';
                serviceTicket.activities = '';
                serviceTicket.notes = '';

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

    private static String calculateElapsedTime(String scheduleTime) {
        String[] arrScheduleTime = scheduleTime.split(':');
            
        DateTime currentTime = DateTime.now();

        DateTime informedTime = DateTime.newInstance(
            currentTime.year(), 
            currentTime.month(), 
            currentTime.day(), 
            Integer.valueOf(arrScheduleTime[0]), 
            Integer.valueOf(arrScheduleTime[1]), 
            0
        );

        Long milliseconds = (currentTime.getTime() - informedTime.getTime());
        Long seconds = (milliseconds / 1000);
        Long minutes = (seconds / 60);
        Long hours = (minutes / 60);

        return (
            String.valueOf(hours).leftPad(2, '0') + ':' +
            String.valueOf(minutes).leftPad(2, '0') + ':' +
            String.valueOf(0).leftPad(2, '0')
        );
    }
}