/*
* @author Diego Costa @ Deloitte
* @date 06/06/2022
* @description - classe OAMMock que implementa a interface HttpCalloutMock
*/
@isTest
global class OAMMock implements HttpCalloutMock {
    
    global HTTPResponse respond(HTTPRequest req) {
        
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{"access_token":"accessTokenTest", "expires_in": 3600, "token_type":"Bearer"}');
        res.setStatusCode(200);
        return res;
        
    }
}