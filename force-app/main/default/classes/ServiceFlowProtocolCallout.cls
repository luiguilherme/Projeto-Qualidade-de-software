public with sharing class ServiceFlowProtocolCallout {
    private static final Integer CODE_HTTP_SUCCESS = 200;
        
    public static Map<String,Object> execute(Map<String,Object> mapResult, GPSGroup gpsGroup) { 
        HttpResponse httpResponse = new HttpClient().post('ServiceFlowProtocolCallout', new ServiceFlowProtocolRequest(gpsGroup).createRequestStructure().toJson());
                    
        if(httpResponse.getStatusCode() != CODE_HTTP_SUCCESS) {
            mapResult.put('error', 'Erro ao chamar a API');
            mapResult.put('errorToast', ServiceFlowGPSFormResponse.parse(httpResponse.getBody()));
        }else{
            mapResult.put('success', ServiceFlowProtocolResponse.parse(httpResponse.getBody()));
        }
        return mapResult;
    }
}