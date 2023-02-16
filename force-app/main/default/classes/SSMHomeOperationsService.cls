/*
    ---------------------------------------------------
    @author - Márcio Las
    @company - Telefonica  
    @date - 07/04/2022
    @description - Class Service for SSMHomeOperations
    ---------------------------------------------------
*/
public with sharing class SSMHomeOperationsService {
    public static Map<String, Object> startAttendance(StoreServiceManagerTO.ServiceTicket serviceTicket) {
        return (SSMHomeOperationsEngine.startAttendance(serviceTicket));
    }
}
