public with sharing class TicketPrevisionDateEngine {
    
    public static String getTicketPrevisionDate(Id ticketId) {

        String WEBSERVICE_NAME = 'WFMSearchByWorkOrderCallout';
        Webservice__c wsConfig = Webservice__c.getInstance(WEBSERVICE_NAME);
 
        if (wsConfig == null || !wsConfig.switchedOn__c) {
            return '';
        }

        Ticket__c ticketObj = TicketDAO.getTicketById(ticketId);
        
        if(ticketObj == null || ticketObj.Status__c != 'OPEN'){
            return '';
        }

        TicketServicePrevisionReturn.workOrder workOrder;
        TicketServicePrevisionReturn.WorkRequiresAppointment workRequire;
        TicketServicePrevisionReturn.AppointmentIsAssociatedWithCalendarEntry appointment;
        TicketServicePrevisionReturn.TimePeriod timePeriod;
        TicketServicePrevisionReturn responseService;
        String convertedString;
        Date convertedDate;
        Date dateToSet;

        HttpClient client = new HttpClient();
        HttpResponse response = client.post(wsConfig, '{"workOrder": {"id": "'+ ticketObj.TicketId__c +'"}}' );

        if (response.getStatusCode()/100 == 2) {
            responseService = (TicketServicePrevisionReturn) JSON.deserialize(response.getBody(),TicketServicePrevisionReturn.class);
        }
        else if(response.getStatusCode() == 404){
            return '404';
        }
        else if(response.getStatusCode() == 500){
            return '500';
        }
        
        if(responseService == null){
            return '500';
        }
        
        workOrder = responseService.workOrder;
        for(TicketServicePrevisionReturn.WorkOrderComprisedOf itemWO : workOrder.WorkOrderComprisedOf){
                
            for(TicketServicePrevisionReturn.WorkOrderItemInvolvesWork itemWI : itemWO.WorkOrderItemInvolvesWork){
                
                if((itemWI.status =='Agendado') || (itemWI.status=='Iniciado')){
                    workRequire = itemWI.WorkRequiresAppointment;
                    appointment = workRequire.AppointmentIsAssociatedWithCalendarEntry;
                    timePeriod = appointment.timePeriod;
                    if(timePeriod.endDateTime != ''){
                        convertedString = timePeriod.endDateTime.substring(0, timePeriod.endDateTime.indexOf('T'));
                        convertedDate = Date.valueOf(convertedString);
                    }
                    if(dateToSet == null || dateToSet < convertedDate ){
                        dateToSet = convertedDate;    
                    }
                }
            }
        }

        ticketObj.PrevisionDate__c = dateToSet;
        update ticketObj;
        return '200';
    }
}