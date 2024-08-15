public without sharing class RetrieveOrderDetailsController {
    
    public class RetrieveOrdersDetailsFilter {
        @InvocableVariable
        public String accountId;
        @InvocableVariable
        public String orderNumber;
    }
    
    @InvocableMethod(label='Retrieve Order Details Controller' description='')
    public static List<OrderItemDetails> findByAccountIdAndOrderNumberIN(List<RetrieveOrdersDetailsFilter> filter) {
        List<OrderItemDetails> orderItensDetails = RetrieveOrderDetailsService.findByAccountIdAndOrderNumber(filter[0].accountId, filter[0].orderNumber);
        return orderItensDetails;
    }
   
    @AuraEnabled
    public static List<OrderItemDetails> findByAccountIdAndOrderNumber(String accountId, String orderNumber) {
        List<OrderItemDetails> orderItensDetails = RetrieveOrderDetailsService.findByAccountIdAndOrderNumber(accountId, orderNumber);
        return orderItensDetails;
    }

}