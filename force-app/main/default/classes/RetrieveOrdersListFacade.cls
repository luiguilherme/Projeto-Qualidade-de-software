public class RetrieveOrdersListFacade {

    public static string CONST_STRING_WEBSERVICENAME = 'RetrieveOrdersListCallout';

    public static RetrieveOrdersListResponse findByFilters(String accountId, List<String> status, List<String> types, Date startDate, Date endDate){

        WebService__c ws = WebService__c.getInstance(CONST_STRING_WEBSERVICENAME);
        ws.Endpoint__c = ws.Endpoint__c.replace('{accountId}', accountId);
		
        DateTime minOrderCreationDate = startDate != null ? DateTime.newInstance(startDate, Time.newInstance(00,00,00,0)) : null;
        DateTime maxOrderCreationDate = endDate != null ? DateTime.newInstance(endDate, Time.newInstance(23,59,59,59)) : null;
        
        Map<String, Object> filterCriteria = null;
        
        if (minOrderCreationDate != null && maxOrderCreationDate != null) {
            filterCriteria = new Map<String, Object>{
                'minOrderCreationDate' => String.valueOf(minOrderCreationDate.getTime()),
                'maxOrderCreationDate' =>  String.valueOf(maxOrderCreationDate.getTime()),
                'statuses' => getStatuses(status),
                'orders' => getOrders(types)
        	};
        } else {
            filterCriteria = new Map<String, Object>{
                'statuses' => getStatuses(status),
                'orders' => getOrders(types)
        	};
        }

        List<Map<String, Object>> sourceSystems = new List<Map<String, Object>>{
            new Map<String, Object>{ 'systemId' => 'AMDOCS' }
        };

        Map<String, Object> payloadMap = new Map<String, Object>{
            'filterCriteria' => filterCriteria,
            'sourceSystems' => sourceSystems
        };

        String payload = JSON.serialize(payloadMap);
        System.debug('Retrieve orders list payload:' + JSON.serializePretty(payloadMap));
        
        HttpClient hClient = new HttpClient();
        HttpResponse response = hClient.post(ws, payload);

        RetrieveOrdersListResponse result = (RetrieveOrdersListResponse)JSON.deserialize(response.getBody(), RetrieveOrdersListResponse.class);
        if (result == null || result.orders == null) {
            return null;
        }
        
        for (RetrieveOrdersListResponse.Orders order: result.orders) {
            String creationDateStr = String.valueOf(order.creationDate);
            String serviceRequiredDateStr = String.valueOf(order.serviceRequiredDate);
            Long creationDateLong = Long.valueOf(creationDateStr.split('\\.')[0]);
            Long serviceRequiredDateLong = Long.valueOf(serviceRequiredDateStr.split('\\.')[0]);
            DateTime creationDateDT = DateTime.newInstance(creationDateLong);
            DateTime serviceRequiredDateDT = DateTime.newInstance(serviceRequiredDateLong);
            order.creationDate1 = creationDateDT;
            order.serviceRequiredDate1 = serviceRequiredDateDT;
        }
        
        return result;

    }

    private static List<Map<String, String>> getStatuses(List<String> statusList) {
        List<Map<String, String>> statuses = new List<Map<String, String>>();
        for(String statusValue : statusList) {
            statuses.add(new Map<String, String>{ 'status' => statusValue });
        }
        return statuses;
    }
    
    private static List<Map<String, Map<String, String>>> getOrders(List<String> typesList) {
        List<Map<String, Map<String, String>>> orders = new List<Map<String, Map<String, String>>>();
        for(String typeValue : typesList) {
            orders.add(new Map<String, Map<String, String>>{
                'resourceOrder' => new Map<String, String>{ 'actionType' => typeValue }
            });
        }
        return orders;
    }

}