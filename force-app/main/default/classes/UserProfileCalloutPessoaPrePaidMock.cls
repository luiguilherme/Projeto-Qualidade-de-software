global with sharing class UserProfileCalloutPessoaPrePaidMock implements HttpCalloutMock{
    String responseBody;
     
    private UserProfileCalloutPessoaPrePaidMock(){}
   
    public UserProfileCalloutPessoaPrePaidMock(String caseId){
     this.responseBody ='[{"identities":[{"services":["authentication"],"roles":["owner"],"id":"63542141747","type":"uid"},{"services":["authentication"],"roles":["owner"],"id":"63542141747@gmail.com","type":"email"},{"services":["mobile_prepaid","authentication"],"roles":["owner"],"id":"+5511943985782","type":"phone_number"}],"id":"4dbdd9d3-78db-4189-9156-25b9073cb1ae","name":"ARTHUR HENRIQUE ESPINHEIRA","id_document":{"value":"'+caseId+'","country":"BR","type":"CPF"}}]';
    }
    
    
    global HTTPResponse respond(HTTPRequest request) {  
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody(this.responseBody);
        response.setStatusCode(200);
        return response;    
    }
}