public with sharing class AssetMigrationExchangePlanController {
    @AuraEnabled
    public static Boolean showOffer(Id userId){
        return AssetMigrationExchangePlanService.showOffer(userId); 
    }
}