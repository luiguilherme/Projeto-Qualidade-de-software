public with sharing class RetrieveOrderListController extends AbstractOrderManagementController  {
    
 
    @InvocableMethod(label = 'Retrieve Order List Controller' description='Utilizado para buscar os pedidos de um cliente Amdocs')
    public static List<List<RetrieveOrdersListResponse.Orders>> findbyFilters(List<RetrieveOrdersListFilter> filter){
            return new List<List<RetrieveOrdersListResponse.Orders>>{(OrderManagementService.findByFilter(filter[0].customerAccountId, filter[0].status, filter[0].types, filter[0].startDate, filter[0].endDate))};  
        
     }

}