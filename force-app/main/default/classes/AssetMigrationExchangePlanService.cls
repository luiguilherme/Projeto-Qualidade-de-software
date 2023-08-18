public with sharing class AssetMigrationExchangePlanService {

    public static AssetMigrationDTO checkAccessToComponent(Id customerInteractionId){
        return AssetMigrationExchangePlanEngine.checkAccessToComponent(customerInteractionId); 
    }

    public static Map<String,Object> createCustomerInteractionTopic(String customerInteractionId, String assetId) {
        return AssetMigrationExchangePlanEngine.createCustomerInteractionTopic(customerInteractionId, assetId);
    }
}