@isTest
public class MockHttpResponseGenerator implements HttpCalloutMock {
    public HttpResponse respond(HttpRequest req) {
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{"status": "success"}'); // Simule a resposta que você espera da APIa
        res.setStatusCode(200); // Código de status HTTP esperado
        return res;
    }
}