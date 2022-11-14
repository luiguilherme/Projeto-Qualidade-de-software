@isTest
global class ServiceAvailabilityAddressValidateMock implements HttpCalloutMock {
    global HTTPResponse respond(HTTPRequest request) {
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('{"validationResult":"SUCCESS","alternateGeographicAddress":[{"country":"BR","city":"CURITIBA","stateOrProvince":"PR","streetType":"RUA","streetName":"FAXINAL","streetNrFirst":"178","complementSummary":{"complement":[]},"geographicLocation":{"geoJson":{"type":"Point","coordinates":["-49.375324","-25.454735"]}},"systemOriginator":"SAGRE","database":"PR_CURITIBA","streetCode":"46566","cnl":"41000","networkOwner":"VIVO2","aliasedGeographicAddress":[{"id":"SAGRE:PR_CURITIBA:41000:46566:178:::::::-49.3753233:-25.4547347:200:20210414013812","country":"BR","city":"CURITIBA","stateOrProvince":"PR","streetType":"RUA","streetName":"FAXINAL","streetNrFirst":"178","complementSummary":{"complement":[]},"geographicLocation":{"uncertain":"53.8","geoJson":{"type":"Point","coordinates":["-49.375324","-25.454735"]}},"systemOriginator":"SAGRE","database":"PR_CURITIBA","streetCode":"46566","cnl":"41000","networkOwner":"VIVO2"}]}],"state":"DONE"}');
        response.setStatusCode(200);
        return response;
    }
}