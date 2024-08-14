public with sharing class RetrieveOrderDetailsService {
    
    public static List<OrderItemDetails> findByAccountIdAndOrderNumber(String accountId, String orderNumber){
        List<OrderItemDetails> orderItensDetails = RetrieveOrderDetailsFacade.findByAccountIdAndOrderNumber(accountId, orderNumber);
        return orderItensDetails;
    }
}