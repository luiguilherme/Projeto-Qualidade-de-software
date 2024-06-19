public with sharing class FlowExecutionStepHistoryDAO {

    public static List<FlowExecutionStepHistory__c> getByCaseId(String caseId) {
        return [
        SELECT    
            Id
        FROM 
            FlowExecutionStepHistory__c
        WHERE 
            CaseId__c = :caseId];
        
    }
    
}