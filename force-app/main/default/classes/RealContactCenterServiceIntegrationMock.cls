global class RealContactCenterServiceIntegrationMock implements HttpCalloutMock
{
    global HttpResponse respond(HttpRequest request)
    {
        HttpResponse response = new HttpResponse();
        // response.setHeader('Content-Type', 'application/json');
        response.setStatusCode(201);
        response.setStatus('Created');
        response.setHeader('Location', '/interaction/A547418SASFA');
        return response;
    }
}