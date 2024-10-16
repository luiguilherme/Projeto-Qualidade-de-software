public with sharing class CustomerInteractionTopicDAO {
    public static vlocity_cmt__CustomerInteractionTopic__c getByCaseId(Id caseId) {
        return [
            SELECT
                Id,
                vlocity_cmt__CustomerInteractionId__c
            FROM
                vlocity_cmt__CustomerInteractionTopic__c
            WHERE
                vlocity_cmt__CaseId__c =: caseId
        ];
    }

    public static List<vlocity_cmt__CustomerInteractionTopic__c> getByIdWithoutCaseId(Set<Id> interactionTopicIds) {
        return [
            SELECT
                Id,
                vlocity_cmt__CustomerInteractionId__c
            FROM
                vlocity_cmt__CustomerInteractionTopic__c
            WHERE
                Id IN :interactionTopicIds AND 
                vlocity_cmt__CaseId__c = NULL
        ];
    }
}