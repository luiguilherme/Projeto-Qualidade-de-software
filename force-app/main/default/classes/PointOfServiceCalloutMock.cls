@IsTest
global class PointOfServiceCalloutMock implements HttpCalloutMock {
    protected Map<String, String> responseHeader = new Map<String,String>{'Content-Type' => 'application/json'};
    protected Integer statusCode = 200;
    protected String body = (
            '{\"id\": 307, \"segment\": {\"name\": \"Segmento\"}, \"name\": \"Shopping Morumbi\", ' +
            '\"attendant\": {\"id\": 22}, \"workPosition\": [{\"ID\": \"01\", \"status\": \"Empty\"}, ' + 
            '{\"ID\": \"02\", \"status\": \"Empty\"}, {\"ID\": \"03\", \"status\": \"Empty\"}]}'
        );

    public PointOfServiceCalloutMock() {

    }

    public PointOfServiceCalloutMock(Map<String, String> responseHeader, Integer statusCode, String body) {
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
