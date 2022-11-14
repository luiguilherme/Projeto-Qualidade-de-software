public class TicketDAO {
	public static final String WEBSERVICE_NAME = 'FourthPlataformTicketServiceCallout';    
    
    public static List<Ticket__c> getByAccountId(Id accountId){
        
        WebService__c wsConfig = Webservice__c.getInstance(WEBSERVICE_NAME);
        
		integer refreshTime = Integer.valueOf(wsConfig.Validate__c) *-1;
        Datetime searchTicketDate = system.now().addSeconds(refreshTime);
        
        return [
            SELECT    
                Id 
            FROM 
                Ticket__c
            WHERE
            	AccountId__c =: accountId
            
            AND
             	LastModifiedDate >: searchTicketDate
        ];
    }
    
    public static Ticket__c getTicketById(Id ticketId){
        List<Ticket__c> ltTicket = getTicketByIds(new Set<Id>{ticketId});
        return ltTicket.IsEmpty() ? null : ltTicket[0];
    }
    
    public static List<Ticket__c> getTicketByIds(Set<Id> setTicketId){
        return [
            SELECT
            	TicketId__c,
            	Status__c
            FROM
            	Ticket__c
            WHERE
            	Id IN :setTicketId
            AND
            	TicketId__c != null
        ];
        
    }
}