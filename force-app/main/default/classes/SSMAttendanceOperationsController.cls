/*
    ---------------------------------------------------
    @author - Márcio Las
    @company - Telefonica  
    @date - 08/04/2022
    @description - Class Controller for SSMAttendanceOperations
    ---------------------------------------------------
*/
public with sharing class SSMAttendanceOperationsController {
    @AuraEnabled
    public static Map<String, Object> getGiveUpReasonsList() {
        return (SSMAttendanceOperationsService.getGiveUpReasonsList());
    }

    @AuraEnabled
    public static Map<String, Object> recallTicket(StoreServiceManagerTO.ServiceTicket serviceTicket) {
        return (SSMAttendanceOperationsService.recallTicket(serviceTicket));
    }

    @AuraEnabled
    public static Map<String, Object> returnToHome(StoreServiceManagerTO.ServiceTicket serviceTicket) {
        return (SSMAttendanceOperationsService.returnToHome(serviceTicket));
    }

    @AuraEnabled
    public static Map<String, Object> giveUp(StoreServiceManagerTO.ServiceTicket serviceTicket) {
        return (SSMAttendanceOperationsService.giveUp(serviceTicket));
    }

    @AuraEnabled
    public static Map<String, Object> confirmService(StoreServiceManagerTO.ServiceTicket serviceTicket) {
        return (SSMAttendanceOperationsService.confirmService(serviceTicket));
    }
}