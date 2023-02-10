@isTest
global class ServiceFlowProtocolCalloutMock implements HttpCalloutMock {
    global HTTPResponse respond(HTTPRequest request) {
        String JSONBody = '{"protocolo":"27092021-6199489","parametros":{"parametro":[{"chave":"ID_SS","valor":"8-GZ28JDX"},{"chave":"STATUS_SS","valor":"Atribuído"},{"chave":"EXPECTATIVA_ATENDIMENTO","valor":"Teste"}, { "chave": "ERRO", "valor": "930", "parametros": { "parametro": [ { "chave": "Detalhe", "valor": "Todos os parametros da rotina Agendar Defeito Simplificado devem ser preenchidos." } ] } }]}}';

        HttpResponse response = new HttpResponse();
        
        response.setHeader('Content-Type', 'application/json');
        response.setBody(JSONBody);
        response.setStatusCode(200);
        
        return (response);
    }
}