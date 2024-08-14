public class CancelledInstanceOMController {

    @InvocableMethod(label='Canceled Instance Order Management Controller' description='Classe utilizada para a busca de pedidos de clientes Vivo Next')
    public static List<boolean> findCanceledInstanceOrderByParams(List<RetrieveOrdersListFilter> filter){
        List<RetrieveOrdersListResponse.Orders> filteredOrders = OrderManagementService.findByFilter(filter[0].customerAccountId, filter[0].status, filter[0].types, filter[0].startDate, filter[0].endDate);

        List<boolean> results = new List<boolean>();
        for (RetrieveOrdersListResponse.Orders order : filteredOrders) {      

            for (RetrieveOrdersListResponse.OrderItems item : order.orderItems) {
                if (item.product.serviceId == filter[0].serviceId && item.implOrderTypeX9 == 'CE') {
                    results.add(true);
                }
            }
        }

        return results;
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