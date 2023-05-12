@isTest
 global class OrderHybrisCalloutMock implements HttpCalloutMock {

    protected Integer code;
    protected Map<String, String> responseHeaders;
    protected String body;

    public OrderHybrisCalloutMock(Integer code, String body, Map<String, String> responseHeaders) {
        this.code = code;
        this.body = body;
        this.responseHeaders = responseHeaders;
    }

    public HTTPResponse respond(HTTPRequest req) {
        HttpResponse response = new HttpResponse();
        response.setStatusCode(code);
        response.setBody(body);
        if (responseHeaders != null) {
            for (String key : responseHeaders.keySet()) {
                response.setHeader(key, responseHeaders.get(key));
            }
        }
        return response;
    }
}