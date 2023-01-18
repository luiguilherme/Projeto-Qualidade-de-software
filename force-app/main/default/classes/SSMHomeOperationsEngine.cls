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

    public static Map<String, Object> getTimeAutomaticTicketCallParam() {
        Map<String, Object> mapResponse = new Map<String, Object>();

        try {
            List<GeneralParam__c> ltParam = GeneralParamDAO.getLoadParams();

            if (!ltParam.isEmpty()) {
                mapResponse.put('success', ltParam[0].TimeAutomaticTicketCall__c);

            } else {
                mapResponse.put('success', 10);
            }

        } catch (Exception e) {
            mapResponse.clear();
    
            mapResponse.put('error', GENERIC_ERROR_MESSAGE);
        }
    
        return (mapResponse);
    }

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