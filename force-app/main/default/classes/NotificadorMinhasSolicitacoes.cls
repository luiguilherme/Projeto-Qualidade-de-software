public with sharing class NotificadorMinhasSolicitacoes {

    @TestVisible
    private static CanalNotificacoesMinhasSolicitacoes canalSelector;
    static {
        canalSelector = new CanalNotificacoesMinhasSolicitacoes();
    }

    public static final List<String> listCasesMinhasSolicitacoes = new List<String>{
        'Helpwithbilling',
        'ChangeOfAddress',
        'HelpWithTheOrder',
        'ProblemWithPortability',
        'HelpWithInvoicingorBilling',
        'InvoiceorRechargeCollection'
    };

    public static List<Id> getRecordTypeIds(List<String> listRecordTypeNames) {
        List<RecordType> listRecordType = [SELECT Id FROM RecordType WHERE DeveloperName IN :listRecordTypeNames];
        List<Id> listRecordTypeIds = new List<Id>();
        for(RecordType recordType : listRecordType) {
            listRecordTypeIds.add(recordType.Id);
        }

        return listRecordTypeIds;
    }

    public static List<Case> filterCasesWithUpdatedStatus(List<Case> newCases, Map<Id,Case> oldCases) {
        //Recebe os casos antes e depois do update, e retorna uma lista com os casos que tiveram seu status alterado.
        List<Case> casesWithAlteredStatus = new List<Case>();
    
        for (Case updatedCase: newCases) {
            Case oldCase = oldCases.get(updatedCase.Id);
            
            if (updatedCase.Status != oldCase.Status) {
                casesWithAlteredStatus.add(updatedCase);
            }
        }

        return casesWithAlteredStatus;
    }

    public static List<Case> filterCasesMyRequests(List<Case> casesToFilter) {
        List<Id> listRecordTypeIds = getRecordTypeIds(listCasesMinhasSolicitacoes);
        List<Case> filteredCases = new List<Case>();
        
        for(Case caseToFilter: casesToFilter) {
            if(isMinhasSolicitacoes(caseToFilter, listRecordTypeIds)) {
                filteredCases.add(caseToFilter);
            }
        }

        return filteredCases;
    }

    public static void handleNotifications(List<Case> listCases, Map<Id,Case> oldCases) {
        if(oldCases != null) {
            listCases = filterCasesWithUpdatedStatus(listCases, oldCases);
        }
        listCases = filterCasesMyRequests(listCases);
        
        List<CanalNotificacoesMinhasSolicitacoes__mdt> listMetadata = canalSelector.getMetadataByFuncionalidadeControlada('AtualizacaoStatusCaso');

        //Para cada caso recebido, procura o metadado que corresponde ao status desse caso, caso encontrado, envia os chamados das APIs conforme o metadado indica.
        for(Case objectCase: listCases) { 
            CanalNotificacoesMinhasSolicitacoes__mdt caseMetadata = findCaseMetadata(objectCase, listMetadata);
            if(caseMetadata != null) {
                if(caseMetadata.CallOut__c) {
                    NotificadorCallOut calloutJob = new NotificadorCallOut(String.valueOf(objectCase.Id), GATILHO_DISPARO_NOTIFICACAO.STATUS_CASO);
                    System.enqueueJob(calloutJob);
                }
                if(caseMetadata.PushSMS__c) {
                    NotificadorPushSMS pushSMSJob = new NotificadorPushSMS(String.valueOf(objectCase.Id));
                    System.enqueueJob(pushSMSJob);
                }
            }
        }
    }

    public static Boolean isMinhasSolicitacoes(Case caseToCheck, List<Id> listRecordTypeIds) {
        return listRecordTypeIds.contains(caseToCheck.RecordTypeId);
    }

    public static CanalNotificacoesMinhasSolicitacoes__mdt findCaseMetadata(Case caseToCheck, List<CanalNotificacoesMinhasSolicitacoes__mdt> metadatasToCheck) {
        CanalNotificacoesMinhasSolicitacoes__mdt selectedMetadata;
        for(CanalNotificacoesMinhasSolicitacoes__mdt metadata: metadatasToCheck) {
            if(metadata.MasterLabel == caseToCheck.Status) {
                selectedMetadata = metadata;
                break;
            }
        }

        return selectedMetadata;
    }
}