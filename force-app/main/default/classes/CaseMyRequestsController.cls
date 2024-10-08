public with sharing class CaseMyRequestsController
{

    @TestVisible
    private static NotificadorCallOut notificadorCallOut;

    @TestVisible
    private static NotificadorPushSMS notificadorPushSms;

    @TestVisible 
    private static CanalNotificacoesMinhasSolicitacoes canalNotificacoes;
    
    static {
        notificadorCallOut = new NotificadorCallOut(GATILHO_DISPARO_NOTIFICACAO.BOTAO_NOTIFICAR_CLIENTE);
        notificadorPushSms = new NotificadorPushSMS();
        canalNotificacoes = new CanalNotificacoesMinhasSolicitacoes();
    }

    @AuraEnabled
    public static string sendCallOutNotificationWhenCaseIsManuallyUpdated(String caseId){
        List<CanalNotificacoesMinhasSolicitacoes__mdt>  canalNotificacoesMetadata = 
            canalNotificacoes.getMetadataByFuncionalidadeControlada('BotaoNotificarCliente');
        CanalNotificacoesMinhasSolicitacoes__mdt metadata = canalNotificacoesMetadata.get(0);
        
        if (!metadata.CallOut__c) { return ''; }

        HttpResponse response = notificadorCallOut.sendNotification(caseId);
        Integer statusCode = response.getStatusCode();
        String status = response.getStatus();

        System.debug(LoggingLevel.INFO, 'Envio de callout.');
        System.debug(LoggingLevel.INFO, 'StatusCode: ' + statusCode);
        System.debug(LoggingLevel.INFO, 'Status: ' + status);
        if (statusCode == 201) { return 'SUCCESS'; }
        throw new AuraHandledException(status);
    }

    @AuraEnabled
    public static string sendPushSmsNotificationWhenCaseIsManuallyUpdated(String caseId) {
            List<CanalNotificacoesMinhasSolicitacoes__mdt>  canalNotificacoesMetadata =
                canalNotificacoes.getMetadataByFuncionalidadeControlada('BotaoNotificarCliente');
            CanalNotificacoesMinhasSolicitacoes__mdt metadata = canalNotificacoesMetadata.get(0);
            
            if (!metadata.PushSMS__c ) { return ''; }

            HttpResponse response = notificadorPushSms.sendNotification(caseId);
            Integer statusCode = response.getStatusCode();
            String status = response.getStatus();

            System.debug(LoggingLevel.INFO, 'Envio de push/sms.');
            System.debug(LoggingLevel.INFO, 'StatusCode: ' + statusCode);
            System.debug(LoggingLevel.INFO, 'Status: ' + status);
            if (statusCode == 201) { return 'SUCCESS'; }
            throw new AuraHandledException(status);
    }

    @AuraEnabled
    public static String sendEmailNotificationWhenCaseStatusUpdatedManually(String caseId) {
        String templateId = 'EMAIL_MS_SOLICITACAO_ATUALIZADA';
        Case caseRec = CaseDAO.getCasebyId(caseId);

        String accountId = caseRec.AccountId;
        String assetId = caseRec.ComplainedAsset__c;

        Account accountRec = AccountDAO.getByIds(accountId);
        Asset assetRec = AssetDAO.getAssetById(assetId) ?? null;
        Contact contactRec =  ContactDAO.getBy(accountRec?.DocumentNumber__c);

        hasDependencies(caseRec, accountRec, assetRec, contactRec);
            
        EmailMessagePayload payload = CustomerCommunicationService.buildEmailPaylod(caseRec, accountRec, assetRec, contactRec, templateId);
        CustomerCommunicationService.validadePayload(payload);

        HttpResponse response = CustomerCommunicationService.sendEmailMessage(payload);
        Integer statusCode = response.getStatusCode();
        String status = response.getStatus();
        
        System.debug(LoggingLevel.INFO, 'Envio de email.');
        System.debug(LoggingLevel.INFO, 'StatusCode: ' + statusCode);
        System.debug(LoggingLevel.INFO, 'Status: ' + status);
        
        if (statusCode == 200) { return 'SUCCESS'; }
        throw new AuraHandledException(status);
    }

    private static void hasDependencies(Case caseRec, Account accountRec, Asset assetRec, Contact contactRec) {
        if (!hasProtocol(caseRec)) { 
            throw new CaseMyRequestsException('Caso sem Protocolo.');
        }
        else if (!hasRecordDependencies(accountRec, assetRec, contactRec)) { 
            throw new CaseMyRequestsException('Caso sem Conta, Produto ou Contato vinculado.');        } 
        else if (!hasEmail(contactRec)) { 
            throw new CaseMyRequestsException('Contato sem Email vinculado.');        
        }
    }
    
    private static Boolean hasProtocol(Case caseRec) {
        return !String.isBlank(caseRec.Protocol__c);
    }

    private static Boolean hasRecordDependencies(Account accountRec, Asset assetRec, Contact contactRec) {
        return (accountRec != null && assetRec != null && contactRec != null);
    }

    private static Boolean hasEmail(Contact contactRec) {
        return !String.isBlank(contactRec.Email);
    }

    @AuraEnabled
    public static Case getCase(String caseId) {
        try {
            return CaseDAO.getCasebyId(caseId);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static String updateCaseStatus(String caseId, String status){
        try {
            Case caseObj = CaseDAO.getCasebyId(caseId);
            caseObj.Status = status;
            update caseObj;
            return 'SUCCESS';
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}