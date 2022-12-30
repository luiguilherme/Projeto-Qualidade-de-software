public with sharing class TicketPrevisionDateController {
   
    @AuraEnabled
    public static String getTicketPrevisionDate(Id ticketId) {
        return TicketPrevisionDateService.getTicketPrevisionDate(ticketId);
    }
}