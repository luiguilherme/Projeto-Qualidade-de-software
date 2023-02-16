/*
    ---------------------------------------------------
    @author - Márcio Las
    @company - Telefonica  
    @date - 08/04/2022
    @description - Class Service for SSMAttendanceOperations
    ---------------------------------------------------
*/
public with sharing class SSMAttendanceOperationsService {
    public static Map<String, Object> recallTicket(StoreServiceManagerTO.ServiceTicket serviceTicket) {
        return (SSMAttendanceOperationsEngine.recallTicket(serviceTicket));
    }
    
    public static Map<String, Object> returnToHome(StoreServiceManagerTO.ServiceTicket serviceTicket) {
        return (SSMAttendanceOperationsEngine.returnToHome(serviceTicket));
    }

    public static Map<String, Object> giveUp(StoreServiceManagerTO.ServiceTicket serviceTicket) {
        return (SSMAttendanceOperationsEngine.giveUp(serviceTicket));
    }

    public static Map<String, Object> confirmService(StoreServiceManagerTO.ServiceTicket serviceTicket) {
        return (SSMAttendanceOperationsEngine.confirmService(serviceTicket));
    }
}
