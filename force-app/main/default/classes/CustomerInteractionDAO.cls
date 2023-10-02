public class CustomerInteractionDAO {
    public static vlocity_cmt__CustomerInteraction__c getCustomerInteractionById(String customerInteractionId) {
        return [
            SELECT
            	Id,
				vlocity_cmt__AccountId__c,
				vlocity_cmt__Channel__c,
				vlocity_cmt__Comments__c,
				vlocity_cmt__ConsoleCardLayout__c,
				vlocity_cmt__ContactId__c,
				Name,
				CallerDDD__c,
				vlocity_cmt__DurationInMinute__c,
				vlocity_cmt__EndDateTime__c,
				ExternalId__c,	
				IdentifierNumber__c,
				Subject__c,
				InteractionNumberInternal__c,
				Origin__c,
				InteractionNumber__c,
				vlocity_cmt__StartDateTime__c,
				vlocity_cmt__Status__c,
				CallerPhone__c,
				vlocity_cmt__Type__c,
				vlocity_cmt__VerificationTimestamp__c,
				vlocity_cmt__Verified__c,
				vlocity_cmt__VerifiedAgentName__c,
				TokenStatus__c,
				TokenSendAttempts__c,
				TokenFirstDateSend__c,
				TokenSendNumber__c
            FROM
            	vlocity_cmt__CustomerInteraction__c
            WHERE
            	Id =: customerInteractionId
            LIMIT 1
        ];
    }
    
    public static String getAccountIdById(String customerInteractionId) {
        return [SELECT Id, vlocity_cmt__AccountId__c FROM vlocity_cmt__CustomerInteraction__c WHERE Id =: customerInteractionId LIMIT 1].vlocity_cmt__AccountId__c;
    }
    
    public static String getIdentifierNumberById(String customerInteractionId) {
        return [SELECT Id, IdentifierNumber__c FROM vlocity_cmt__CustomerInteraction__c WHERE Id =: customerInteractionId LIMIT 1].IdentifierNumber__c;
    }

}