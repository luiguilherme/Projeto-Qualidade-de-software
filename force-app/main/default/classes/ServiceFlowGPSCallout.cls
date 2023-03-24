public with sharing class ServiceFlowGPSCallout {

    private static final String CUSTOM_SETTING_CREATE_SS = 'ServiceFlowGPSCreateSSCallout';

    public static ServiceFlowGPSResponse createSS(String regraNegocio, String documento, String instancia, String usuario, Map<String,String> params) {

        ServiceFlowGPSResponse response = new ServiceFlowGPSResponse();

        try {
            HttpResponse httpResponse = new HttpClient().post(
                CUSTOM_SETTING_CREATE_SS, 
                new ServiceFlowGPSRequest(regraNegocio, 
                                          documento, 
                                          instancia, 
                                          usuario, 
                                          params).toJson());
    
            String reponseBody = httpResponse.getBody();
            System.debug('HttpRequest: ' + new ServiceFlowGPSRequest(regraNegocio, documento, instancia, usuario, params).toJson());
            System.debug('httpResponse.getBody(): ' + httpResponse.getBody());
            if(httpResponse.getStatusCode() != 200) {
                System.debug('StatusCode != 200 on ServiceFlowGPSCallout.createSS->' + reponseBody);
            }

            response = ServiceFlowGPSResponse.parse(reponseBody);

        } catch (Exception e) {
            System.debug('Exception on ServiceFlowGPSCallout.createSS->' + e.getMessage());
        }

        return response;
    }
}