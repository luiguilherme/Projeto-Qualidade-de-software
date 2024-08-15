public with sharing class CancelledOrdersController {

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

    @InvocableMethod(label='Cancelled Order Management Controller' description='Utilizado para buscar os pedidos de cancelamento do cliente')
    public static List<List<Orders>> findCancelledOrdersByFilters(List<RetrieveOrdersListFilter> filter){
    
        List<RetrieveOrdersListResponse.Orders> filteredOrders = OrderManagementService.findByFilter(
            filter[0].customerAccountId, 
            filter[0].status, 
            filter[0].types, 
            filter[0].startDate, 
            filter[0].endDate
        );

        List<Orders> orders = new List<Orders>();
        List<List<Orders>> finalOrders = new List<List<Orders>>(); 

        for (RetrieveOrdersListResponse.Orders order : filteredOrders) {   
            List<OrderItemList> orderItems = new  List<OrderItemList>();

            for (RetrieveOrdersListResponse.OrderItems item : order.orderItems) {
                if (item.product.serviceId == filter[0].serviceId && item.replaceOfferIndicator) {
                    OrderItemList singleOrderItem = new OrderItemList();
                    singleOrderItem.id = item.serviceRequiredDate;
                    singleOrderItem.serviceId = item.product.serviceId;
                    singleOrderItem.actionType = item.actionType;
                    singleOrderItem.status = item.actionType;
                    singleOrderItem.implActionTypeX9 = item.implActionTypeX9;
                    singleOrderItem.implOrderTypeX9 = item.implOrderTypeX9;
                    singleOrderItem.closeDate = (item.oacloseDate != null) ? DateTime.newInstance(Long.valueOf(item.oacloseDate)).date() : null;
                    singleOrderItem.workOrderIdX9 = item.workOrderIdX9;
                    orderItems.add(singleOrderItem);
                }
            }

            Orders singleOrder = new Orders();
            singleOrder.creationDate = (order.creationDate != null) ? DateTime.newInstance(Long.valueOf(order.creationDate)).date() : null;
            singleOrder.referenceNumber = order.referenceNumber;
            singleOrder.status = order.status;
            singleOrder.finalAmount = (order.recurringPrice != null && order.recurringPrice.finalAmount != null) ? Decimal.valueOf(order.recurringPrice.finalAmount) : 0.00;
            singleOrder.itens = orderItems;

            orders.add(singleOrder);
        }
        
        finalOrders.add(orders);
        return finalOrders;
    }
}