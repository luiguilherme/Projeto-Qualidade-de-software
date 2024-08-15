public with sharing class CustomerBillInvoceManagementService {
	public static List<InoviceCredits> findCreditsByFinancialAccountIdAndPeriod(String financialAccountId, DateTime startDate, DateTime endDate) {
        List<InoviceCredits> credits = new List<InoviceCredits>();
		InvoceCreditsResponse response = CustomerBillInvoceManagementFacade.findCreditsByFinancialAccountIdAndPeriod(financialAccountId, startDate, endDate);
        
		if(response != null 
           	&& response.invoiceCredits != null 
           	&& response.invoiceCredits.credits != null
           	&& !response.invoiceCredits.credits.isEmpty()){
			
			for (InvoceCreditsResponse.Credits credit : response.invoiceCredits.credits) {
                if (credit != null) {
                    credits.add(new InoviceCredits(
                        credit.amount,
                        credit.balanceImpactCode,
                        credit.creditType,
                        credit.invoiceNumber,
                        credit.categoryCode,
                        credit.creditId,
                        credit.levelCode,
                        credit.noteExtract,
                        credit.reason,
                        credit.reasonDescription,
                        credit.invoiceId,
                        credit.l9BillingChargeSeqNo,
                        credit.l9ChargeInvoiceId,
                        credit.l9EventId,
                        credit.memoText,
                        credit.restrictedChargeId,
                        credit.reversalReason,
                        credit.restrictedInvoiceNumber,
                        credit.reversalTransId,
                        credit.transactionId
                    ));  
                }
            }
		}
        
		return credits;
    }

    public static String findPaymentInstructionsByBillingAccountId(String billingAccountId){
        return CustomerBillInvoceManagementFacade.findPaymentInstructionsByBillingAccountId(billingAccountId);
    }
}