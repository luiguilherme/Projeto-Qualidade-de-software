public with sharing class RealDocumentServiceIntegration implements DocumentServiceIntegration
{    
    public static final String WEB_SERVICE = 'DocumentRepository';

    public static HttpResponse getDocument(String protocol)
    {
        if (String.isBlank(protocol)) { throw new DocumentServiceException('protocol não pode ser nulo'); }

        HttpClient request = new HttpClient();
        Webservice__c wsConfig = Webservice__c.getInstance(WEB_SERVICE);
        String endPoint = buildEndpoint(wsConfig, protocol);
        HttpResponse response = request.get(wsConfig, endPoint);
		return response;
    }

    private static String buildEndpoint(Webservice__c wsConfig, String protocol) {
        return wsConfig.Endpoint__c + '?protocol=' + protocol;
    }
}