public with sharing class TicketPrevisionDateService {
    
    public static String getTicketPrevisionDate(Id ticketId) {
        return TicketPrevisionDateEngine.getTicketPrevisionDate(ticketId);
    }
}