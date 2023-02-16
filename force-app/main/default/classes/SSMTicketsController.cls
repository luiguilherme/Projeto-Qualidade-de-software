/*
    ---------------------------------------------------
    @author - Márcio Las
    @company - Telefonica  
    @date - 28/03/2022
    @description - Class Controller for SSMTickets
    ---------------------------------------------------
*/
public with sharing class SSMTicketsController {
    @AuraEnabled
    public static Map<String, Object> getPointOfServiceTitckets() {
        return (SSMTicketsService.getPointOfServiceTitckets());
    }
}
