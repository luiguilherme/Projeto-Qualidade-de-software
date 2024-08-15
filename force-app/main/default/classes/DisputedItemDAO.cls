public with sharing class DisputedItemDAO {
    public static List<DisputedItem__c> getByCaseId(String caseId) {
    return [
    SELECT    
        Id,
        Name,
        Status__c,
        toLabel(Status__c) statusLabel,
        ServiceDefinitionId__c,
        ServiceDefinitionId__r.AttendantMessage__c,
        ServiceDefinitionId__r.StepCode__c,
        ItemId__c,
        Description__c,
        TotalAmount__c,
        Discounts__c,
        AvailableAmount__c,
        CspOperatorName__c,
        Csp__c,
        FrontEndCode__c,
        StartTime__c,
        BillingStartDate__c,
        BillingEndDate__c,
        Code__c,
        SubscriberId__c,
        NameFull__c
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