public with sharing class CartOfferDAO {
    public static List<CartOffer__c> getCartOfferByOfferId(Set<Id> setIdOffer){
        return [
            SELECT    
                Id, 
                OfferId__c 
            FROM 
                CartOffer__c 
            WHERE 
                OfferId__c IN: setIdOffer
            AND Active__c = true
        ];
    }
    public static List<CartOffer__c> getCartOfferByCartId(Set<Id> setIdCartId){
        return [
            SELECT    
                Id, 
                CartId__c 
            FROM 
                CartOffer__c 
            WHERE 
            CartId__c IN: setIdCartId
        ];
    }
}