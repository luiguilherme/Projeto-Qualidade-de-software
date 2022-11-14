@isTest
global class MassiveSuspicionCaseMock implements HttpCalloutMock {
    global HTTPResponse respond(HTTPRequest request) {
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('{ "problem":{ "problemId": "41988891234" }, "networkProblem":{ "previsionDate":"2019-06-27T13:15:00Z" } }');
        response.setStatusCode(200);
        return response;
    }
}