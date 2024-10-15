public with sharing class RetrieveOrderDetailsService {
    
    public static List<OrderItemDetails> findByAccountIdAndOrderNumber(String accountId, String orderNumber){
        return RetrieveOrderDetailsFacade.findByAccountIdAndOrderNumber(accountId, orderNumber);
    }
}