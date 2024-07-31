public without sharing class DocumentService
{
    public static String getBase64EncodedDocument(String documentId)
    {
        if (String.isBlank(documentId)) { throw new IllegalArgumentException('documentId não pode ser nulo.'); }
        String protocol = FileLinkDAO.getById(documentId).IDGedoc__c;
        DocumentServiceIntegration documentServiceIntegration = DocumentServiceIntegrationConfig.getService();
        
        HttpResponse response = documentServiceIntegration.getDocument(protocol);
        Integer statusCode = response.getStatusCode();
        String status = response.getStatus();
        String responseBody = response.getBody();

        System.debug(LoggingLevel.INFO, statusCode);
        System.debug(LoggingLevel.INFO, status);
        System.debug(LoggingLevel.INFO, responseBody);
        
        if (statusCode != 200) { throw new CalloutException('Código de status HTTP inesperado: ' + statusCode); }
        DocumentRepositoryResponse.DataWrapper data = (DocumentRepositoryResponse.DataWrapper) JSON.deserializeStrict(responseBody, DocumentRepositoryResponse.DataWrapper.class);
        return data.customer.document;
    }
}