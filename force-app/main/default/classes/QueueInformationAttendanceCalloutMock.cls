@IsTest
global class QueueInformationAttendanceCalloutMock implements HttpCalloutMock {
    protected Map<String, String> responseHeader = new Map<String,String>{'Content-Type' => 'application/json'};
    protected Integer statusCode = 200;
    protected String body = (
        '[{\"O_TP_STATUS\":\"2\",\"O_ST_STATUS\":\"EM ATENDIMENTO\",\"O_ST_SENHA\":\"SSM17\",' +
        '\"O_CD_SEGMENTACAO_CLIENTE\":\"4\",\"O_ST_SEGMENTACAO_CLIENTE\":\"N Cliente\",' +
        '\"O_DT_TEMPO_ESPERA\":\"13/04/2023 00:04:25\",\"O_DT_TEMPO_ATENDIMENTO\":\"13/04/2023 00:03:33\",' + 
        '\"O_ST_DDD\":\"81\",\"O_ST_TELEFONE\":\"982925763\",\"O_ST_DESCRICAO\":\"Recargas\",' + 
        '\"O_TP_TIPO\":null,\"O_DT_HORA_AGENDAMENTO\":\"14:05:00\",\"O_CD_AGENDAMENTO\":\"1234\",' + 
        '\"O_ST_NOME\":\"Cliente Teste\",\"O_ST_CPF\":\"12345678998\"}]'        
    );

    public QueueInformationAttendanceCalloutMock() {

    }

    public QueueInformationAttendanceCalloutMock(Map<String, String> responseHeader, Integer statusCode, String body) {
        this.responseHeader = responseHeader;
        this.statusCode = statusCode;
        this.body = body;
    }

    public HTTPResponse respond(HTTPRequest request) {
        HttpResponse response = new HttpResponse();

        for (String key : responseHeader.keySet()) {
            response.setHeader(key, responseHeader.get(key));
        }
        
        response.setStatusCode(statusCode);
        response.setBody(body);
        
        return (response);
    }
}