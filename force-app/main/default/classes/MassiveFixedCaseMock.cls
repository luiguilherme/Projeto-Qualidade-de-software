@isTest
global class MassiveFixedCaseMock implements HttpCalloutMock {
    global HTTPResponse respond(HTTPRequest request) {
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('[ { "Problem": { "problemId": "1760545", "description": "UPGRADE DE TIMOS E ADEQUAÇÃO DE PLACAS - MBH", "categoryLevel1": "hl4" }, "NetworkProblem": { "openDate": "2019-06-27T09:15:00Z", "closeDate": "2019-06-27T09:17:00Z", "previsionDate": "2019-06-27T13:15:00Z", "resourcesAffected": [ "TV" ], "problemHasAffectedLocation": [ { "city": "Curitiba", "stateOfProvince": "PR" } ] }, "CharacteristicSpecValue": [ { "type": "EPG", "value": "Tela Branca - Erro 401" } ], "ITSystem": { "name": "SIGITM" } } ]');
        response.setStatusCode(200);
        return response;
    }
}