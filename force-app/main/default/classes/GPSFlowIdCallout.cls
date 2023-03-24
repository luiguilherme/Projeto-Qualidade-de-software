public with sharing class GPSFlowIdCallout {
    private static final Integer CODE_HTTP_SUCCESS = 200;
    private static final String WEBSERVICE_NAME = 'GPSQueryServiceFlowsCallout';
        
    public static Map<String,Object> execute(Map<String,Object> mapResult, String instance) { 
        HttpResponse httpResponse = new HttpClient().post(WEBSERVICE_NAME, new GpsFlowIdRequest(instance).createRequestStructure().toJson());

        if(httpResponse.getStatusCode() != CODE_HTTP_SUCCESS) {
            mapResult.put('error', null);           
        }else{
            mapResult.put('success', GPSFlowIdTO.parse(httpResponse.getBody()));
        }
        return mapResult;
    }
}