public without sharing class OrderManagementController extends AbstractOrderManagementController {

    @InvocableMethod(label='Order Management Controller' description='Classe utilizada para a busca de pedidos de clientes Vivo Next')
    public static List<RetrieveOrdersListResponse> findReplaceOfferOrderByParams(List<RetrieveOrdersListFilter> filter){
        RetrieveOrdersListResponse result = new RetrieveOrdersListResponse();

        List<RetrieveOrdersListResponse.Orders> filteredOrders = OrderManagementService.findByFilter(
            filter[0].customerAccountId, filter[0].status, filter[0].types, filter[0].startDate, filter[0].endDate);

        System.debug('filteredOrders: ' + filteredOrders);

        if(filteredOrders == null){
            return null;
        }

        for (RetrieveOrdersListResponse.Orders order : filteredOrders) {   
            for (RetrieveOrdersListResponse.OrderItems item : order.orderItems) {
                if (item.product != null && item.product.serviceId == filter[0].serviceId && item.replaceOfferIndicator) {
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
        
        return new List<RetrieveOrdersListResponse>{ result };
    }

    @AuraEnabled
    public static List<Orders> findByFilters(String accountId, List<String> status, List<String> types, Date startDate, Date endDate){

        List<RetrieveOrdersListResponse.Orders> orderFilters = OrderManagementService.findByFilter(accountId, status, types, startDate, endDate);

        List<Orders> orders = new List<Orders>();
        for(RetrieveOrdersListResponse.Orders order : orderFilters){
            Orders orderObj = new Orders();
            orderObj.creationDate = order.creationDate1.Date();
            orderObj.referenceNumber = order.referenceNumber;
            orderObj.status = order.status ;
            orderObj.finalAmount = order.recurringPrice != null && order.recurringPrice.finalAmount != null ? Decimal.valueOf(order.recurringPrice.finalAmount) : 0;
            orders.add(orderObj);

        }
    
        return orders;

    }
   
    public class RetrieveOrdersListFilter {
        @InvocableVariable
        public String serviceId;
        @InvocableVariable
        public String customerAccountId;
        @InvocableVariable
        public List<String> status;
        @InvocableVariable
        public List<String> types;
        @InvocableVariable 
        public Date startDate;
        @InvocableVariable
        public Date endDate;

    }
}