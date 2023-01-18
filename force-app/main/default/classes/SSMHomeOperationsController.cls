/*
    ---------------------------------------------------
    @author - Márcio Las
    @company - Telefonica  
    @date - 07/04/2022
    @description - Class Controller for SSMHomeOperations
    ---------------------------------------------------
*/
public with sharing class SSMHomeOperationsController {
    @AuraEnabled
    public static Map<String, Object> getTimeAutomaticTicketCallParam() {
        return (SSMHomeOperationsService.getTimeAutomaticTicketCallParam());
    }

    @AuraEnabled
    public static Map<String, Object> startAttendance(StoreServiceManagerTO.ServiceTicket serviceTicket) {
        return (SSMHomeOperationsService.startAttendance(serviceTicket));
    }
}