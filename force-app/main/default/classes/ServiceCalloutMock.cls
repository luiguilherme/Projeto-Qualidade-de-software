@isTest
global class ServiceCalloutMock implements HttpCalloutMock {
    global HTTPResponse respond(HTTPRequest request) {
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('[{"protocol_id":"20206777400505","interaction_date":{"start_date":"2020-08-18T13:11:15Z","end_date":"2020-08-18T13:11:16Z"},"channel":{"channel_master":"1446","channel_id":"1446"},"reason":"VIVO SERVICOS","customer_information":{"customer":{"name":"name","id_document":{"country":"Brasil","type":"CPF","value":"1"}},"identifiers":"111"},"related_entities":[]}]');
        response.setStatusCode(200);
        return response;
    }
}