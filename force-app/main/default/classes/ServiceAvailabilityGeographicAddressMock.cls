@isTest
global class ServiceAvailabilityGeographicAddressMock implements HttpCalloutMock {
    global HTTPResponse respond(HTTPRequest request) {
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('{"brazilianUrbanPropertyAddress":{"id":"LM:04742060:::70:::::::-46.6994095:-23.6526134:100:20210412162830","freeText":"70, RUA TAUARI, SANTO AMARO, SAO PAULO - SP","country":"BR","city":"SAO PAULO","stateOrProvince":"SP","locality":"SANTO AMARO","postcode":"04742060","streetType":"RUA","streetName":"TAUARI","streetNrFirst":"70","complementSummary":{"complement":null},"geographicLocation":{"geoJson":{"type":"Point","coordinates":["-46.69941","-23.652613"]}},"systemOriginator":"LM","database":"04742060"}}');
        response.setStatusCode(200);
        return response;
    }
}