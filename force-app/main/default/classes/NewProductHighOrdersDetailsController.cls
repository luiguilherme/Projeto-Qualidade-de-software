public with sharing class NewProductHighOrdersDetailsController {
    public static final List<String> PRODUCT_LIST_NAME = new List<String>{'Banda Larga', 'Linha Fixa de Voz', 'TV'};

    public class RetrieveOrdersDetailsListFilter {
        @InvocableVariable
        public String customerAccountId;
        @InvocableVariable
        public String orderNumber;
    }

    public class NewProductHighOrdersDetailsResponse{
        @InvocableVariable
        public List<OrderItemDetails> orderDetails;
    }

    @InvocableMethod(label='New Product High Order Details Management Controller' description='Utilizado para buscar os detalhes dos pedidos de nova alta de produto do cliente')
    public static List<NewProductHighOrdersDetailsResponse> findNewProductHighOrdersDetailsByFilters(List<RetrieveOrdersDetailsListFilter> filter){
        
        String customerAccountId = filter[0].customerAccountId;
        String orderNumber = filter[0].orderNumber;
        
        List<OrderItemDetails> orderDetailsFiltered = new List<OrderItemDetails>();
        List<OrderItemDetails> orderDetails = RetrieveOrderDetailsService.findByAccountIdAndOrderNumber(customerAccountId, orderNumber);
        
        System.debug('Detalhes da ordem: ' + orderDetails);
        
        for (OrderItemDetails orderDetail : orderDetails) {
            if (orderDetail != null 
                && PRODUCT_LIST_NAME.contains(orderDetail.itemName)
               	&& 'Adicionar' == orderDetail.action) {
                orderDetailsFiltered.add(orderDetail);
            }
        }
        
        NewProductHighOrdersDetailsResponse response = new NewProductHighOrdersDetailsResponse();
        response.orderDetails = orderDetailsFiltered;
        
        return new List<NewProductHighOrdersDetailsResponse> { response };
    }
}