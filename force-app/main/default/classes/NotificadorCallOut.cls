public with sharing class NotificadorCallOut implements Queueable, Database.AllowsCallouts {

    private static final String WEBSERVICE_NAME = 'KafkaEvents';
    private String selectedCaseId;
    private GATILHO_DISPARO_NOTIFICACAO triggerType;
    @TestVisible
    private static String requestBody;
    private static final String CALLOUT_ACTION_URL = 'AppVivoCalloutActionUrl';
    public static final List<String> listMascRecordTypes = new List<String>{
        'ProblemWithPortability'

    };

    public static final List<String> listFemRecordTypes = new List<String>{
        'Helpwithbilling',
        'ChangeOfAddress',
        'HelpWithTheOrder'
    };

    public NotificadorCallOut(String selectedCaseId, GATILHO_DISPARO_NOTIFICACAO triggerType) {
        this.selectedCaseId = selectedCaseId;
        this.triggerType = triggerType;
    }

    public NotificadorCallOut(GATILHO_DISPARO_NOTIFICACAO triggerType) {
        this.triggerType = triggerType;
    }

    public String buildRequestBody(String selectedCaseId) {
        Case selectedCase = [SELECT Id, Status, AccountId, Account.Name, Document__c, CreatedDate, ContactPhone__c, RecordType.DeveloperName, RecordType.Name, Protocol__c 
                             FROM Case WHERE Id =: selectedCaseId];
        
        if (String.isBlank(selectedCase.ContactPhone__c))
            throw new MyRequestNotificationException('Caso não possui contato cadastrado');
        
        NotificadorCallOut.RequestWrapper requestBody = new NotificadorCallOut.RequestWrapper();
        // Try to find the user profile of the account associated with this case
        List<UserProfileTO> listUserProfiles = UserProfileService.getUserProfileByAccountId(selectedCase.AccountId);
        requestBody.user_id = listUserProfiles[0].id;

        String accountFirstName = selectedCase.Account.Name.split(' ')[0];
        String recordTypeDevName = String.valueOf(selectedCase.RecordType.DeveloperName);
        String recordTypeName = String.valueOf(selectedCase.RecordType.Name);

        // Title, description, and button name of the callout, which will be defined according to the Status and type of case
        String calloutDescription;
        String calloutTitle;
        String actionName;

        if(this.triggerType == GATILHO_DISPARO_NOTIFICACAO.STATUS_CASO) {
            if(selectedCase.Status == 'Aguardando Informação') {
                calloutTitle = 'Estamos esperando seu retorno';
                actionName = 'Responder';
    
                if(listFemRecordTypes.contains(recordTypeDevName)) {
                    calloutDescription = buildMessageTypeOne(accountFirstName, recordTypeName, 'fem');
                } else if(listMascRecordTypes.contains(recordTypeDevName)) {
                    calloutDescription = buildMessageTypeOne(accountFirstName, recordTypeName, 'masc'); 
                }
            } else if(selectedCase.Status == 'Closed') {
                calloutTitle = 'Sua solicitação foi concluída';
                actionName = 'Acessar';
    
                if(listFemRecordTypes.contains(recordTypeDevName)) {
                    calloutDescription = buildMessageTypeTwo(accountFirstName, recordTypeName, 'fem');
                } else if(listMascRecordTypes.contains(recordTypeDevName)) {
                    calloutDescription = buildMessageTypeTwo(accountFirstName, recordTypeName, 'masc');
                }
            }
        } else if(this.triggerType == GATILHO_DISPARO_NOTIFICACAO.BOTAO_NOTIFICAR_CLIENTE) {
            calloutTitle = 'Sua solicitação foi atualizada';
            actionName = 'Acessar';

            if(listFemRecordTypes.contains(recordTypeDevName)) {
                calloutDescription = buildMessageTypeOne(accountFirstName, recordTypeName, 'fem');
            } else if(listMascRecordTypes.contains(recordTypeDevName)) {
                calloutDescription = buildMessageTypeOne(accountFirstName, recordTypeName, 'masc');  
            }
        }

        requestBody.name = calloutTitle;
        requestBody.description = calloutDescription;
        requestBody.status = recordTypeDevName;
        requestBody.type = 'ticket_update';
        requestBody.view = 'true';
        DateTime caseDateTime = selectedCase.CreatedDate;
        String formattedDate = caseDateTime.format('yyyy-MM-dd\'T\'HH:mm:ss.SSSSSS\'Z\'');
        requestBody.creation_date = formattedDate;         
        // List of identifiers for the request (initially only passing the contact phone of the case)
        requestBody.identifiers = new List<String>();
        requestBody.identifiers.add(String.valueOf(selectedCase.ContactPhone__c));
        // List of actions for the request: actionName is the button name and the url is the redirection url
        requestBody.actions = new List<NotificadorCallOut.Actions>();
        NotificadorCallOut.Actions newAction = new NotificadorCallOut.Actions();
        newAction.name = actionName;
        newAction.type = 'url';
        newAction.url = getRedirectUrl(CALLOUT_ACTION_URL);
        newAction.main_action = true;
        requestBody.actions.add(newAction);

        return JSON.serialize(requestBody);
    }

    public void execute(QueueableContext context) {
        sendNotification(this.selectedCaseId);
    }

    public HttpResponse sendNotification(String selectedCaseId) {
        // Select the Custom Setting with the callout data and add the path to the endPoint
        Webservice__c wsConfig = [SELECT Id, IsDeleted, Name, SetupOwnerId, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, SystemModstamp, AccessToken__c, AltEndpoint__c, AppKey__c, Application__c, Certificate__c, CommitTransactionsList__c, Endpoint__c, ExpireIn__c, HasAuthToken__c, HasJWT__c, Headers__c, Password__c, ServiceName__c, ServiceOperation__c, ServiceProvider__c, SubscriptionKey__c, Timeout__c, User__c, Validate__c, Version__c, switchedOn__c, ServiceAccountUser__c, AsyncLogServiceTransaction__c, LogServiceTransaction__c FROM Webservice__c WHERE Name =: WEBSERVICE_NAME];
        wsConfig.Endpoint__c = wsConfig.Endpoint__c + '/SF-TICKET-UPDATE';
        wsConfig.Headers__c = wsConfig.Headers__c + ';x-4p-provider:SF-TICKET-UPDATE';

        String jsonBody = buildRequestBody(selectedCaseId);
        HttpClient client = new HttpClient();
        HttpResponse response = client.post(wsConfig, jsonBody);
        requestBody = jsonBody;
        return response;
    }

    public static String buildMessageTypeOne(String accountFirstName, String recordTypeName, String gender) {
        if(gender == 'masc') {
            return accountFirstName + ', você tem uma nova mensagem para seu ' + recordTypeName.toLowerCase(); 
        } else if(gender == 'fem') {
            return accountFirstName + ', você tem uma nova mensagem para sua ' + recordTypeName.toLowerCase(); 
        }

        return null;
    }

    
    public static String buildMessageTypeTwo(String accountFirstName, String recordTypeName, String gender) {
        if(gender == 'masc') {
            return accountFirstName + ', seu ' + recordTypeName.toLowerCase() + ' foi resolvido'; 
        } else if(gender == 'fem') {
            return accountFirstName + ', sua ' + recordTypeName.toLowerCase() + ' foi resolvida'; 
        }

        return null;
    }

    private String getRedirectUrl(String instanceName) {
        return MyRequests__c.getInstance(instanceName)?.AppVivoRedirectURL__c;
    }

    public class RequestWrapper {
        public String user_id;
        public String name;
        public String description;
        public String status;
        public String type;
        public String view;
        public String creation_date;
        public List<String> identifiers;
        public List<Actions> actions;
    }

    public class Actions {
        public String name;
        public String type;
        public String url;
        public Boolean main_action;
    }
}