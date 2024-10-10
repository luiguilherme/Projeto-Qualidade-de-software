public with sharing class NotificadorPushSMS implements Queueable, Database.AllowsCallouts {

    private static final String WEBSERVICE_NAME = 'KafkaEvents';
    private String selectedCaseId;
    @TestVisible
    private static String requestBody;

    public NotificadorPushSMS(String selectedCaseId) {
        this.selectedCaseId = selectedCaseId;
    }

    public NotificadorPushSMS() {}

    public static String buildRequestBody(String selectedCaseId) {
        Case selectedCase = [SELECT Id, Account.Name, Status, AccountId, Document__c, CreatedDate, ContactPhone__c, RecordType.DeveloperName, RecordType.Name, Protocol__c 
                             FROM Case WHERE Id =: selectedCaseId];

        if (String.isBlank(selectedCase.ContactPhone__c))
            throw new MyRequestNotificationException('Caso não possui contato cadastrado');

        NotificadorPushSMS.RequestWrapper requestBody = new NotificadorPushSMS.RequestWrapper();
        UUID randomUUID = UUID.randomUUID();
        requestBody.ID_EVENT = String.valueOf(randomUUID);

        // Document of the account of the case
        requestBody.KEY = selectedCase.Document__c; 
        // Constant
        requestBody.KEY_TYPE = '2';
        // Constant that varies according to the Status of the case
        if(selectedCase.Status == 'Expirado') {
            requestBody.ID_EVENT_TYPE = '519';
        } else if(selectedCase.Status == 'Closed') {
            requestBody.ID_EVENT_TYPE = '520';
        } else if(selectedCase.Status == 'Aguardando informação') {
            requestBody.ID_EVENT_TYPE = '516';
        }
        // Case creation date
        DateTime caseDateTime = selectedCase.CreatedDate;
        String formattedDate = caseDateTime.format('dd/MM/yyyy');
        requestBody.DT_EVENT = formattedDate; 
        // Case creation DateTime
        requestBody.DTTM_EVENT = String.valueOf(selectedCase.CreatedDate.format('dd/MM/yyyy hh:mm:ss.SSS a')); 
        // Constant
        requestBody.ID_SOURCE_TYPE = '1';
        // Contact phone of the case
        requestBody.DS_EVENT_ADD1 = String.valueOf(selectedCase.ContactPhone__c).remove('+');
        // First name of the account of the case
        requestBody.DS_EVENT_ADD2 = (selectedCase.Account.Name).split(' ')[0];
        // RecordType of the case
        requestBody.DS_EVENT_ADD3 = selectedCase.RecordType.DeveloperName;
        requestBody.DS_EVENT_ADD4 = selectedCase.Id;
        requestBody.DS_EVENT_ADD5 = selectedCase.Protocol__c;

        return JSON.serialize(requestBody);
    }

    public void execute(QueueableContext context) {
        sendNotification(this.selectedCaseId);
    }

    public HttpResponse sendNotification(String selectedCaseId) {
        // Select the Custom Setting with the callout data and add the path to the endPoint
        Webservice__c wsConfig = [SELECT Id, IsDeleted, Name, SetupOwnerId, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, SystemModstamp, AccessToken__c, AltEndpoint__c, AppKey__c, Application__c, Certificate__c, CommitTransactionsList__c, Endpoint__c, ExpireIn__c, HasAuthToken__c, HasJWT__c, Headers__c, Password__c, ServiceName__c, ServiceOperation__c, ServiceProvider__c, SubscriptionKey__c, Timeout__c, User__c, Validate__c, Version__c, switchedOn__c, ServiceAccountUser__c, AsyncLogServiceTransaction__c, LogServiceTransaction__c FROM Webservice__c WHERE Name =: WEBSERVICE_NAME];
        wsConfig.Endpoint__c = wsConfig.Endpoint__c + '/SF-TICKET-UPDATE-SAS';
        wsConfig.Headers__c = wsConfig.Headers__c + ';x-4p-provider:SF-TICKET-UPDATE-SAS';

        String jsonBody = NotificadorPushSMS.buildRequestBody(selectedCaseId);
        HttpClient client = new HttpClient();
        HttpResponse response = client.post(wsConfig, jsonBody);
        requestBody = jsonBody;
        return response;
    }

    private class RequestWrapper {
        public String ID_EVENT;
        public String KEY;
        public String KEY_TYPE;
        public String ID_EVENT_TYPE;
        public String DT_EVENT;
        public String DTTM_EVENT;
        public String ID_SOURCE_TYPE;
        public String DS_EVENT_ADD1;
        public String DS_EVENT_ADD2;
        public String DS_EVENT_ADD3;
        public String DS_EVENT_ADD4;
        public String DS_EVENT_ADD5;
    }
}