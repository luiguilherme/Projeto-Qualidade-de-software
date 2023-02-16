/*
    ---------------------------------------------------
    @author - Márcio Las
    @company - Telefonica  
    @date - 28/03/2022
    @description - Class Service for SSMTickets
    ---------------------------------------------------
*/
public with sharing class SSMTicketsService {
    public static Map<String, Object> getPointOfServiceTitckets() {
        return (SSMTicketsEngine.getPointOfServiceTitckets());
    }
}
