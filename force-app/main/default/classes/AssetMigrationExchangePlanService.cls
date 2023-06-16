public with sharing class AssetMigrationExchangePlanService {

    public static Boolean showOffer(Id userId){
        return AssetMigrationExchangePlanEngine.showOffer(userId); 
    }

    public static Map<String,Object> createCustomerInteractionTopic(String customerInteractionId, String assetId) {
        return AssetMigrationExchangePlanEngine.createCustomerInteractionTopic(customerInteractionId, assetId);
    }
}