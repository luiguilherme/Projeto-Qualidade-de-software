@isTest
global class ServiceFlowFormRotinaCalloutMock implements HttpCalloutMock {
    global HTTPResponse respond(HTTPRequest request) {
        String JSONBody = '{ "codigoOperacao": 270, "token": "126d83535393f38376e7784d3404164b", "formulario": { "id": "reenviarExtratoDeComprasController", "label": "Reenviar Extrato de Compras", "status": "PENDENTE", "tipo": "ADICIONAL", "etapa": { "status": "PENDENTE", "parametros": { "parametrosObrigatorios": { "parametro": [ { "chave": "FORM_ADC_ORDERNUM_RESENDEXTRACT", "tipo": "TEXT_LIST" } ] }, "parametrosDisponiveis": { "parametro": [ { "tipo": "TABLE", "parametros": { "parametro": [ { "tipo": "TABLE_LINE", "parametros": { "parametro": [ { "chave": "Número da ordem", "valor": "8-A89A23CE43-1", "tipo": "TEXT" }, { "chave": "Tipo do documento", "valor": "Venda de Oferta", "tipo": "TEXT" }, { "chave": "Criado em", "valor": "16/08/2021", "tipo": "TEXT", "mascara": "dd/MM/yyyy" }, { "chave": "Visualizar", "valor": "Visualizar", "tipo": "BUTTON", "parametros": { "parametro": [ { "valor": "v+ÓzË^ýØ¯" "tipo": "BASE64" } ] } }, { "chave": "Reenviar", "tipo": "CHECKBOX", "parametros": { "parametro": [ { "chave": "FORM_ADC_ORDERNUM_RESENDEXTRACT", "valor": "8-A89A23CE43-1" } ] } } ] } } ] } } ] } } } } }';
        HttpResponse response = new HttpResponse();
        
        response.setHeader('Content-Type', 'application/json');
        response.setBody(JSONBody);
        response.setStatusCode(271);
        
        return (response);
    }
}