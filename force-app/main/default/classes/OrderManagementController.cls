public class OrderManagementController {

    @InvocableMethod(label='Order Management Controller' description='Classe utilizada para a busca de pedidos de clientes Vivo Next')
    public static List<RetrieveOrdersListResponse.Orders> findReplaceOfferOrderByParams(List<RetrieveOrdersListFilter> filter){

        List<RetrieveOrdersListResponse.Orders> filteredOrders = OrderManagementService.findByFilter(filter[0].customerAccountId, filter[0].status, filter[0].types, filter[0].startDate, filter[0].endDate);
        if(filteredOrders == null){
            return null;
        }
        List<RetrieveOrdersListResponse.Orders> orders = new List<RetrieveOrdersListResponse.Orders>();
        for (RetrieveOrdersListResponse.Orders order : filteredOrders) {   
            
            for (RetrieveOrdersListResponse.OrderItems item : order.orderItems) {

                if (item.product.serviceId == filter[0].serviceId && item.replaceOfferIndicator) {
                    orders.add(order);
                }
            }

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