public class OrderManagementService {

    public static List<RetrieveOrdersListResponse.Orders> findByFilter(String customerAccountId, List<String> status, List<String> types, Date startDate, Date endDate) {
        RetrieveOrdersListResponse response = RetrieveOrdersListFacade.findByFilters(customerAccountId, status, types, startDate, endDate);
        if(response == null){
            return new List<RetrieveOrdersListResponse.Orders>();
        }
        return response.orders;
    }
}