public with sharing class BiometryHistoryFacade {
    public static string CONST_STRING_WEBSERVICENAME = 'BiometryHistoryCallout';

    public static List<BiometryHistoryResponse> findByFilters(String documentNumber, Date biometryDate, String orderId){
        WebService__c ws = WebService__c.getInstance(CONST_STRING_WEBSERVICENAME);
        String endPoint = ws.Endpoint__c;

        endPoint = endPoint.replace('{biometryDate}', biometryDate != null ? DateTime.newInstance(biometryDate, Time.newInstance(0, 0, 0, 0)).format('dd-MM-yyyy') : '');
        endPoint = endPoint.replace('{documentNumber}', documentNumber);
        endPoint = endPoint.replace('{orderId}', orderId);

        List<Map<String, Object>> sourceSystems = new List<Map<String, Object>>{
            new Map<String, Object>{ 'systemId' => 'GEDOC' }
        };

        HttpClient hClient = new HttpClient();
        HttpResponse response = hClient.get(ws, endPoint);
        System.debug('Response -> ' +response.getBody());
        BiometryHistoryResponse result = (BiometryHistoryResponse)JSON.deserialize(response.getBody(), BiometryHistoryResponse.class);

        List<BiometryHistoryResponse> responseList = new List<BiometryHistoryResponse>{result};

        return responseList;
    }
}