public without sharing class OrderHybrisCallout {
    private static final Integer CODE_HTTP_SUCCESS = 200;
    private static final String WEBSERVICE_CANVASHYBRIS = 'OrderHybrisCallout';
            
    public static Map<String, Object> execute(String orderId) { 
        Map<String, Object> mapResult = new Map<String,Object>();
        try {
            WebService__c wsConfig = Webservice__c.getInstance(WEBSERVICE_CANVASHYBRIS); 
            wsConfig.endpoint__c = wsConfig.endpoint__c.replace('{orderId}', orderId);
        
            HttpResponse httpResponse = new HttpClient().get(wsConfig);
        
            if(httpResponse.getStatusCode() != CODE_HTTP_SUCCESS){
                mapResult.put('error', 'API com erro');
            }else{
                mapResult.put('response', httpResponse.getBody());
            }
            
        } catch (Exception ex) {
            mapResult.put('error', 'Erro ao executar ' + ex.getMessage());
        } 
        return mapResult;
    }
}