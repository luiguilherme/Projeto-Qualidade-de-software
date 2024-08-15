public with sharing class DisputedInvoiceController {
    @AuraEnabled(cacheable=false)
    public static DisputedInvoice__c findByCaseId(Id caseId) {
        System.debug(DisputedInvoiceDAO.findByCaseId(caseId));
        return DisputedInvoiceDAO.findByCaseId(caseId);
    }
}