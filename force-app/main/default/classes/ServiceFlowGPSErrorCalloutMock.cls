@isTest
global class ServiceFlowGPSErrorCalloutMock implements HttpCalloutMock {
    global HTTPResponse respond(HTTPRequest request) {
        String JSONBody = '{ "erro": { "descricao": "Código: 400 Mensagem: Operação não permitida para número de outras operadoras! O(s) número(s) (47996335057 ) não são Vivo e não serão considerados! Gentileza selecionar ou informar um número Vivo."} }';
        HttpResponse response = new HttpResponse();
        
        response.setHeader('Content-Type', 'application/json');
        response.setBody(JSONBody);
        response.setStatusCode(400);
        
        return (response);
    }
}