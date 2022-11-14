public with sharing class MassiveBillingAccountCaseController {
    
    @AuraEnabled
    public static AccountRetentionTO.BillingAccount getAccountRetentionFixed(Id accountId){
        return MassiveBillingAccountCaseService.getAccountRetentionFixed(getAccountIdFromCustomerInteraction(accountId));
    }

    @AuraEnabled
    public static Map<String, Object> getMassiveFixed(String assetInstance){
        return MassiveBillingAccountCaseService.getMassiveFixed(assetInstance);
    }

    @AuraEnabled
    public static Map<String, Object> getMassiveSuspicion(String assetInstance) {
        return MassiveBillingAccountCaseService.getMassiveSuspicion(assetInstance);
    }
    
	private static Id getAccountIdFromCustomerInteraction(Id recordId) {
        List<vlocity_cmt__CustomerInteraction__c> customerInteraction = [SELECT vlocity_cmt__AccountId__c FROM vlocity_cmt__CustomerInteraction__c WHERE Id =: recordId LIMIT 1];        
        return customerInteraction.isEmpty() ? null : customerInteraction[0].vlocity_cmt__AccountId__c;        
    }    
}