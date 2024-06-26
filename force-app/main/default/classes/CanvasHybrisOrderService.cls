public with sharing class CanvasHybrisOrderService extends CanvasHybrisServices {
    protected override List<Asset> query(List<String> listRecordId){
        return [
            SELECT  
                Id,
                Name,
                Instance__c,
                IdBundle__c,
                SourceSystem__c,
                MainProductDescription__c,
                Cabinet__c,
                Type__c,
                ProductType__c,
            	Pricecurrent__c,
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
                vlocity_cmt__BillingAccountId__r.FullComplement__c,
                vlocity_cmt__BillingAccountId__r.ShippingCity,
            	vlocity_cmt__BillingAccountId__r.ShippingNeighborhood__c,
            	vlocity_cmt__BillingAccountId__r.ShippingState,
            	vlocity_cmt__BillingAccountId__r.ShippingStreet,	
                vlocity_cmt__ServiceAccountId__r.ShippingPostalCode,
                vlocity_cmt__ServiceAccountId__r.ShippingNumber__c,
                vlocity_cmt__ServiceAccountId__r.FullComplement__c,
            	vlocity_cmt__ServiceAccountId__r.ShippingCity,
            	vlocity_cmt__ServiceAccountId__r.ShippingNeighborhood__c,
            	vlocity_cmt__ServiceAccountId__r.ShippingState,
            	vlocity_cmt__ServiceAccountId__r.ShippingStreet
            
            FROM    
                Asset 
            WHERE   
                Id IN :listRecordId
        ];
    }
}