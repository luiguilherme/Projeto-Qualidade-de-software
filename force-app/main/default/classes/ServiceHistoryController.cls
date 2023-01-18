public class ServiceHistoryController {
    private static final String WEBSERVICE_NAME = 'FourthPlataformServiceHistoryCallout';

    @AuraEnabled
    public static Boolean getServiceHistory(Id accountId){
        List<ServiceHistory__c> lstServiceHistory = new List<ServiceHistory__c>();
        lstServiceHistory = ServiceHistoryDAO.getByAccountId(accountId);
		        
        if(lstServiceHistory.isEmpty()){
            return false;
        } else {
            return true;
        }
    }

    @AuraEnabled
    public static String createServiceHistory(Id accountId){
        Webservice__c wsConfig = Webservice__c.getInstance(WEBSERVICE_NAME);

        if (wsConfig == null) {
            return 'CustomerPlataformaDigitalCallout: Webservice not found.';
        }

        List<ServiceHistory__c> lstServiceHistory = new List<ServiceHistory__c>();
        List<GeneralParam__c> lstGeneralParams = new List<GeneralParam__c>();
        lstGeneralParams = GeneralParamDAO.getLoadParams();
        
        Integer searchRange = Integer.valueOf(lstGeneralParams[0].SearchRange__c) *-1;
        Integer totalNumberRecords = Integer.valueOf(lstGeneralParams[0].TotalNumberRecords__c);

        Account acc = [SELECT ID, DocumentNumber__c FROM Account WHERE ID =: accountId];		
        DateTime startDate = System.now().addDays(searchRange);
        DateTime endDate = System.now();
        
        String parameters = 'CPF' + acc.DocumentNumber__c + '?start_date=' + startDate.format('yyyy-MM-dd\'T\'HH:mm:ss\'Z\'') + '&end_date=' + endDate.format('yyyy-MM-dd\'T\'HH:mm:ss\'Z\'') + '&number_interaction=' + totalNumberRecords;
        String endpoint = wsConfig.Endpoint__c + parameters;
        
        List<ServiceReturn> lstServiceReturn = new List<ServiceReturn>();

        // ICredentialsProvider provider = new OAuthServiceAccountProvider('callout:oam', null);
        // ICredentialsProvider provider = new OAuthProvider('callout:oam', null);
        HttpClient client = new HttpClient();
        HttpResponse response = client.get(wsConfig, endpoint);
        ServiceResponse serviceResponse = new ServiceResponse();
        
        System.debug('## response = ' + response.getBody());

        if (response.getStatusCode()/100 == 2) {
			String result = response.getBody();
           	serviceResponse.body = result;
            serviceResponse.success = true;
        } else {
			serviceResponse.success = false;
        }
        
        if (serviceResponse.success) {
            lstServiceReturn = (List<ServiceReturn>)Json.deserialize(serviceResponse.body, List<ServiceReturn>.class);
        }        
        
        if(!lstServiceReturn.isEmpty()){
			for(ServiceReturn result : lstServiceReturn){

                String SstartDate;
                String SendDate;

				ServiceHistory__c serviceHistory = new ServiceHistory__c();
				serviceHistory.Name = result.protocol_Id;
				serviceHistory.Channel__c = result.channel.channel_master;
				serviceHistory.Account__c = accountId;
				serviceHistory.ContactReason__c = result.reason;
				serviceHistory.LegacyCaseNumber__c = result.protocol_Id;

				if(result.interaction_date.start_date != null && result.interaction_date.start_date.contains('T')){
	                SstartDate = result.interaction_date.start_date.replaceAll('T',' ');
					serviceHistory.StartDate__c = DateTime.valueOf(SstartDate);
                }
         
                if(result.interaction_date.end_date != null && result.interaction_date.end_date.contains('T')){
                	SendDate = result.interaction_date.end_date.replaceAll('T',' ');
					serviceHistory.EndDate__c = DateTime.valueOf(SendDate);
                }
                lstServiceHistory.add(serviceHistory);
        	}  
		}
        
        insert lstServiceHistory;
        return String.valueOf(serviceResponse.success);
        //return 'true';
    }

}