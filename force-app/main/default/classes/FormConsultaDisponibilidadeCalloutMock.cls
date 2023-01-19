@isTest
global class FormConsultaDisponibilidadeCalloutMock implements HttpCalloutMock {
    global HTTPResponse respond(HTTPRequest request) {
        String JSONBody = '{"codigoOperacao":200,"token":"64acc2604e68d82aeded1b5f7ac5ea77","formulario":{"id":"formularioVerificarDisponibilidadeFibraMb","label":"Formulário de verificação de disponibilidade Fibra(FTTH)","status":"EM ANALISE","tipo":"ACAO","etapa":{"status":"EM ANALISE","parametros":{"parametrosDisponiveis":{"parametro":[{"valor":"Atenção!","tipo":"TEXT","parametros":{"parametro":[{"valor":"bolder","tipo":"FONT_WEIGHT"}]}},{"valor":"Este cliente possui disponibilidade de migração para Fibra, realize a oferta ao cliente e apresente as vantagens do produto de banda larga/TV com fibra ótica.","tipo":"TEXT","parametros":{"parametro":[{"valor":"bolder","tipo":"FONT_WEIGHT"}]}},{"valor":"Se o cliente aceitar, realize a alteração da oferta nas ferramentas disponíveis e agende com o cliente uma data para realizar a alteração.","tipo":"TEXT","parametros":{"parametro":[{"valor":"bolder","tipo":"FONT_WEIGHT"}]}},{"valor":"Endereço(s) selecionado(s) no atendimento: (V – possui disponibilidade; X – não possui disponibilidade):","tipo":"TEXT","parametros":{"parametro":[{"valor":"bolder","tipo":"FONT_WEIGHT"}]}},{"tipo":"TABLE","parametros":{"parametro":[{"tipo":"TABLE_LINE","parametros":{"parametro":[{"chave":"Endereço","valor":"R. CARANGUEJO, 87","tipo":"TEXT"},{"chave":"Disponibilidade Fibra","valor":"V","tipo":"TEXT","parametros":{"parametro":[{"valor":"green","tipo":"COLOR"}]}}]}}]}}]}}}}}';

        HttpResponse response = new HttpResponse();
        
        response.setHeader('Content-Type', 'application/json');
        response.setBody(JSONBody);
        response.setStatusCode(271);
        
        return (response);
    }
}