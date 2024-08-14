public with sharing class CustomerBillInvoceManagementFacade {
    public static string CONST_STRING_WEBSERVICENAME = 'SearchInvoceCreditsCallout';

    public static InvoceCreditsResponse	 findCreditsByFinancialAccountIdAndPeriod(String financialAccountId, DateTime startDate, DateTime endDate){
		startDate.format('');
        System.debug('StartDate'+startDate);
        System.debug('EndDate'+endDate);
        String strStartDate = startDate.format('yyyy-MM-dd\'T\'HH:mm:ss.SSS') + '-03:00';
		String strEndDate = endDate.format('yyyy-MM-dd\'T\'HH:mm:ss.SSS') + '-03:00';
        System.debug('StartDate'+strStartDate);
        System.debug('EndDate'+strEndDate);
        WebService__c ws = WebService__c.getInstance(CONST_STRING_WEBSERVICENAME);
        ws.Endpoint__c = ws.Endpoint__c + '/invoiceCredits?billingSystem=AMDOCS&maxRowsCount=200&pageCount=1&pageNumber=1&pageSize=10&accountId=' + financialAccountId + '&fromCreditDate=' + strStartDate + '&toCreditDate=' + strEndDate;
        System.debug('ws.Endpoint__c'+ws.Endpoint__c);
        HttpClient hClient = new HttpClient();
        HttpResponse response = hClient.get(ws);
		InvoceCreditsResponse result = (InvoceCreditsResponse)JSON.deserialize(response.getBody(), InvoceCreditsResponse.class);
		return result;

    }

    public static String findPaymentInstructionsByBillingAccountId(String billingAccountId){
        WebService__c ws = WebService__c.getInstance(CONST_STRING_WEBSERVICENAME);
        ws.Endpoint__c = ws.Endpoint__c + '/customerPayInstruction/'+billingAccountId;
        HttpClient hClient = new HttpClient();
        HttpResponse response = hClient.get(ws);

        if(response.getStatusCode()/100 == 2){
            Map<String, Object> responseMap = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());
            return (String)responseMap.get('paymentMethod');
        }else{
            return '';
        }
    }
}