global without sharing class MergeAssetController implements vlocity_cmt.VlocityOpenInterface2 
{
    private static final List<String> LIST_VALIDS_PRODUCTS_TYPES =  new List<String>{'landline', 'cable_tv', 'iptv', 'streaming_TV', 'dth', 'mobile', 'TV', 'hybrid_tv', 'internet'};
        
        private static final List<String> LST_PRODUCT_TYPE_TO_GET_DESC = new List<String>{'iptv', 'internet', 'landline'};
            
            private static final List<String> LST_INVALID_PLATFORM = new List<String>{'SIM Card'};
                
                global boolean invokeMethod(String methodName, Map<String, Object> inputs, Map<String, Object> output, Map<String, Object> options)
            {    
                switch on methodName {
                    when 'mergeAssets'
                    {output.put('result', mergeAssets(inputs));} 
                }
                return true; 
            }
    
    String mergeAssets(Map<String, Object> arguments)
    {        
        String accountId = (String) arguments.get('AccountId');
        String documentNumber =  String.valueOf(arguments.get('DocumentNumber'));
        List<WrapperAPI> lstProductsAPI;
        
        try{
            lstProductsAPI = (List<WrapperAPI>) JSON.deserialize(JSON.serialize(arguments.get('lstProducts')), List<WrapperAPI>.class);
        }catch(Exception e){            
            return 'API não retornou dados. ' + e.getMessage();
        }
        
        List<Asset> lstAsset = getAssets(accountId);
        List<String> assetsToDelete = new List<String>();
        List<WrapperAPI> assetsToCreateUpdate = new List<WrapperAPI>();        
        Map<String, Datetime> sfIds = new Map<String, Datetime>();
        Map<String, String> sfIdsToDelete = new Map<String, String>();        
        Map<String, List<String>> mapLegacy = new Map<String, List<String>>();
        Map<String, WrapperAPI> apiIds = new Map<String, WrapperAPI>();
        Map<String, List<String>> mapSVAProducts = new Map<String, List<String>>();
        Map<String, Map<String, String>> mapResultProcessSalesforceAsset = new Map<String, Map<String, String>>(); 
        
        processSalesforceAssets(lstAsset, documentNumber, mapResultProcessSalesforceAsset);
        processProductsAndSubproducts(lstProductsAPI, apiIds, mapLegacy, mapSVAProducts, documentNumber);
        
        for(Asset identifier : lstAsset) {
            if(!isSalesforceAsset(identifier.vlocity_cmt__SubscriptionId__c)){
                sfIds.put(identifier.ExternalId__c, identifier.StartDate__c);
                sfIdsToDelete.put(identifier.ExternalId__c, identifier.Id);
            } 
        }
        
        if(lstAsset.isEmpty())
        {
            for(WrapperAPI wrapperAPI : lstProductsAPI)
            {                  
                assetsToCreateUpdate.add(wrapperAPI);
            }                        
        } else {
            for(String id : sfIds.keySet())
            {          
                if(!apiIds.containsKey(id)) 
                {
                    assetsToDelete.add(sfIdsToDelete.get(id));
                }
            }
            
            for(WrapperAPI wrapperAPI : lstProductsAPI)
            {                
                assetsToCreateUpdate.add(wrapperAPI);
            }                        
        }        
        
        try{
            if(!assetsToDelete.isEmpty()) 
            { 
                deleteAsset(assetsToDelete);
                deleteEmptyBillingAccount(accountId);
            }
            
            if(!assetsToCreateUpdate.isEmpty())
            {
                createUpdateAsset(assetsToCreateUpdate, accountId, documentNumber, mapSVAProducts, mapLegacy, mapResultProcessSalesforceAsset);                
            } 
            
            return 'Execução sem erros';
        }catch(Exception e){
            return 'Erro na execução: ' + e.getMessage();
        }
    }
    
    public static List<Asset> createAssets(String accountId, String documentNumber, CreateCaseRequestWrapper.Payload lstProductsAPIBefore) {
        List<Asset> lstAsset = [
            SELECT
            ExternalId__c, vlocity_cmt__ServiceIdentifier__c, StartDate__c, Platform__c
            FROM Asset
            WHERE
            AccountId = :accountId
            AND Platform__c != 'Prepaid'
            AND Product2Id = null
            ORDER BY StartDate__c DESC
        ];
        
        List<WrapperAPI> lstProductsAPI = new List<WrapperAPI>();
        WrapperAPI wrapperAPIBefore = new WrapperAPI();
        wrapperAPIBefore.identifiers = lstProductsAPIBefore.identifiers;
        wrapperAPIBefore.start_date = lstProductsAPIBefore.start_date;
        wrapperAPIBefore.subscription_type = lstProductsAPIBefore.subscription_type;
        wrapperAPIBefore.product_type = lstProductsAPIBefore.product_type;
        wrapperAPIBefore.display_name = lstProductsAPIBefore.display_name;
        wrapperAPIBefore.status = lstProductsAPIBefore.status;
        wrapperAPIBefore.status_description = lstProductsAPIBefore.status_description;
        String subProductsJson = JSON.serialize(lstProductsAPIBefore.sub_products);
        wrapperAPIBefore.sub_products = (List<WrapperAPI>) JSON.deserialize(subProductsJson, List<WrapperAPI>.class);

        Connection newConnection = new Connection();
        if(lstProductsAPIBefore.connection != null) {
            newConnection.downlink_mbps = lstProductsAPIBefore.connection.downlink_mbps;
            newConnection.uplink_mbps = lstProductsAPIBefore.connection.uplink_mbps;
            newConnection.type = lstProductsAPIBefore.connection.type;
        }
        
        wrapperAPIBefore.connection = newConnection;
        wrapperAPIBefore.tags = lstProductsAPIBefore.tags;
        
        List<Descriptions> listNewDescrptions = new List<Descriptions>();
        if(lstProductsAPIBefore.descriptions != null) {
            for(CreateCaseRequestWrapper.Descriptions thisDescrption: lstProductsAPIBefore.descriptions) {
                Descriptions newDescription = new Descriptions();
                newDescription.text = thisDescrption.text;
                listNewDescrptions.add(newDescription);
            }   
        }
        
        wrapperAPIBefore.descriptions = listNewDescrptions;
        lstProductsAPI.add(wrapperAPIBefore);
        
        List<WrapperAPI> assetsToCreateUpdate = new List<WrapperAPI>();
        Map<String, Datetime> sfIds = new Map<String, Datetime>();
        Map<String, List<String>> mapLegacy = new Map<String, List<String>>();
        Map<String, WrapperAPI> apiIds = new Map<String, WrapperAPI>();
        Map<String, List<String>> mapSVAProducts = new Map<String, List<String>>();
        processProductsAndSubproducts(lstProductsAPI, apiIds, mapLegacy, mapSVAProducts, documentNumber);
        for(Asset identifier : lstAsset)
        {
            sfIds.put(identifier.ExternalId__c, identifier.StartDate__c);
        }
        if(lstAsset.isEmpty())
        {
            for(WrapperAPI wrapperAPI : lstProductsAPI)
            {
                assetsToCreateUpdate.add(wrapperAPI);
            }
        } else {
            for(WrapperAPI wrapperAPI : lstProductsAPI)
            {
                assetsToCreateUpdate.add(wrapperAPI);
            }
        }
        List<Asset> assetsCreatedOrUpdated = new List<Asset>();
        if(!assetsToCreateUpdate.isEmpty())
        {
            assetsCreatedOrUpdated = createUpdateAsset(assetsToCreateUpdate, accountId, documentNumber, mapSVAProducts, mapLegacy, new Map<String, Map<String, String>>());
        }
        return assetsCreatedOrUpdated;
    }
    
    public static void deleteAsset(List<String> lstAssetsToDelete)
    {
        List<Asset> lstAssets = [SELECT Id FROM Asset WHERE Id IN :lstAssetsToDelete AND Platform__c != 'Prepaid'
                                 AND Product2Id = null];
        List<Asset> lstAssetsToDel = new List<Asset>();
        
        for(Asset asset : lstAssets)
        {
            lstAssetsToDel.add(asset);
        }
        
        try{
            delete lstAssetsToDel;
        }catch(Exception e){
            System.debug('Erro no Delete de Asset: ' + e.getMessage());
        }
    }
    
    public static List<Asset> createUpdateAsset(List<WrapperAPI> lstAssetsToCreate, String accountId, String documentNumber, Map<String, List<String>> mapSVAProducts,Map<String, List<String>> mapLegacy,Map<String, Map<String, String>> mapResultProcessSalesforceAsset)
    {
        Asset asset;
        vlocity_cmt__Subscription__c subscriptionToUpdate;
        List<Asset> lstAssetToCreateUpdate = new List<Asset>();
        List<Asset> lstSalesforceAssetsToUpdate = new List<Asset>();
        List<vlocity_cmt__Subscription__c> lstSalesforceSubscriptionToUpdate = new List<vlocity_cmt__Subscription__c>();
        
        
        Map<String, String> mapSalesforceAssetId = mapResultProcessSalesforceAsset.get('Asset');
        Map<String, String> mapSalesforceSubscriptionId = mapResultProcessSalesforceAsset.get('Subscription');
        Map<String, String> mapFromTo = createFromToMapping();
        String type;
        String product_type;
        String sourceSystem;
        List<WrapperAPI> lstSubproducts = new List<WrapperAPI>();
        Set<String> setProducts = new Set<String>();
        Account customer = AccountDAO.getByIds(accountId);
        
        if(!lstAssetsToCreate.isEmpty())
        {
            for(WrapperAPI assetToCreate : lstAssetsToCreate)
            {   
                
                if(assetToCreate.product_type.contains('value_added_service')){
                    continue;
                }
                sourceSystem = getLegacySystem(mapLegacy.get(assetToCreate.identifiers[0]), mapFromTo);
                String externalId = assetToCreate.identifiers[0].startsWith('+55') ? documentNumber + assetToCreate.identifiers[0].substring(3, assetToCreate.identifiers[0].length()) : documentNumber + assetToCreate.identifiers[0];                
                
                if(sourceSystem != 'Salesforce') {
                    
                    if(!setProducts.contains(externalId) && !assetToCreate.product_type.contains('bundle')) {
                        
                        setProducts.add(externalId);                     
                        type = mapFromTo.get(assetToCreate.product_type + 'Type__c');
                        
                        asset = new Asset();            
                        asset.vlocity_cmt__ServiceIdentifier__c = assetToCreate.identifiers[0].startsWith('+55') ? assetToCreate.identifiers[0].substring(3, assetToCreate.identifiers[0].length()) : assetToCreate.identifiers[0];                               
                        asset.StartDate__c = assetToCreate.start_date;
                        asset.ProductType__c = type == 'Movel' ? getProductType(assetToCreate.subscription_type, mapFromTo) : getProductType(assetToCreate.product_type, mapFromTo);
                        asset.Name = assetToCreate.identifiers[0].startsWith('+55') ? assetToCreate.identifiers[0].substring(3, assetToCreate.identifiers[0].length()) : assetToCreate.identifiers[0];
                        asset.Status = assetToCreate.status;
                        asset.StatusDescription__c = assetToCreate.status_description;
                        asset.IdBundle__c = assetToCreate.idBundle != null ? assetToCreate.idBundle : null;
                        asset.OfferDescription__c = assetToCreate.offerDescription != null ? assetToCreate.offerDescription : null;
                        asset.IsHolder__c = assetToCreate.tags != null ? getStringValue(assetToCreate.tags, 'multivivo:') : 'TIT';
                        asset.MainProductDescription__c = getMainProductDescription(assetToCreate, sourceSystem);
                        asset.AccountId = accountId;
                        asset.Type__c = type;
                        asset.Technology__c = type == 'Movel' ? type : ''; 
                        asset.Speed__c = assetToCreate.connection != null ? assetToCreate.connection.downlink_mbps : null;
                        asset.ExternalId__c = externalId;
                        asset.PhoneNumber__c = assetToCreate.identifiers[0].startsWith('+55') ? assetToCreate.identifiers[0].substring(3, assetToCreate.identifiers[0].length()) : '';
                        asset.SourceSystem__c = sourceSystem;
                        asset.DigitalServices__c = mapSVAProducts.get(assetToCreate.identifiers[0]) != null ? String.join(mapSVAProducts.get(assetToCreate.identifiers[0]),';') : null;
                        asset.Platform__c = getPlatform(assetToCreate);
                        
                        if(!lstAssetToCreateUpdate.contains(asset))
                        {
                            lstAssetToCreateUpdate.add(asset);
                        }
                        
                    } else {
                        if(assetToCreate.sub_products != null)
                        {
                            updateListAssetsToUpdate(assetToCreate.sub_products, setProducts, lstAssetToCreateUpdate, mapFromTo, accountId, documentNumber, mapSVAProducts, mapLegacy);
                        }                     
                    }      
                } else {
                    
                    if(mapSalesforceAssetId.get(externalId) != null){
                        asset = new Asset();            
                        asset.id = mapSalesforceAssetId.get(externalId);
                        asset.SourceSystem__c = sourceSystem;
                        asset.ExternalId__c = externalId;
                        lstSalesforceAssetsToUpdate.add(asset);
                        
                        subscriptionToUpdate = new vlocity_cmt__Subscription__c();
                        subscriptionToUpdate.id = mapSalesforceSubscriptionId.get(externalId);
                        subscriptionToUpdate.vlocity_cmt__Status__c = getStatus(assetToCreate.status);
                        subscriptionToUpdate.vlocity_cmt__StartDate__c = assetToCreate.start_date;
                        lstSalesforceSubscriptionToUpdate.add(subscriptionToUpdate);
                    } 
                }
            }
        }                
        String customerType = '';
        for(Asset item : lstAssetToCreateUpdate){
            if(customerType == 'Totalizado') break;
            if(item.Type__c == 'Pre') continue;
            
            customerType = customerType == ''? item.Type__c : customerType != item.Type__c && customerType != null ? 'Totalizado' : customerType; 
        }
        
        customerType = customerType == 'Movel' ? 'Móvel' : customerType;
        
        try{
            if(customer.vlocity_cmt__CustomerClass__c != customerType && customerType != ''){
                customer.vlocity_cmt__CustomerClass__c = customerType;
                update customer;
            }
            
            update lstSalesforceAssetsToUpdate; 
            update lstSalesforceSubscriptionToUpdate;
            upsert lstAssetToCreateUpdate ExternalId__c;
            return lstAssetToCreateUpdate;
        }catch(Exception e){
            System.debug('Erro no Upsert de Asset: ' + e.getMessage());
        }        
        
        return new List<Asset>();
    }
    
    private static void updateListAssetsToUpdate(List<WrapperAPI> listProduct, Set<String> setProducts, List<Asset> lstAssetToCreateUpdate, Map<String, String> mapFromTo, String accountId, String documentNumber, Map<String, List<String>> mapSVAProducts,Map<String, List<String>> mapLegacy){
        Asset asset;
        for(WrapperAPI assetToCreate : listProduct){ 
            
            if(assetToCreate.product_type.contains('value_added_service')){
                continue;
            }
            
            String strIdentifier = assetToCreate.identifiers[0].startsWith('+55') ? documentNumber + assetToCreate.identifiers[0].substring(3, assetToCreate.identifiers[0].length()) : documentNumber + assetToCreate.identifiers[0];                
            if(!setProducts.contains(strIdentifier) && assetToCreate.product_type != 'bundle')
            {
                setProducts.add(strIdentifier);
                
                String type = mapFromTo.get(assetToCreate.product_type + 'Type__c');
                String sourceSystem = getLegacySystem(mapLegacy.get(assetToCreate.identifiers[0]), mapFromTo);
                
                asset = new Asset();            
                
                asset.vlocity_cmt__ServiceIdentifier__c = assetToCreate.identifiers[0].startsWith('+55') ? assetToCreate.identifiers[0].substring(3, assetToCreate.identifiers[0].length()) : assetToCreate.identifiers[0];                               
                asset.StartDate__c = assetToCreate.start_date;
                asset.ProductType__c = type == 'Movel' ? getProductType(assetToCreate.subscription_type, mapFromTo) : getProductType(assetToCreate.product_type, mapFromTo);
                asset.Name = assetToCreate.identifiers[0].startsWith('+55') ? assetToCreate.identifiers[0].substring(3, assetToCreate.identifiers[0].length()) : assetToCreate.identifiers[0];
                asset.Status = assetToCreate.status;
                asset.StatusDescription__c = assetToCreate.status_description;
                asset.IsHolder__c = assetToCreate.tags != null ? getStringValue(assetToCreate.tags, 'multivivo:') : 'TIT';
                asset.MainProductDescription__c = getMainProductDescription(assetToCreate, sourceSystem);
                asset.AccountId = accountId;
                asset.Type__c = type;
                asset.Technology__c = type == 'Movel' ? type : ''; 
                asset.Speed__c = assetToCreate.connection != null ? assetToCreate.connection.downlink_mbps : null;
                asset.ExternalId__c = assetToCreate.identifiers[0].startsWith('+55') ? documentNumber + assetToCreate.identifiers[0].substring(3, assetToCreate.identifiers[0].length()) : documentNumber + assetToCreate.identifiers[0];
                asset.PhoneNumber__c = assetToCreate.identifiers[0].startsWith('+55') ? assetToCreate.identifiers[0].substring(3, assetToCreate.identifiers[0].length()) : '';
                asset.SourceSystem__c = sourceSystem;
                asset.DigitalServices__c = mapSVAProducts.get(assetToCreate.identifiers[0]) != null ? String.join(mapSVAProducts.get(assetToCreate.identifiers[0]),';') : null;
                asset.Platform__c = getPlatform(assetToCreate);
                
                if(!lstAssetToCreateUpdate.contains(asset)){
                    lstAssetToCreateUpdate.add(asset);
                }                 
            }else if(assetToCreate.sub_products != null){
                updateListAssetsToUpdate(assetToCreate.sub_products, setProducts, lstAssetToCreateUpdate, mapFromTo, accountId, documentNumber, mapSVAProducts, mapLegacy);
            }
        }
    }
    
    public static String getMainProductDescription(WrapperAPI assetToCreate, String sourceSystem){
        String description = '';
        if (assetToCreate.descriptions != null) {
            for (Descriptions assetDesc : assetToCreate.descriptions) {
                if (assetDesc.title == 'commercial_name') {
                    description = assetDesc.text;
                    break;
                }
            }
        }
        String displayName = assetToCreate.display_name;
        
        if(LST_PRODUCT_TYPE_TO_GET_DESC.contains(assetToCreate.product_type)){
            return assetToCreate.descriptions != null && assetToCreate.descriptions.size() == 1 ?
                description : displayName;
        }
        
        switch on sourceSystem {
            when 'Ngin' {
                return description;
            }
            when else {
                if(displayName != null){
                    return displayName;
                }  
                
                if(description != ''){
                    return description;
                } 
                
                return '';
            }
        }
    }
    
    public static Map<String,String> createFromToMapping()
    {    
        Map<String, String> mapFromTo = new Map<String, String>();
        List<FromToMapping__mdt> ltFromToMapping = [SELECT Id, RecordType__c, DestinyName__c, OriginName__c, DestinyApiName__c 
                                                    FROM FromToMapping__mdt 
                                                    WHERE Object__c = 'SubscribedProducts' AND DestinyApiName__c IN ('Type__c', 'ProductType__c', 'LegacySystem__c')];
        
        for(FromToMapping__mdt record : ltFromToMapping)
        {
            mapFromTo.put(record.OriginName__c + record.DestinyApiName__c, record.DestinyName__c);
        }
        
        return mapFromTo;
    }
    
    private static String getLegacyAssetId(String identifier, String documentNumber)
    {
        if(identifier.contains('+55'))
        {
            return documentNumber + identifier.substring(3, identifier.length());
        }else{
            return documentNumber + identifier;
        }
    }
    
    private static String getLegacySystem(List<String> tags, Map<String, String> mapFromTo)
    {
        String legacySystem;
        List<String> lstLegacySystem;
        
        for(String tag : tags)
        {
            if(tag.contains('so:'))
            {
                lstLegacySystem = tag.split(':');
                legacySystem = lstLegacySystem[1];
                break;
            }
        }
        
        return mapFromTo.get(legacySystem+'LegacySystem__c') != null ? mapFromTo.get(legacySystem+'LegacySystem__c') : legacySystem;
    }
    
    private static String getProductType(String productType, Map<String, String> mapFromTo)
    {
        return mapFromTo.get(productType+'ProductType__c');
    }
    
    private static void processProductsAndSubproducts(List<WrapperAPI> lstProductsAPI, Map<String, WrapperAPI> apiIds, 
                                                      Map<String, List<String>> mapLegacy, Map<String, List<String>> mapSVAProducts, String documentNumber)
    {
        for(WrapperAPI wrap : lstProductsAPI)
        {
            if(wrap.sub_products != null)
            {
                processProductsAndSubproducts(wrap.sub_products, apiIds, mapLegacy, mapSVAProducts, documentNumber);
            }else{
                if(wrap.product_type == 'value_added_service')
                {                    
                    if(mapSVAProducts.containsKey(wrap.identifiers[0]))
                    {
                        mapSVAProducts.get(wrap.identifiers[0]).add(wrap.display_name);
                    }else{
                        mapSVAProducts.put(wrap.identifiers[0], new List<String>());
                        mapSVAProducts.get(wrap.identifiers[0]).add(wrap.display_name);
                    }
                }
                if(LIST_VALIDS_PRODUCTS_TYPES.contains(wrap.product_type)){                    
                    String strKey = wrap.identifiers[0].startsWith('+55') ? documentNumber + wrap.identifiers[0].substring(3, wrap.identifiers[0].length()) : documentNumber + wrap.identifiers[0];
                    apiIds.put(strKey, wrap);
                    mapLegacy.put(wrap.identifiers[0], wrap.tags);
                }
            }
        }
    }
    
    private static String getStringValue(List<String> ltTags, String searchedString)
    {
        String returnString;
        
        for(String stringValue :ltTags)
        {           
            if(stringValue.contains(searchedString))
            {
                List<String> lst = stringValue.split(':'); 
                returnString = lst[1];
                break;
            }
        }
        
        return returnString;
    }
    
    private static void deleteEmptyBillingAccount(String accountId)
    {
        Account accountObject = [SELECT BillingAccount__c FROM Account WHERE Id = :accountId];
        
        if(String.isNotEmpty(accountObject.BillingAccount__c))
        {
            List<Asset> assetList = [SELECT Id FROM Asset WHERE AccountId = :accountId AND Platform__c != 'Prepaid'
                                     AND Product2Id = null];
            if(assetList.isEmpty()) 
            {
                delete new Account(Id = accountObject.BillingAccount__c);
            }
        }
    }
    
    public static Map<Id, String> getAssetName(Set<Id> setAssetsToUpdate)
    {
        Map<Id, String> returnAssetName = new Map<Id, String>();
        List<Asset> lstAsset = [SELECT Id, Name FROM Asset WHERE Id IN : setAssetsToUpdate];
        
        for(Asset varAsset : lstAsset)
        {
            returnAssetName.put(varAsset.Id, varAsset.Name);
        }
        
        return returnAssetName;
    }
    
    public static String getPlatform(WrapperAPI assetToCreate) {
        String subsType = assetToCreate.subscription_type;
        String prodType = assetToCreate.product_type;
        
        if (prodType == 'mobile') {
            switch on subsType {
                when  'postpaid'{
                    return 'Postpaid';
                }
                when 'prepaid' {
                    return 'Prepaid';
                }
                when else {
                    return '';
                }
            }
        } else {
            return '';
        }
    }
    
    public static void processSalesforceAssets(List<Asset> lstAsset, String documentNumber, Map<String, Map<String, String>> mapResultProcessSalesforceAsset) {
        
        Map<String, String> mapSalesforceAssetToUpdate = new Map<String, String>();
        Map<String, String> mapSalesforceSubscriptionToUpdate = new Map<String, String>();
        for(Asset identifier : lstAsset) {
            if(identifier.vlocity_cmt__SubscriptionId__c != null) {
                String externalId = documentNumber + identifier.vlocity_cmt__ServiceIdentifier__c;
                mapSalesforceAssetToUpdate.put(externalId, identifier.id);
                mapSalesforceSubscriptionToUpdate.put(externalId, identifier.vlocity_cmt__SubscriptionId__c);
            }
        }
        
        mapResultProcessSalesforceAsset.put('Asset', mapSalesforceAssetToUpdate);
        mapResultProcessSalesforceAsset.put('Subscription', mapSalesforceSubscriptionToUpdate);
        
    }
    
    private static Boolean isSalesforceAsset(String subscriptionId){
        return subscriptionId != null;
    }
    
    private static List<Asset> getAssets(String accountId) {
        return 
            [
                SELECT 
                Id, 
                ExternalId__c, 
                vlocity_cmt__ServiceIdentifier__c, 
                StartDate__c, 
                Platform__c, 
                vlocity_cmt__SubscriptionId__c
                FROM 
                Asset 
                WHERE 
                AccountId = :accountId AND 
                Platform__c NOT IN : LST_INVALID_PLATFORM AND 
                vlocity_cmt__ServiceIdentifier__c != null 
                ORDER BY StartDate__c DESC
            ];
    }
    
    private static String getStatus(String status) {
        switch on status {
            when 'active' {		
                return 'Ativo';
            }	
            when 'activating' {
                return 'Pré Ativo';
            }
            when 'suspended' {
                return 'Suspenso a Pedido';
            }
            when 'cancelled' {
                return 'Cancelado';
            }
            when 'selected' {
                return 'Selecionado';
            }
            when else {
                return 'Ativo';
            }
        }
    }
    
    @TestVisible
    private class WrapperAPI
    {
        @TestVisible
        private List<String> identifiers {get; set;}
        @TestVisible
        private DateTime start_date {get; set;}
        @TestVisible
        private String subscription_type {get; set;}
        @TestVisible
        private List<WrapperAPI> sub_products {get; set;}
        @TestVisible
        private String product_type {get; set;}
        @TestVisible
        private String display_name {get; set;}
        @TestVisible
        private String status {get; set;}
        @TestVisible
        private String status_description {get;set;}
        @TestVisible
        private String id {get;set;}
        @TestVisible
        private Connection connection {get; set;}
        @TestVisible
        private List<String> tags {get; set;}
        @TestVisible
        private List<Descriptions> descriptions {get;set;}
        @TestVisible
        private String idBundle {get;set;}
        @TestVisible
        private String offerDescription {get;set;}
    }
    
    private class Connection
    {
        private String downlink_mbps {get; set;}
        private String uplink_mbps {get; set;}
        private String type {get; set;}
    }
    
    @TestVisible
    private class Descriptions
    {
        @TestVisible
        private String text {get;set;}
        @TestVisible
        private String title {get;set;}
    }
}