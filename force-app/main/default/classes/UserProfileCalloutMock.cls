@isTest
global class UserProfileCalloutMock implements HttpCalloutMock {
    global HTTPResponse respond(HTTPRequest request) {
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('[{"identities":[{"services":["authentication"],"roles":["owner"],"id":"07821923940","type":"uid"},{"services":["authentication"],"roles":["owner"],"id":"nome.sobrenome@gmail.com","type":"email"},{"services":["authentication","mobile_postpaid"],"roles":["owner"],"id":"+5541985078965","type":"phone_number"},{"services":["landline"],"roles":["owner"],"id":"+554133836820","type":"uid","group_ids":["SB899994751275"]},{"services":["landline"],"roles":["owner"],"id":"+554132829225","type":"uid","group_ids":["SB899994751275"]},{"services":["iptv"],"roles":["owner"],"id":"TV-SJP-81KU1MJ7R-050","type":"uid","group_ids":["SB899994751275"]},{"services":["internet"],"roles":["owner"],"id":"SJP-30R209NP-013","type":"uid","group_ids":["SB899994751275"]}],"id":"41985078965","name":"NOME SOBRENOME","id_document":{"value":"07821923940","country":"BR","type":"CPF"},"contact_media":[{"type":"email","value":"NOME.SOBRENOME@TELEFONICA.COM"},{"type":"phone_number","value":"+554132829225"},{"type":"phone_number","value":"+5541985078965"},{"type":"phone_number","value":"+554133836820"},{"type":"email","value":"nome.sobrenome@telefonica.com"}]}]');
        response.setStatusCode(200);
        return response;
    }
}