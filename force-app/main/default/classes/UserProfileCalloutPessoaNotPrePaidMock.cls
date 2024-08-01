global with sharing class UserProfileCalloutPessoaNotPrePaidMock implements HttpCalloutMock{
    global HTTPResponse respond(HTTPRequest request) {
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('{"identities":[{"services":["authentication"],"roles":["owner"],"id":"63542141747","type":"uid"},{"services":["authentication"],"roles":["owner"],"id":"63542141747@gmail.com","type":"email"},{"services":["authentication"],"roles":["owner"],"id":"+5511943985782","type":"phone_number"}],"id":"4dbdd9d3-78db-4189-9156-25b9073cb1ae","name":"ARTHUR HENRIQUE ESPINHEIRA","id_document":{"value":"63542141747","country":"BR","type":"CPF"}}');
        response.setStatusCode(200);
        return response;    
    }
}