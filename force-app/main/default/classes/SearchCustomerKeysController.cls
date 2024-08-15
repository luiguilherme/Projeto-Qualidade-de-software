public with sharing class SearchCustomerKeysController {

    public class SearchCustomerKeysFilter {
        @InvocableVariable
        public String serviceId;
        @InvocableVariable
        public String accountId;
    }

    public class SearchCustomerKeysResponse {
        @InvocableVariable
        public String accountId;
        @InvocableVariable
        public String financialAccountId;
        @InvocableVariable
        public String customerId;
    }

    @InvocableMethod(label='Search Customer Keys Controller' description='Classe utilizada para a busca os Ids relacionados ao cliente Amdocs')
    public static List<SearchCustomerKeysResponse> findByFilter(List<SearchCustomerKeysFilter> filter) {
        List<SearchCustomerKeysResponse> listCustomerKeys = new List<SearchCustomerKeysResponse>();      
        AccountManagementResponse response = SearchCustomerKeysService.findByServiceId(filter[0].serviceId);
        
        if (response != null) {
            SearchCustomerKeysResponse searchCustomerKeysResponse = new SearchCustomerKeysResponse();
            
            if (response.accounts != null 
                && !response.accounts.isEmpty() 
                && response.accounts[0].billingAccount != null 
                && response.accounts[0].billingAccount.financialAccountType != null) {
            	searchCustomerKeysResponse.financialAccountId = response.accounts[0].billingAccount.financialAccountType.id;        
            }
            
            if (response.customer != null && response.customer.customerAccount != null) {
            	searchCustomerKeysResponse.accountId = response.customer.customerAccount.id;    
            }
            
            if (response.account != null) {
            	searchCustomerKeysResponse.customerId = response.account.href;    
            }            
            
            listCustomerKeys.add(searchCustomerKeysResponse);
        }
        
		return listCustomerKeys;
    }
}