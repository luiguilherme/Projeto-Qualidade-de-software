public with sharing class DisputedInvoiceDAO {

    public static DisputedInvoice__c findByCaseId(String caseId) {

        return [ 
        SELECT
            Id,
            Name,
            Status__c,
            invoiceNumber__c,
            case__r.AccountId,
            billNo__c,
            billOrigin__c,
            imageNo__c,
            l9CycleCloseDate__c,
            l9CycleStartDate__c, 
            amount__c,
            FinancialAccountId__c,
            BillingAccountId__c,
            Balance__c,
            adjustedPaymentAmount__c,
            AccountHref__c
            from DisputedInvoice__c
        where case__c =: caseId
        Limit 1];
    }
}