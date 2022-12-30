public without sharing class TicketHistoryController {
    private static final String WEBSERVICE_NAME = 'FourthPlataformTicketServiceCallout';

    @AuraEnabled
    public static Boolean validateUserIdInformation(Id accountId){
        Account accountObj = AccountDAO.getByIds(accountId);
        return (accountObj != null && accountObj.UserId__c != null);
    }
    
    @AuraEnabled
    public static Boolean getTicketHistory(Id accountId){
        List<Ticket__c> lstTicketHistory = new List<Ticket__c>();
        lstTicketHistory = TicketDAO.getByAccountId(accountId);
        return lstTicketHistory.isEmpty() ? true : false;       
    }

    @AuraEnabled
    public static String createTicketHistory(Id accountId){
        Webservice__c wsConfig = Webservice__c.getInstance(WEBSERVICE_NAME);

        if (wsConfig == null || !wsConfig.switchedOn__c) {
            return 'CustomerPlataformaDigitalCallout: Webservice not found.';
        }

        List<Ticket__c> lstTicketHistory = new List<Ticket__c>();
        List<GeneralParam__c> lstGeneralParams = new List<GeneralParam__c>();
        lstGeneralParams = GeneralParamDAO.getLoadParams();
        
        Integer searchRange = Integer.valueOf(lstGeneralParams[0].SearchRange__c) *-1;
        Integer totalNumberRecords = Integer.valueOf(lstGeneralParams[0].TotalNumberRecords__c);
 
        DateTime startDate = System.now().addDays(searchRange);
        DateTime endDate = System.now();
        Account accountObj = AccountDAO.getByIds(accountId);

        String parameters = accountObj.UserId__c + '/ticket?type=issue&start_date=' +startDate.format('yyyy-MM-dd\'T\'HH:mm:ss\'Z\'') + '&end_date=' + endDate.format('yyyy-MM-dd\'T\'HH:mm:ss\'Z\'') +'&number_tickets=' +50;
        String endpoint = wsConfig.Endpoint__c + parameters;
        
        List<TicketServiceReturn.TicketResponse> lstTicketReturn = new List<TicketServiceReturn.TicketResponse>();

        HttpClient client = new HttpClient();
        HttpResponse response = client.get(wsConfig, endpoint);
        ServiceResponse serviceResponse = new ServiceResponse();

        if (response.getStatusCode()/100 == 2) {
            String result = response.getBody();
            serviceResponse.body = result;
            serviceResponse.success = true;
        } else {
            serviceResponse.success = false;
        }
        
        if (serviceResponse.success) {
            lstTicketReturn = (List<TicketServiceReturn.TicketResponse>)Json.deserialize(serviceResponse.body, List<TicketServiceReturn.TicketResponse>.class);
        }
                
        if(!lstTicketReturn.isEmpty()){
            for(TicketServiceReturn.TicketResponse ticketResponse : lstTicketReturn){

                Ticket__c ticketObj = new Ticket__c();
                
                ticketObj.AccountId__c = accountId;
                ticketObj.TicketId__c = ticketResponse.ticket_id;                
                if(!String.isBlank(ticketResponse.start_date)){
                ticketObj.OpeningDate__c = Date.valueOf(ticketResponse.start_date);
                }
                
                if(!String.isBlank(ticketResponse.end_date)){
                    ticketObj.SolutionDate__c = Date.valueOf(ticketResponse.end_date);
                }
     
                ticketObj.Status__c = ticketResponse.status;
                ticketObj.Reason__c = ticketResponse.reason;

                lstTicketHistory.add(ticketObj);
            }
        }

        upsert lstTicketHistory TicketId__c;
        return 'sucesso'; //String.valueOf(serviceResponse.success);
    }
}