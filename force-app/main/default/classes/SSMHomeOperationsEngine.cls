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
    private static final String CUSTOM_SETTING_NAME = 'SSMUseServiceTicketObject';

    public static Map<String, Object> startAttendance(StoreServiceManagerTO.ServiceTicket serviceTicket) {
        Map<String, Object> mapResponse = new Map<String, Object>();

        try {
            mapResponse = PointOfServiceAttendanceCallout.execute(serviceTicket);

            if (mapResponse.get('success') != null) {
                User attendant = UserDAO.getById(UserInfo.getUserId());

                serviceTicket.status = ServiceTicketDAO.GSS_STATUS_IN_SERVICE;
                serviceTicket.userLogin = attendant.Login__c;
                serviceTicket.startTime = (DateTime.now()).formatGmt('YYYY-MM-dd HH:mm:ss');
                serviceTicket.waitTime = StoreServiceManagerService.calculateElapsedTime(serviceTicket.createdDateTime, serviceTicket.startTime);

                if(FeatureFlagEngine.applicationIsActive(CUSTOM_SETTING_NAME)){
                    updateServiceTicket(serviceTicket);
                }

                mapResponse.clear();

                mapResponse.put('success', serviceTicket);
            }

        } catch (Exception e) {
            mapResponse.clear();

            mapResponse.put('error', GENERIC_ERROR_MESSAGE);
        }

        return (mapResponse);
    }

    private static void updateServiceTicket(StoreServiceManagerTO.ServiceTicket serviceTicket) {
        ServiceTicket__c ticket = new ServiceTicket__c(
            Id = serviceTicket.Id, 
            Status__c = serviceTicket.status, 
            Login__c = serviceTicket.userLogin, 
            ServiceStart__c = DateTime.valueOfGmt(serviceTicket.startTime), 
            WaitTime__c = serviceTicket.waitTime
        );

        update ticket;
    }
}
