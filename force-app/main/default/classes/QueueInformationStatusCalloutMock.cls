@IsTest
global class QueueInformationStatusCalloutMock implements HttpCalloutMock {
    protected Map<String, String> responseHeader = new Map<String,String>{'Content-Type' => 'application/json'};
    protected Integer statusCode = 200;
    protected String body = '[{\"O_ST_POSICAO_ATENDIMENTO\":\"02\",\"O_ST_STATUS\":\"D\"}]';

    public QueueInformationStatusCalloutMock() {

    }

    public QueueInformationStatusCalloutMock(Map<String, String> responseHeader, Integer statusCode, String body) {
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