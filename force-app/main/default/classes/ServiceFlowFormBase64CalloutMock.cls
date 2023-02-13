@isTest
global class ServiceFlowFormBase64CalloutMock implements HttpCalloutMock {
    global HTTPResponse respond(HTTPRequest request) {
        String JSONBody = '{ "codigoOperacao": 270, "token": "fa8715d1073392c1cf95e594e923f7d8", "formulario": { "id": "reenviarExtratoDeComprasController", "label": "Reenviar Extrato de Compras", "status": "PENDENTE", "tipo": "ADICIONAL", "etapa": { "status": "PENDENTE", "parametros": { "parametrosObrigatorios": { "parametro": [ { "chave": "FORM_ADC_ORDERNUM_RESENDEXTRACT", "tipo": "TEXT_LIST" } ] }, "parametrosDisponiveis": { "parametro": [ { "tipo": "TABLE", "parametros": { "parametro": [ { "valor": "dGVzdGU2NA==", "tipo": "BASE64" } ] } } ] } } } } }';
        HttpResponse response = new HttpResponse();
        
        response.setHeader('Content-Type', 'application/json');
        response.setBody(JSONBody);
        response.setStatusCode(270);
        
        return (response);
    }
}