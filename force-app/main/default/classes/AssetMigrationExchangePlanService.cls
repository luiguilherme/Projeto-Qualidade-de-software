public with sharing class AssetMigrationExchangePlanService {

    public static Boolean showOffer(Id userId){
        return AssetMigrationExchangePlanEngine.showOffer(userId); 
    }

    public static Map<String,Object> createCustomerInteractionTopic(String customerInteractionId) {
        return AssetMigrationExchangePlanEngine.createCustomerInteractionTopic(customerInteractionId);
    }
}