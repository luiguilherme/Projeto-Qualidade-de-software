@IsTest
global class PointOfServiceAttendantCalloutMock implements HttpCalloutMock {
    protected Map<String, String> responseHeader = new Map<String,String>{'Content-Type' => 'application/json'};
    protected Integer statusCode = 200;

    public PointOfServiceAttendantCalloutMock() {

    }

    public PointOfServiceAttendantCalloutMock(Map<String, String> responseHeader, Integer statusCode) {
        this.responseHeader = responseHeader;
        this.statusCode = statusCode;
    }

    public HTTPResponse respond(HTTPRequest request) {
        HttpResponse response = new HttpResponse();

        for (String key : responseHeader.keySet()) {
            response.setHeader(key, responseHeader.get(key));
        }
        
        response.setStatusCode(statusCode);
        
        return (response);
    }
}