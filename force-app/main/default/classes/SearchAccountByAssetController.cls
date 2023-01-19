public with sharing class SearchAccountByAssetController {
    @AuraEnabled
    public static List<Asset> searchByAssetNumber(String searchKey){
        try {
            return AssetDAO.getAssetByName(searchKey);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}