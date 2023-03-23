@isTest
global class ServiceFlowGPSCalloutMock implements HttpCalloutMock {
    global HTTPResponse respond(HTTPRequest request) {
        String JSONBody = '{"codigoOperacao":200,"protocolo":"02092022-8512765","idSS":"8-HM0IOE1","status":"Fechado"}';

        HttpResponse response = new HttpResponse();
        
        response.setHeader('Content-Type', 'application/json');
        response.setBody(JSONBody);
        response.setStatusCode(200);
        
        return (response);
    }
}