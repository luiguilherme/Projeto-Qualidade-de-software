public with sharing class NewProductHighOrdersController {
    public static final List<String> STATUS = new List<String>{'CLOSED'};
    public static final List<String> TYPES = new List<String>{'PR','CH'};

    public class RetrieveOrdersListFilter{
        @InvocableVariable
        public String customerAccountId;
        @InvocableVariable
        public String instanceProductId;
        @InvocableVariable
        public List<String> status;
        @InvocableVariable 
        public List<String> types; 
        @InvocableVariable
        public Date startDate; 
        @InvocableVariable
        public Date endDate;
    }

    public class NewProductHighOrdersResponse{
        @InvocableVariable
        public Orders order;
    }

    @InvocableMethod(label='New Product High Order Management Controller' description='Utilizado para buscar os pedidos de nova alta de produto do cliente')
    public static List<NewProductHighOrdersResponse> findNewProductHighOrdersByFilters(List<RetrieveOrdersListFilter> filter){
        String serviceId = filter[0].instanceProductId;
        NewProductHighOrdersResponse result = new NewProductHighOrdersResponse();
        
        List<RetrieveOrdersListResponse.Orders> orders = OrderManagementService.findByFilter(
            filter[0].customerAccountId, 
            STATUS, 
            TYPES, 
            filter[0].startDate, 
            filter[0].endDate
       	);
 		
        if (!orders.isEmpty()) {
            for (RetrieveOrdersListResponse.Orders order : orders) {
                if (order.orderItems != null && !order.orderItems.isEmpty()) {
                    for (RetrieveOrdersListResponse.OrderItems item : order.orderItems) {
                        if (serviceId == item.product.serviceId) {
                            Orders responseOrder = new Orders();
                            responseOrder.creationDate = order.creationDate1.Date();
                            responseOrder.referenceNumber = order.referenceNumber;
                            responseOrder.status = order.status ;
                            responseOrder.finalAmount = order.recurringPrice != null && order.recurringPrice.finalAmount != null ? 
                                Decimal.valueOf(order.recurringPrice.finalAmount) : 0;
                            
                            result.order = responseOrder;
                            break;
                        }
                    }
                }                
            }
        }

        return new List<NewProductHighOrdersResponse>{ result };
    }
}