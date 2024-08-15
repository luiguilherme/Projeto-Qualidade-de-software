public class CustomerInteractionFacade {

	public static string CONST_STRING_WEBSERVICENAME = 'CustomerInteractionCallout';

	public static CustomerInteractionResponse findCustomerInteractions(String idCustomer, Date startOpeningDate, Date endOpeningDate){
		String urlSufixGet = '?sourceSystemName=AMDOCS&searchType=0&idCustomer={0}&startOpeningDate={1}&endOpeningDate={2}';
		DateTime startDateTime = DateTime.newInstance(startOpeningDate.year(), startOpeningDate.month(), startOpeningDate.day());
		DateTime endDateTime = DateTime.newInstance(endOpeningDate.year(), endOpeningDate.month(), endOpeningDate.day());
		String handledStartOpeningDate = startDateTime.format('yyyy-MM-dd');
		String handledEndOpeningDate = endDateTime.format('yyyy-MM-dd') ;
        
		WebService__c ws = WebService__c.getInstance(CONST_STRING_WEBSERVICENAME);
		ws.Endpoint__c = ws.Endpoint__c +String.format(urlSufixGet, new List<String>{idCustomer,handledStartOpeningDate,handledEndOpeningDate});
		system.debug(ws.Endpoint__c);
		//ws.Endpoint__c='https://contest.proxy.beeceptor.com/dip/customerInteraction/partyInteraction/v1/protocol/history?sourceSystemName=AMDOCS&searchType=0&idCustomer=24071919120420754&startOpeningDate=2024-06-01&endOpeningDate=2024-07-31';
		HttpClient hClient = new HttpClient();
        HttpResponse response = hClient.get(ws);
		CustomerInteractionResponse result = (CustomerInteractionResponse)JSON.deserialize(response.getBody(), CustomerInteractionResponse.class);
		
		return result;
	}

}