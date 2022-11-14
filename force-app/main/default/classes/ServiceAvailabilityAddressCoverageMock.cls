@isTest
global class ServiceAvailabilityAddressCoverageMock implements HttpCalloutMock {
    global HTTPResponse respond(HTTPRequest request) {
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('{"physicalResourceAvailability":{"brazilianUrbanPropertyAddress":{"id":"SAGRE:46566","city":"CURITIBA","streetCode":"46566","streetNrFirst":"178","stateOrProvince":"PR","cnl":"41000","networkOwner":"VIVO2","placePhysicalResourceAssoc":{"physicalLink":{"accessTechnology":"GPON","voiceProtocol":"SIP"}}},"cabinet":{"name":"PRCTA_O1D41","id":"O1D41","distance":"0.0","switchesAssociated":{"name":"PRCTA_VMS02"},"terminalBox":{"id":"D41G0008","available":"15"},"technology":[{"name":"GPON","available":"15","maxBroadbandSpeed":"1024000"},{"name":"IPTV","tvPlatform":"OPEN_PLATFORM"}]}}}');
        response.setStatusCode(200);
        return response;
    }
}