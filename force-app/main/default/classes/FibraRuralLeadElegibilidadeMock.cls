@isTest
global class FibraRuralLeadElegibilidadeMock implements HttpCalloutMock{
	    
    
    global HTTPResponse respond(HTTPRequest req) {
        
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{"Body": "Test"}');
        res.setStatusCode(200);
        
        return res;
        
    }
    
    
}