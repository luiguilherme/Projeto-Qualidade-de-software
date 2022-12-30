public with sharing class APIGatewayRequestConfigurator implements IHttpRequestConfigurator{
    public HttpRequest configure(HttpRequest request, Webservice__c wsConfig){
        request.setHeader('Content-Type',   		'application/json');
       request.setHeader('application',            String.isNotBlank(wsConfig.Application__c) ? wsConfig.Application__c : 'Salesforce');
       request.setHeader('idMessage',              generateUUID());
       request.setHeader('transactionTimestamp',   datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.SSS\'Z\''));
       
       List<User> users = UserDAO.getUserInfo();
       request.setHeader('userLogin',              String.isNotBlank(users[0].Login__c) ? users[0].Login__c : 'Salesforce');
       
       return request;
   }

   private String generateUUID(){
       Blob b = Crypto.GenerateAESKey(128);
       String tmp = EncodingUtil.ConvertTohex(b);
       String uuid =   tmp.SubString(0, 8)     + '-' +
                       tmp.SubString(8, 12)    + '-' +
                       tmp.SubString(12, 16)   + '-' +
                       tmp.SubString(16, 20)   + '-' +
                       tmp.SubString(20);

       return uuid;
   }
   
}