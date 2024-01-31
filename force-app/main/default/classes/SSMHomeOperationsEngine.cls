/*
    ---------------------------------------------------
    @author - Márcio Las
    @company - Telefonica  
    @date - 07/04/2022
    @description - Class Engine for SSMHomeOperations
    ---------------------------------------------------
*/
public with sharing class SSMHomeOperationsEngine {
    private static final Integer GENERIC_ERROR_MESSAGE = 699;

    public static Map<String, Object> startAttendance(StoreServiceManagerTO.ServiceTicket serviceTicket) {
        Map<String, Object> mapResponse = new Map<String, Object>();

        try {
            mapResponse = PointOfServiceAttendanceCallout.execute(serviceTicket);
        
        } catch (Exception e) {
            mapResponse.clear();

            mapResponse.put('error', GENERIC_ERROR_MESSAGE);
        }

        return (mapResponse);
    }
}
