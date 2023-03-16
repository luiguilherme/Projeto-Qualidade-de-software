public with sharing class AssetMigrationExchangePlanService {

    public static Boolean showOffer(Id userId){
        return AssetMigrationExchangePlanEngine.showOffer(userId); 
    }
}