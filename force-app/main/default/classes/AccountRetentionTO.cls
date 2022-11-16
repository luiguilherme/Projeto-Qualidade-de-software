public with sharing class AccountRetentionTO {
    
    public class BillingAccount {
        @AuraEnabled public Id idBilling;
        @AuraEnabled public String name;
        @AuraEnabled public Decimal totalPrice;        
        @AuraEnabled public Decimal totalAmount;        
        @AuraEnabled public List<Asset> ltAsset;
        @AuraEnabled public List<AssetMovel> ltAssetMovel;
        @AuraEnabled public List<Offer> ltOffer;
        @AuraEnabled public Id selectedOfferId;
        @AuraEnabled public Boolean hasAsset;
        @AuraEnabled public Boolean hasMultipleAssets;
        @AuraEnabled public Boolean hasOffer;
        @AuraEnabled public String offerMessage;
    }

    public class AssetMovel {
        @AuraEnabled public Id idBilling;
        @AuraEnabled public Asset itemAsset;
        @AuraEnabled public List<Asset> ltAsset;
        @AuraEnabled public List<Offer> ltOffer;
        @AuraEnabled public Id selectedOfferId;
        @AuraEnabled public String phone;
        @AuraEnabled public Boolean hasOffer;
        @AuraEnabled public Decimal priceCurrent;       
    }
    
    public class Offer {
        @AuraEnabled public Id idBilling;
        @AuraEnabled public Id idOffer;
        @AuraEnabled public Id selectedOfferId;
        @AuraEnabled public Id selectedOfferAltaId;
        @AuraEnabled public Decimal planTotalPrice;
        @AuraEnabled public String offerMessage;
        @AuraEnabled public String field1;
        @AuraEnabled public String field2;
        @AuraEnabled public String field3;
        @AuraEnabled public String field4;
        @AuraEnabled public String field5;
        @AuraEnabled public String field6;
        @AuraEnabled public String field7;
        @AuraEnabled public String field8;
        @AuraEnabled public String field10;
        @AuraEnabled public String field11;
        @AuraEnabled public String field12;
    }

}