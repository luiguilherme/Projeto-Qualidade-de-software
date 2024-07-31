global with sharing class CaseManagementUpdateCase {
    public static final List<String> ACCEPTED_STATUS = new List<String> {'Cancelamento solicitado', 'Closed'};
    global static void updateCase(){
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;

        try {
            String headerXAuth = RestContext.request.headers.get('x-Authorization');
            res.addHeader('Content-Type', 'application/json');
            //Retorna forbidden caso o authorization no header esteja vazio.
            if(String.isBlank(headerXAuth)){
                CaseManagement.handleException(res, 'INVALID_X_AUTH_TOKEN', 'Forbidden', 403);
                return;
            }

            String[] jwtParts = headerXAuth.split(' ');
            String authorizationHeaderValue = jwtParts[1];
            //Retorna forbidden caso o Jwt não seja válido.
            if(!JWTUtility.isValidJwt(authorizationHeaderValue)) {
                CaseManagement.handleException(res, 'INVALID_X_AUTH_TOKEN', 'Forbidden', 403);
                return;
            }

            //Tenta selecionar o Id do caso do último parâmetro da url.
            List<String> urlParts = RestContext.request.requestURI.split('/');
            String urlLastPart = urlParts[urlParts.size() - 1];
            String receivedCaseId = urlLastPart;

            //Seleciona o CPF do caso para a validação do UUID.
            String UUID = JWTUtility.getJWTBody(authorizationHeaderValue).sub;
            Case selectedCase = [SELECT Id, Status, StatusOmniChannel__c, Account.DocumentNumber__c FROM Case WHERE Id =: receivedCaseId];
            String CPF = selectedCase.Account.DocumentNumber__c;
            UUIDService service = new UUIDService(UUID, CPF);
            //Retorna forbidden caso o UUID não seja válido.
            if(!service.uuIDIsValid()) {
                CaseManagement.handleException(res, 'INVALID_X_AUTH_TOKEN', 'Forbidden', 403);
                return;
            }

            //Conversão do body recebido no request na classe UpdateCaseRequestWrapper.requestWrapper.
            Blob requestBody = RestContext.request.requestBody;
            String requestBodyString = requestBody.toString();
            UpdateCaseRequestWrapper.requestWrapper requestWrapper = (UpdateCaseRequestWrapper.requestWrapper)JSON.deserialize(requestBodyString, UpdateCaseRequestWrapper.requestWrapper.class);
            //Valida se o status recebido na requesição faz parte dos status permitidos nessa alteração.
            if(!ACCEPTED_STATUS.contains(requestWrapper.Status)) {
                CaseManagement.handleException(res, 'Status inválido', 'BAD_REQUEST', 400);
                return;
            }

            //Caso todas as validações tenham sido feitas e autorizadas, atualiza o status do caso.
            selectedCase.Status = requestWrapper.status;
            update selectedCase;
            selectedCase = [SELECT Id, Status, StatusOmniChannel__c, Account.DocumentNumber__c FROM Case WHERE Id =: receivedCaseId];
            //Criação da response com os dados do caso atualizado.
            UpdateCaseRequestWrapper.responseWrapper responseWrapper = new UpdateCaseRequestWrapper.responseWrapper();
            responseWrapper.status = selectedCase.status;
            responseWrapper.omniChannelStatus = selectedCase.StatusOmniChannel__c;
            res.statuscode = 200;
            res.responseBody = Blob.valueOf(JSON.serialize(responseWrapper)); 
        } catch (Exception e) {
            //Qualquer exceção que pode ocorrer durante a execução.
            CaseManagement.handleException(res, e.getMessage(), 'Exception', 500);
        }
    }
}