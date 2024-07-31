public with sharing class MockCustomerCommServiceIntegration implements CustomerCommunicationServiceIntegration {
    public static HttpResponse sendEmailMessage(String payload) {
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-type', 'application/json');
        response.setStatusCode(200);
        response.setStatus('OK');
        return response;
    }
}