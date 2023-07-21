public with sharing class CanvasHybrisOrderService extends CanvasHybrisServices {
    protected override Asset query(Id recordId){
        return [SELECT  
                    account.Id, 
                    account.Name, 
                    account.DocumentNumber__c,  
                    account.vlocity_cmt__CreditScore__c,
                    account.vlocity_cmt__PrimaryContactId__r.MotherName__c, 
                    account.vlocity_cmt__PrimaryContactId__r.Email,
                    account.vlocity_cmt__PrimaryContactId__r.MobilePhone,
                    account.vlocity_cmt__PrimaryContactId__r.Birthdate,
                    vlocity_cmt__BillingAccountId__r.BillingPostalCode,
                    vlocity_cmt__BillingAccountId__r.BillingNumber__c,
                    vlocity_cmt__BillingAccountId__r.FullComplement__c
                FROM    
                    Asset 
                WHERE   
                    Id = :recordId
                LIMIT   1];
        
    }
}