public with sharing class MockContactCenterServiceIntegration implements ContactCenterServiceIntegration
{
    public static HttpResponse createOpenMediaInteraction(String payload)
    {
        HttpResponse response = new HttpResponse();
        //response.setHeader('Content-type', 'application/json');
        response.setStatusCode(201);
        response.setStatus('Created');
        response.setHeader('Location', '/interaction/A547418SASFA');
        return response;
    }
}