@isTest
global class FormSelecaoInstanciaCalloutMock implements HttpCalloutMock {
    global HTTPResponse respond(HTTPRequest request) {
        String JSONBody = '{"codigoOperacao":270,"token":"4e03a45f7aeedef99562fd4bad73f2db","formulario":{"id":"selecaoInstanciaFormAtendimentoController","label":"Formulário de Seleção de Instâncias","status":"PENDENTE","tipo":"ATENDIMENTO","etapa":{"status":"PENDENTE","parametros":{"parametrosObrigatorios":{"parametro":[{"chave":"SERIAL_INSTANCIA_FORM_ATEND_SEL_INST","tipo":"TEXT_LIST"}]},"parametrosDisponiveis":{"parametro":[{"tipo":"TABLE","parametros":{"parametro":[{"chave":"SERIAL_INSTANCIA_FORM_ATEND_SEL_INST","valor":"4130892763","tipo":"TABLE_LINE","parametros":{"parametro":[{"chave":"Oferta","valor":"Vivo Fixo Ilimitado Local Oferta - FSP","tipo":"TEXT"},{"chave":"Sel.","tipo":"CHECKBOX"},{"chave":"Tipo Produto","valor":"Linha Telefônica","tipo":"TEXT"},{"chave":"Identificador","valor":"4130892763","tipo":"TEXT"},{"chave":"Perfil de Cobrança","valor":"899981029206","tipo":"TEXT"},{"chave":"Status","valor":"Ativo","tipo":"TEXT"}]}},{"chave":"SERIAL_INSTANCIA_FORM_ATEND_SEL_INST","valor":"CTA-81GZ0K7DF-013","tipo":"TABLE_LINE","parametros":{"parametro":[{"chave":"Oferta","valor":"Vivo Fixo Ilimitado Local Oferta - FSP","tipo":"TEXT"},{"chave":"Sel.","tipo":"CHECKBOX"},{"chave":"Tipo Produto","valor":"Banda Larga","tipo":"TEXT"},{"chave":"Identificador","valor":"CTA-81GZ0K7DF-013","tipo":"TEXT"},{"chave":"Perfil de Cobrança","valor":"899981029206","tipo":"TEXT"},{"chave":"Status","valor":"Ativo","tipo":"TEXT"}]}},{"chave":"SERIAL_INSTANCIA_FORM_ATEND_SEL_INST","valor":"TV-CTA-81GZ0K5IH-050","tipo":"TABLE_LINE","parametros":{"parametro":[{"chave":"Oferta","valor":"Vivo Fixo Ilimitado Local Oferta - FSP","tipo":"TEXT"},{"chave":"Sel.","tipo":"CHECKBOX"},{"chave":"Tipo Produto","valor":"TV por Assinatura","tipo":"TEXT"},{"chave":"Identificador","valor":"TV-CTA-81GZ0K5IH-050","tipo":"TEXT"},{"chave":"Perfil de Cobrança","valor":"899981029206","tipo":"TEXT"},{"chave":"Status","valor":"Ativo","tipo":"TEXT"}]}}]}}]}}}}}';

        HttpResponse response = new HttpResponse();
        
        response.setHeader('Content-Type', 'application/json');
        response.setBody(JSONBody);
        response.setStatusCode(271);
        
        return (response);
    }
}