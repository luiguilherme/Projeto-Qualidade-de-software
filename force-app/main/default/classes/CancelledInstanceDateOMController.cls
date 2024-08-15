public class CancelledInstanceDateOMController {

    @InvocableMethod(label='Canceled Instance Date Order Management Controller' description='Classe utilizada para a busca de pedidos de clientes Vivo Next')
    public static List<String> findCanceledInstanceDateOrderByParams(List<RetrieveOrdersListFilter> filter){
        List<RetrieveOrdersListResponse.Orders> filteredOrders = OrderManagementService.findByFilter(filter[0].customerAccountId, filter[0].status, filter[0].types, filter[0].startDate, filter[0].endDate);
        List<String> results = new List<String>();
        

        if (filteredOrders.size() > 0) {
            for (RetrieveOrdersListResponse.Orders order : filteredOrders) {   
                  
    
                for (RetrieveOrdersListResponse.OrderItems item : order.orderItems) {
                    if(order != null && order.creationDate1 != null){
                        if (item.product.serviceId == filter[0].serviceId && item.implOrderTypeX9 == 'CE' && order.creationDate1 >= filter[0].startDate && order.creationDate1 <= filter[0].endDate) {
                            results.add('Dentro do ciclo');
                        }

                    }
                   
                }
            }            
            if (results.isEmpty()) {
                results.add('Fora do ciclo');
            }
            return results;
        } else {
            results.add('Não existe ordem');
            return results;
        }
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