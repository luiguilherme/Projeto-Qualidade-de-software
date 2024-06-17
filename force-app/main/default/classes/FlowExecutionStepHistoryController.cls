public class FlowExecutionStepHistoryController {
    @AuraEnabled(cacheable=false)
    public static List<FlowExecutionStepHistory__c> getByCaseId(Id caseId) {
        return [
            select
            Id,
            Name,
            CreatedBy.Name,
            (select
                Id,
                Name__c,
                Answer__c,
                AdditionalInformation__c,
                Type__c
                from FlowExecutionStepHistories__r
                order by CreatedDate)
            from FlowExecutionStepHistory__c where CaseId__c =: caseId
            WITH SECURITY_ENFORCED
            order by CreatedDate
        ];
    }
}