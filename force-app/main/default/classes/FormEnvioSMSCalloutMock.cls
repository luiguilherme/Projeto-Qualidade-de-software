@isTest
global class FormEnvioSMSCalloutMock implements HttpCalloutMock {
    global HTTPResponse respond(HTTPRequest request) {
        String JSONBody = '{ "token":"21be4e0e0aefb21836f0886a08cf51f0", "formulario":{ "id":"formularioEnvioSMSIncentivo", "label":"Formulário para Seleção de Número para Envio SMS de incentivo", "status":"PENDENTE", "tipo":"ADICIONAL", "etapa":{ "status":"PENDENTE", "parametros":{ "parametrosObrigatorios":{ "parametro":[ { "chave":"FORM_ADC_LINHAS_SMS_INCENTIVO", "tipo":"TEXT_LIST" } ] }, "parametrosDisponiveis":{ "parametro":[ { "valor":"Selecionar tudo", "tipo":"CHECKBOX", "parametros":{ "parametro":[ { "chave":"FORM_ADC_LINHAS_SMS_INCENTIVO", "tipo":"TEXT_LIST", "parametros":{ "parametro":[ { "valor":"41995429288" } ] } } ] } }, { "valor":"41995429288", "tipo":"CHECKBOX", "parametros":{ "parametro":[ { "chave":"FORM_ADC_LINHAS_SMS_INCENTIVO", "valor":"41995429288" } ] } }, { "valor":"41995429284", "tipo":"CHECKBOX", "parametros":{ "parametro":[ { "chave":"FORM_ADC_LINHAS_SMS_INCENTIVO", "valor":"41995429284" } ] } }, { "valor":"41995429283", "tipo":"CHECKBOX", "parametros":{ "parametro":[ { "chave":"FORM_ADC_LINHAS_SMS_INCENTIVO", "valor":"41995429283" } ] } }, { "valor":"41995429282", "tipo":"CHECKBOX", "parametros":{ "parametro":[ { "chave":"FORM_ADC_LINHAS_SMS_INCENTIVO", "valor":"41995429282" } ] } }, { "valor":"41995429281", "tipo":"CHECKBOX", "parametros":{ "parametro":[ { "chave":"FORM_ADC_LINHAS_SMS_INCENTIVO", "valor":"41995429281" } ] } }, { "chave":"FORM_ADC_LINHAS_SMS_INCENTIVO", "tipo":"INPUT_NUMBER", "mascara":"99 999999999", "maxLenght":12 } ] } } } } }';

        HttpResponse response = new HttpResponse();
        
        response.setHeader('Content-Type', 'application/json');
        response.setBody(JSONBody);
        response.setStatusCode(271);
        
        return (response);
    }
}