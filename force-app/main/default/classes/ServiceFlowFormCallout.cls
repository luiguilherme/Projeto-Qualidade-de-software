public with sharing class ServiceFlowFormCallout {

    public static Map<String,Object> execute(Map<String,Object> mapResult, String token, String formId, Map<String, Object> mapForm) {
        HttpResponse httpResponse = new HttpClient().post('ServiceFlowFormCallout', 
            new ServiceFlowFormRequest(token, formId, mapForm).createRequestStructure().toJson());

        if(httpResponse.getStatusCode() != 200 && httpResponse.getStatusCode() != 270 && httpResponse.getStatusCode() != 271 && httpResponse.getStatusCode() != 273 && httpResponse.getStatusCode() != 275 ) {
            
            mapResult.put('error', 'Erro ao chamar a API');
            mapResult.put('errorToast', ServiceFlowGPSFormResponse.parse(httpResponse.getBody()));
            return mapResult;
            
        }
        mapResult.put('form', ServiceFlowGPSFormResponse.parse(httpResponse.getBody())); 
        

        return mapResult;
    }
}