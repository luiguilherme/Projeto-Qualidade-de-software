@isTest
global class GPSFlowIdCalloutMock implements HttpCalloutMock {
    global HTTPResponse respond(HTTPRequest request) {
        String jsonGPSFlow = '{ "tipificacoes": { "tipificacao": [ { "id": 30349, "descricao": "Receber por e-mail", "hierarquia": "Solicitação > 2° Via > Fatura > Receber por e-mail" }, { "id": 30390, "descricao": "PP4299_RA_ClienteRetido_2", "hierarquia": "Solicitação > Atendimento > PP4299 > PP4299_RA_ClienteRetido_2" }, { "id": 29802, "descricao": "Teste TALC", "hierarquia": "Informação > Nível 2 > Nível 3 > Teste TALC" } ] } }';

        HttpResponse response = new HttpResponse();
        
        response.setHeader('Content-Type', 'application/json');
        response.setBody(jsonGPSFlow);
        response.setStatusCode(200);
        
        return (response);
    }
}