@IsTest
global class OperationalInformationsCalloutMock implements HttpCalloutMock {
    protected Map<String, String> responseHeader = new Map<String,String>{'Content-Type' => 'application/json'};
    protected Integer statusCode = 200;
    protected String body = (
        '{\"attendantPauseOptions\": [{\"id\": \"2\", \"name\": \"Banheiro\"},{\"id\": \"19\", \"name\": \"Almoco\"}],' +
        '\"businessLines\": [{\"id\": \"1\", \"description\": \"Móvel\", \"name\": \"MOVEL\"}, {\"id\": \"2\", \"description\": \"Fixa\", \"name\": \"FIXA\"}],' +
        '\"quittingReasons\": [{\"id\": \"QR1\", \"description\": \"Retornará em outro horário / dia\"}, {\"id\": \"QR2\", \"description\": \"Cliente desistiu da compra\"}],'+
        '\"interactions\": [{\"id\": \"705\", \"name\": \"Alteração Cadastral - TV\", \"businessLine\": {\"name\": \"TV\"}},'+
        '{\"id\": \"728\", \"name\": \"Cancelamento - Fixa\", \"businessLine\": {\"name\": \"FIXA\"}}]}'
        );

    public OperationalInformationsCalloutMock() {

    }

    public OperationalInformationsCalloutMock(Map<String, String> responseHeader, Integer statusCode, String body) {
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