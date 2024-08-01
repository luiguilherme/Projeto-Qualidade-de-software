public with sharing class CaseCommentTriggerHandler {
    private List<CaseComment__c> newCaseComments;
    private Map<Id, CaseComment__c> oldCaseComments;

    public CaseCommentTriggerHandler(List<CaseComment__c> newCaseComments, Map<Id, CaseComment__c> oldCaseComments) {
        this.newCaseComments = newCaseComments ?? new List<CaseComment__c>();
        this.oldCaseComments = oldCaseComments ?? new Map<Id, CaseComment__c>();
    }

    public void isAfterInsert() {
        updateParentCases();
    }

    private void updateParentCases() {
        Set<Id> parentCaseIds = new Set<Id>();

        for (CaseComment__c caseCommentObj : this.newCaseComments) {
            if (caseCommentObj.Origin__c == 'App Vivo') {
                parentCaseIds.add(caseCommentObj.ParentId__c);
            }
        }

        if (parentCaseIds.isEmpty()) { return; }

        List<Case> parentCases = CaseDAO.get(parentCaseIds);
        List<Case> parentCasesToUpdate = new List<Case>();
        String waitingforRoutingQueueId = CasesMyRequestsB2CService.getWaitingForRoutingQueueId();
        
        for (Case parentCaseObj : parentCases) {
            if (parentCaseObj.Status == 'Aguardando informação') {
                CasesMyRequestsB2CService.changeCaseOwner(parentCaseObj, waitingforRoutingQueueId);
                CasesMyRequestsB2CService.putTheCaseInTheRouting(parentCaseObj, waitingforRoutingQueueId);
                parentCasesToUpdate.add(parentCaseObj);
            }
        }

        update parentCasesToUpdate;
    }
}