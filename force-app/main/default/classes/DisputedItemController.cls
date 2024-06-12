public class DisputedItemController {
    @AuraEnabled(cacheable=false)
    public static List<DisputedItem__c> getByCaseId(Id caseId) {
        return [
            select
            Id,
            Description__c,
            AvailableAmount__c,
            Status__c,
            toLabel(Status__c) statusLabel
            from DisputedItem__c 
            where CaseId__c =: caseId
        ];
    }
}