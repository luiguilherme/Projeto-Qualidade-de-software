public with sharing class DisputedItemDAO {
    public static List<DisputedItem__c> getByCaseId(String caseId) {
    return [
    SELECT    
        Id
    FROM 
        DisputedItem__c
    WHERE 
        CaseId__c = :caseId];
    }

    
    public static List<DisputedItem__c> getDisputeLast45Days(String accountId, String description)
    {
        return[
            SELECT
                Id,
                Name,
                Code__c,
                FrontEndCode__c,
                Description__c,
                Status__c,
                ItemId__c
            FROM
                DisputedItem__c
            WHERE
                CaseId__r.AccountId =: accountId AND
                Description__c =: description AND
                Status__c != 'InAnalisys' AND
                Status__c != 'NotStarted' AND
                CreatedDate >= LAST_N_DAYS:45
        ];
    }
}