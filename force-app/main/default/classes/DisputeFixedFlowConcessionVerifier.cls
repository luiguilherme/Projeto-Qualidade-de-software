public with sharing class DisputeFixedFlowConcessionVerifier {

    public class DisputeCheckConcessionInLast180Days {
        @InvocableVariable
        public String caseAccountId;

        @InvocableVariable
        public String caseId;
    }
    
    @InvocableMethod(label='Cliente possui concessão nos últimos 180 dias?')
    public static List<String> customerHasConcessionInLast180Days(List<DisputeCheckConcessionInLast180Days> parameters) {
        Id caseAccountId = parameters.get(0).caseAccountId;
        Id caseId = parameters.get(0).caseId;
        
        List<String> results = new List<String>();
        
        List<DisputedItem__c> disputedItems = [
            SELECT
        		Id,
				Name,
				Status__c,
				IsConcession__c
			FROM
                DisputedItem__c
            WHERE
                CaseId__r.AccountId =: caseAccountId AND
                Status__c != 'InAnalisys' AND
                Status__c != 'NotStarted' AND
                IsConcession__c = True AND
                CreatedDate >= LAST_N_DAYS:180 AND
                CaseId__c != :caseId
		];
        
        results.add(disputedItems.size() > 0 ? 'Sim' : 'Não');
        return results;
    }
    
}