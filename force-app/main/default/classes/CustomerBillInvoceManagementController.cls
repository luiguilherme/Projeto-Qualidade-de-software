public with sharing class CustomerBillInvoceManagementController {

    public class SearchInvoceCreditsFilter {
        @InvocableVariable
        public String financialAccountId;
        @InvocableVariable
        public Date startDate;
        @InvocableVariable
        public Date endDate;
    }

    @InvocableMethod(label='Customer Bill Invoce Management Controller' description='Classe utilizada para consultar informações de faturamento na Amdocs')
    public static List<List<InoviceCredits>> findCreditsByFilter(List<SearchInvoceCreditsFilter> filter) {
        System.debug('filter'+filter);
        List<InoviceCredits> invoiceCredits = CustomerBillInvoceManagementService.findCreditsByFinancialAccountIdAndPeriod(filter[0].financialAccountId, filter[0].startDate, filter[0].endDate);
        return new List<List<InoviceCredits>> { invoiceCredits };
    }
}