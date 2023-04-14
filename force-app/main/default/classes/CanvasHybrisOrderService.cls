public with sharing class CanvasHybrisOrderService extends CanvasHybrisServices {
    protected override Account query(Id recordId){
        return [SELECT  Id, 
                        Name, 
                        DocumentNumber__c,  
                        vlocity_cmt__CreditScore__c,
                        vlocity_cmt__PrimaryContactId__r.MotherName__c, 
                        vlocity_cmt__PrimaryContactId__r.Email,
                        vlocity_cmt__PrimaryContactId__r.MobilePhone,
                        vlocity_cmt__PrimaryContactId__r.Birthdate,
                		ShippingPostalCode,
                        ShippingNumber__c,
                        FullComplement__c
                            
                FROM    Account 
                WHERE   Id = :recordId
                LIMIT   1];
        
    }
}