global with sharing class MergeAssetController implements vlocity_cmt.VlocityOpenInterface2 {

    global boolean invokeMethod(String methodName, Map<String, Object> inputs, Map<String, Object> output, Map<String, Object> options){    
        switch on methodName {
            when 'mergeAssets'
            {output.put('result', mergeAssets(inputs));} 
        }
        return true; 
    }

    String mergeAssets(Map<String, Object> arguments){
        String accountId = (String) arguments.get('AccountId');
        String documentNumber =  String.valueOf(arguments.get('DocumentNumber'));
        List<WrapperAPI> lstProductsAPI;
        try{
            lstProductsAPI = (List<WrapperAPI>) JSON.deserialize(JSON.serialize(arguments.get('lstProducts')), List<WrapperAPI>.class);
        }catch(Exception e){
            return 'API não retornou dados. ' + e.getMessage();
        }

        List<Asset> lstAsset = [SELECT Id, vlocity_cmt__ServiceIdentifier__c, StartDate__c FROM Asset WHERE AccountId = :accountId];
        List<Asset> lstAssetToUpdate = new List<Asset>();
        Map<String, DateTime> assetsToUpdate = new Map<String, Datetime>();
        List<Id> assetsToDelete = new List<Id>();
        List<WrapperAPI> assetsToCreate = new List<WrapperAPI>();
        
        Map<String, Datetime> sfIds = new Map<String, Datetime>();
        Map<String, String> sfIdsToDelete = new Map<String, String>();
        Map<String, String> sfIdsToUpdate = new Map<String, String>();
        Map<String, List<String>> mapLegacy = new Map<String, List<String>>();
        Map<String, WrapperAPI> apiIds = new Map<String, WrapperAPI>();
        Map<String, List<String>> mapSVAProducts = new Map<String, List<String>>();
        // List<WrapperAPI> lstProductsAPI = new List<WrapperAPI>{productsAPI};

        processProductsAndSubproducts(lstProductsAPI, apiIds, mapLegacy, mapSVAProducts);
        
        for(Asset identifier : lstAsset){
            sfIds.put(identifier.vlocity_cmt__ServiceIdentifier__c, identifier.StartDate__c);
            sfIdsToUpdate.put(identifier.vlocity_cmt__ServiceIdentifier__c, identifier.id);
            sfIdsToDelete.put(identifier.vlocity_cmt__ServiceIdentifier__c, identifier.Id);
        }

        for(String id : sfIds.keySet()){
            if(apiIds.containsKey(id)){
                assetsToUpdate.put(id, apiIds.get(id).start_date);
            }else{
                assetsToDelete.add(sfIdsToDelete.get(id));
            }
        }

        for(String id : apiIds.keySet()){
            if(!sfIds.containsKey(id)){
                assetsToCreate.add(apiIds.get(id));
            }
        }


        String action;
        try{
            if(!assetsToUpdate.isEmpty()) updateAsset(assetsToUpdate, sfIdsToUpdate, action);
            if(!assetsToDelete.isEmpty()) deleteAsset(assetsToDelete, action);
            if(!assetsToCreate.isEmpty()) createAsset(assetsToCreate, accountId, action, documentNumber, mapSVAProducts, mapLegacy);
            deleteEmptyBillingAccount(accountId);
            return 'Execução sem erros';
        }catch(Exception e){
            return 'Erro na execução: ' + e.getMessage();
        }
    }

    public static void deleteAsset(List<Id> lstAssetsToDelete, String action){
        action = 'deletar';
        List<Asset> assetsToDelete = new List<Asset>();
        Asset assetToDelete;
        for(Id id : lstAssetsToDelete){
            assetToDelete = new Asset(Id = id);
            assetsToDelete.add(assetToDelete);
        }
        delete assetsToDelete;
    }

    public static void createAsset(List<WrapperAPI> lstAssetsToCreate, String accountId, 
                                   String action, String documentNumber, Map<String, List<String>> mapSVAProducts,
                                   Map<String, List<String>> mapLegacy){
        action = 'criar';
        Asset asset;
        List<Asset> lstAssetToCreate = new List<Asset>();
        Map<String, String> mapFromTo = createFromToMapping();

        String type;
        String product_type;

        for(WrapperAPI assetToCreate : lstAssetsToCreate){
            type = mapFromTo.get(assetToCreate.product_type + 'Type__c');
            asset = new Asset(                
                        vlocity_cmt__ServiceIdentifier__c = assetToCreate.identifiers[0].startsWith('+55') ? assetToCreate.identifiers[0].substring(3, assetToCreate.identifiers[0].length()) : assetToCreate.identifiers[0],                                
                        StartDate__c = assetToCreate.start_date,
                        ProductType__c = type == 'Movel' ? getProductType(assetToCreate.subscription_type, mapFromTo) : getProductType(assetToCreate.product_type, mapFromTo),
                        Name = assetToCreate.identifiers[0].startsWith('+55') ? assetToCreate.identifiers[0].substring(3, assetToCreate.identifiers[0].length()) : assetToCreate.identifiers[0],
                        Status = assetToCreate.status,
                        IsHolder__c = assetToCreate.tags != null ? getStringValue(assetToCreate.tags, 'multivivo:') : 'TIT',
                        MainProductDescription__c = assetToCreate.descriptions != null ? assetToCreate.descriptions[0].text : assetToCreate.display_name != null ? assetToCreate.display_name : null, 
                        AccountId = accountId,
                        Type__c = type,
                        Technology__c = type == 'Movel' ? type : null,
                        Speed__c = assetToCreate.connection != null ? assetToCreate.connection.downlink_mbps : null,
                        ExternalId__c = assetToCreate.identifiers[0] != null ?  getLegacyAssetId(assetToCreate.identifiers[0], documentNumber) : null,
                        SourceSystem__c = getLegacySystem(mapLegacy.get(assetToCreate.identifiers[0]), mapFromTo),
                        DigitalServices__c = mapSVAProducts.get(assetToCreate.identifiers[0]) != null ? String.join(mapSVAProducts.get(assetToCreate.identifiers[0]),';') : null
            );
            lstAssetToCreate.add(asset);
        }
        insert lstAssetToCreate;
    }

    public static void updateAsset(Map<String, Datetime> assets, Map<String, String> sfIdsToUpdate, String action){
        action = 'atualizar';
        Asset asset;
        List<Asset> lstAssetsToUpdate = new List<Asset>();
        Set<Id> setAssetsToUpdate = new Set<Id>();
        
        for(String id : assets.keySet()){
            setAssetsToUpdate.add(sfIdsToUpdate.get(id));
        }
        
        Map<Id, String> mapNameAsset = getAssetName(setAssetsToUpdate);
        
        for(String id : assets.keySet()){
            
            String assetName = String.valueOf(mapNameAsset.get(sfIdsToUpdate.get(id)));

            asset = new Asset(Id = sfIdsToUpdate.get(id),
                              StartDate__c = assets.get(id),                              
                              Name = assetName.startsWith('+55') ? assetName.substring(3, assetName.length()) : assetName,
                              vlocity_cmt__ServiceIdentifier__c = assetName.startsWith('+55') ? assetName.substring(3, assetName.length()) : assetName);
            lstAssetsToUpdate.add(asset);
        }
        update lstAssetsToUpdate;
    }


    public static Map<String,String> createFromToMapping(){
    
        Map<String, String> mapFromTo = new Map<String, String>();
        List<FromToMapping__mdt> ltFromToMapping = [
            SELECT 
                Id, 
                RecordType__c, 
                DestinyName__c, 
                OriginName__c, 
                DestinyApiName__c 
            FROM 
                FromToMapping__mdt 
            WHERE 
                Object__c = 'SubscribedProducts' AND
                DestinyApiName__c IN ('Type__c', 'ProductType__c', 'LegacySystem__c')
        ];
       
        for(FromToMapping__mdt record : ltFromToMapping){
            mapFromTo.put(record.OriginName__c + record.DestinyApiName__c, record.DestinyName__c);
        }

        return mapFromTo;
    }

    private static String getLegacyAssetId(String identifier, String documentNumber){
        if(identifier.contains('+55')){
            return documentNumber + identifier.substring(3, identifier.length());
        }else{
            return documentNumber + identifier;
        }
    }

    private static String getLegacySystem(List<String> tags, Map<String, String> mapFromTo){
        String legacySystem;
        List<String> lstLegacySystem;

        for(String tag : tags){
            if(tag.contains('so:')){
                lstLegacySystem = tag.split(':');
                legacySystem = lstLegacySystem[1];
                break;
            }
        }
        return mapFromTo.get(legacySystem+'LegacySystem__c') != null ? mapFromTo.get(legacySystem+'LegacySystem__c') : legacySystem;
    }

    private static String getProductType(String productType, Map<String, String> mapFromTo){
        return mapFromTo.get(productType+'ProductType__c');
    }

    private static void processProductsAndSubproducts(List<WrapperAPI> lstProductsAPI, 
    Map<String, WrapperAPI> apiIds, Map<String, List<String>> mapLegacy, 
    Map<String, List<String>> mapSVAProducts){

        for(WrapperAPI wrap : lstProductsAPI){
            if(wrap.sub_products != null){
                processProductsAndSubproducts(wrap.sub_products, apiIds, mapLegacy, mapSVAProducts);
            }else{
                if(wrap.product_type == 'value_added_service'){
                    if(mapSVAProducts.containsKey(wrap.identifiers[0])){
                        mapSVAProducts.get(wrap.identifiers[0]).add(wrap.display_name);
                    }else{
                        mapSVAProducts.put(wrap.identifiers[0], new List<String>());
                        mapSVAProducts.get(wrap.identifiers[0]).add(wrap.display_name);
                    }
                }else{
                    apiIds.put(wrap.identifiers[0], wrap);
                    mapLegacy.put(wrap.identifiers[0], wrap.tags);
                }
            }
        }
    }

    private static String getStringValue(List<String> ltTags, String searchedString){
        String returnString;

        for(String stringValue :ltTags){
           
            if(stringValue.contains(searchedString)){
                List<String> lst = stringValue.split(':'); 
                returnString = lst[1];
                break;
            }
        }

        return returnString;
    }

    
    private static void deleteEmptyBillingAccount(String accountId) {
        Account accountObject = [SELECT BillingAccount__c FROM Account WHERE Id = :accountId];
        if(String.isNotEmpty(accountObject.BillingAccount__c)) {
            List<Asset> assetList = [SELECT Id FROM Asset WHERE AccountId = :accountId];
            if(assetList.isEmpty()) {
                delete new Account(Id = accountObject.BillingAccount__c);
            }
        }
    }

    public static Map<Id, String> getAssetName(Set<Id> setAssetsToUpdate){
        Map<Id, String> returnAssetName = new Map<Id, String>();
        List<Asset> lstAsset = [SELECT Id, Name FROM Asset WHERE Id IN : setAssetsToUpdate];
        
        for(Asset varAsset : lstAsset)
        {
        	returnAssetName.put(varAsset.Id, varAsset.Name);
        }
        
        return returnAssetName;
    }
    
    private class WrapperAPI{
        private List<String> identifiers {get; set;}
        private DateTime start_date {get; set;}
        private String subscription_type {get; set;}
        private List<WrapperAPI> sub_products {get; set;}
        private String product_type {get; set;}
        private String display_name {get; set;}
        private String status {get; set;}
        private Connection connection {get; set;}
        private List<String> tags {get; set;}
        private List<Descriptions> descriptions {get;set;}
    }

    private class Connection{
        private String downlink_mbps {get; set;}
        private String uplink_mbps {get; set;}
        private String type {get; set;}
    }

    private class Descriptions{
        private String text {get;set;}
    }
}
