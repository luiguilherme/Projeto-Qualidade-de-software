public with sharing class CaseDetailsDAO {
    public static List<CaseDetail__c> getByCaseIds(Set<Id> caseIds){
        return [
            SELECT Id, Case__c, LastSourceSystemAgent__c, LastSourceSystemAgent__r.Login__c
            FROM CaseDetail__c
            WHERE Case__c = :caseIds
        ];
    }
}