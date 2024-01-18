/*
    ---------------------------------------------------
    @PTI3946-120 - 06/11/2023 - Márcio Las (deprecated)
    @description - Recuperação das Senhas de Atendimento | Salesforce x GSS
    ---------------------------------------------------
*/
@IsTest
global class PointOfServiceTicketsCalloutMock implements HttpCalloutMock {
    protected Map<String, String> responseHeader = new Map<String,String>{'Content-Type' => 'application/json'};
    protected Integer statusCode = 200;
    protected String body = (
        '[{"id":"A229","customer":{"name":"Maria da Silva","segment":{"id":"01","name":"Cliente V"},' +
        '"individualIdentification":{"nationalIdentilyCardNr":"12345678901","documentType":"CPF"}},' +
        '"duration":{"amount":"2022-06-02 00:05:50"},"geographicArea":{"code":"11"},' +
        '"network":{"networkNumber":"988887654"},"interaction":{"name":"Ajuste de Plano"}},' +
        '{"id":"A230","customer":{"name":"Márcio Las","segment":{"id":"01","name":"Purpura"},' +
        '"individualIdentification":{"nationalIdentilyCardNr":"22233344405","documentType":"CPF"}},' +
        '"duration":{"amount":"2022-06-02 00:03:16"},"geographicArea":{"code":"11"},' +
        '"network":{"networkNumber":"999773256"},"interaction":{"name":"Consultoria Tecnológica"}}]'
    );

    public PointOfServiceTicketsCalloutMock() {

    }

    public PointOfServiceTicketsCalloutMock(Map<String, String> responseHeader, Integer statusCode, String body) {
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
