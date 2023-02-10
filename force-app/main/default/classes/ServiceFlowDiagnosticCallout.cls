public with sharing class ServiceFlowDiagnosticCallout {

    public static Map<String,Object> execute(Map<String,Object> mapResult, String gpsId, String assetInstance, GPSGroup gpsGroup, String token) { 
        HttpResponse httpResponse = new HttpClient().post('ServiceFlowDiagnosticCallout', 
            new ServiceFlowDiagnosticRequest(gpsId, assetInstance, gpsGroup, token).createRequestStructure().toJson());

        if(httpResponse.getStatusCode() != 200 && httpResponse.getStatusCode() != 271 && httpResponse.getStatusCode() != 275 && httpResponse.getStatusCode() != 273 && httpResponse.getStatusCode() != 274) {
            mapResult.put('error', 'Erro ao chamar a API');
            mapResult.put('errorToast', ServiceFlowGPSFormResponse.parse(httpResponse.getBody()));
        }else{
            mapResult.put('success', ServiceFlowDiagnosticResponse.parse(httpResponse.getBody()));
        }
        return mapResult;
    }
}