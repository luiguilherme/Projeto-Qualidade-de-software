public with sharing class PIDTokenValidateController {

    @AuraEnabled(cacheable=true)
    public static PIDTokenValidateDTO getCustomerIntAPX(String aRecordId) {
        return PIDTokenValidateService.getCustomerIntAPX(aRecordId);
    }

    @AuraEnabled
    public static void updateTokenStatus(String customerIntId, String tokenStatus) {
        PIDTokenValidateService.updateTokenStatus(customerIntId, tokenStatus);
    }

    @AuraEnabled
    public static vlocity_cmt__CustomerInteraction__c sendToken(String customerIntId, String phoneNumber) {
        return PIDTokenValidateService.sendToken(customerIntId, phoneNumber);
    }
}