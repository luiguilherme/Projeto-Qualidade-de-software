public with sharing class CaseMyRequestsController
{
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
        String emailNotification;
        try {
            HttpResponse response = CustomerCommunicationService.sendEmailMessage(payload);
            Integer statusCode = response.getStatusCode();
            String status = response.getStatus();
            
            CustomerCommunicationService.validadeStatusCode(statusCode);
            CustomerCommunicationService.validadeStatus(status);
            
            System.debug(LoggingLevel.INFO, 'Envio de email.');
            System.debug(LoggingLevel.INFO, 'StatusCode: ' + statusCode);
            System.debug(LoggingLevel.INFO, 'Status: ' + status);
            
            if (status == 'OK') { emailNotification = 'SUCCESS'; }
        } catch (CustomerCommunicationException e) {   
            String errorMessage  = e.getMessage();
            System.debug(LoggingLevel.ERROR, errorMessage);
            throw new AuraException(errorMessage);
        }
        return emailNotification;
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