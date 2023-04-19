public with sharing class AssetMigrationExchangePlanController {
    @AuraEnabled
    public static Boolean showOffer(Id userId){
        return AssetMigrationExchangePlanService.showOffer(userId); 
    }

    @AuraEnabled
    public static Map<String,Object> createCustomerInteractionTopic(String customerInteractionId, String assetId) {
        try {
            return AssetMigrationExchangePlanService.createCustomerInteractionTopic(customerInteractionId, assetId);
        } catch(Exception e) {
            Map <String, Object> returnMap = new Map<String, Object>();
            returnMap.put('error', e.getMessage());
            return returnMap;
        }
    }
}