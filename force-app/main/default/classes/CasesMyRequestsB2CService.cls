public with sharing class CasesMyRequestsB2CService
{
    public static void validateDuplicates(List<Case> newCases)
    {
        Set<String> newCasesSignatures = new Set<String>();
        Set<Id> accountsIds = new Set<Id>();
        Set<Id> assetsIds = new Set<Id>();
        Set<Id> topicTreeIds = new Set<Id>();

        for (Case newCase: newCases)
        {
            String newCaseSignature = CasesMyRequestsB2CService.generateCaseSignature(newCase);
            newCasesSignatures.add(newCaseSignature);
            accountsIds.add(newCase.AccountId);
            assetsIds.add(newCase.ComplainedAsset__c);
            topicTreeIds.add(newCase.CustomerInteractionTopicTree__c);
        }

        Set<String> exceptStatuses = new Set<String>{'Cancelado', 'Expirado', 'Closed'};

        List<Case> existingActiveCases = CaseDAO.getBy(accountsIds, assetsIds, topicTreeIds, exceptStatuses);
        
        for (Case existingActiveCase : existingActiveCases)
        {
            String existingActiveCaseSignature = CasesMyRequestsB2CService.generateCaseSignature(existingActiveCase);
            if (newCasesSignatures.contains(existingActiveCaseSignature))
            {
                for (Case newCase : newCases)
                {
                    String newCaseSignature = CasesMyRequestsB2CService.generateCaseSignature(newCase);
                    if (newCaseSignature == existingActiveCaseSignature)
                    {
                        newCase.addError('Existe um Caso semelhante ativo com ID: ' + existingActiveCase.Id);
                        break;
                    }
                }
            }
        }
    }

    // Método para gerar uma assinatura do caso
    private static String generateCaseSignature(Case c)
    {
        String signature = '';
        String emptyString = '';
        signature += c.AccountId != null ? (String) c.AccountId : emptyString;
        signature += c.ComplainedAsset__c != null ? (String) c.ComplainedAsset__c : emptyString;
        signature += c.CustomerInteractionTopicTree__c != null ? (String) c.CustomerInteractionTopicTree__c : emptyString;
        return signature;
    }

    public static List<Case> getNewCases(List<Case> newCases, Map<Id, Case> oldCases)
    {
        List<Case> confirmedNewCases = new List<Case>();
        for (Case caseRec : newCases)
        {
            Case oldCaseRec = oldCases.get(caseRec.Id);
            if (oldCaseRec != null) { continue; }
            confirmedNewCases.add(caseRec);
        }
        return confirmedNewCases;
    }

    public static List<Case> getCasesWithUpdatedStatus(List<Case> newCases, Map<Id,Case> oldCases)
    {
        List<Case> casesWithUpdatedStatus = new List<Case>();
        for (Case newCase : newCases)
        {
            Case oldCase = oldCases.get(newCase.Id);
            if (isSameRecord(newCase, oldCase) && isStatusChanged(newCase, oldCase))
            {
                casesWithUpdatedStatus.add(newCase);
            } 
        }
        return casesWithUpdatedStatus;
    }

    private static Boolean isStatusChanged(Case newCase, Case oldCase)
    {
        return newCase.Status != oldCase.Status;
    }

    private static Boolean isSameRecord(Case newCase, Case oldCase)
    {
        return newCase.Id == oldCase.Id;
    }
 
    public static String determineTemplateId(String status)
    {
        String templateId;
        switch on status {
            when 'Expirado' {
                templateId = 'EMAIL_MS_SOLICITACAO_EXPIRADA';
            }
            when 'New' {
                templateId = 'EMAIL_MS_SOLICITACAO_ABERTA';
            }
            when 'Aguardando informação' {
                templateId = 'EMAIL_MS_SOLICITACAO_AGUARDANDO_RESPOSTA';
            }
            when 'Closed' {
                templateId = 'EMAIL_MS_SOLICITACAO_CONCLUIDA';
            }
        }
        return templateId;
    }

    public static String getWaitingForRoutingQueueId() {
        return GroupDAO.getQueueByName('WaitingforRouting').get(0).Id;
    }

    public static boolean isCaseStatusValidForQueue(String status) {
        return status.equals('Em fila') 
            || status.equals('Aguardando informação')
            || status.equals('Escalated')
            || status.equals('Cancelamento solicitado');
    }

    public static boolean isCaseOwnerValidForQueue(Case newCaseObj, Case oldCase) {
        return newCaseObj.OwnerId == oldCase.OwnerId;
    }

    public static boolean isCaseStatusValidForRouting(String status) {
        return status.equals('Em fila') || status.equals('Cancelamento solicitado');
    }

    public static void changeCaseOwner(Case caseObj, String  queueId) {
        caseObj.OwnerId = queueId;
    }

    public static void putTheCaseInTheRouting(Case caseObj, String  queueId) {
        caseObj.Status = 'Em fila';
    }

    public static Boolean theCaseHasAlreadyBeenHandledByAnAgent(CaseDetail__c caseDetailRec) {
        return caseDetailRec?.LastSourceSystemAgent__c != null;
    }
}