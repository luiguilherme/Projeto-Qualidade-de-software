public Inherited Sharing class SubscribedProductsEngine {
    
    static final String CONST_STRING_WEBSERVICENAME = 'FourthPlataformSubscribedProducts';

    static final String CONST_STRING_PRODUCTTYPE = 'ProductType__c';
    static final String CONST_STRING_TYPE = 'Type__c';
    static final String CONST_STRING_LEGACYSYSTEM = 'LegacySystem__c';
    static final String CONST_STRING_CONTROL = 'control';
    static final String CONST_STRING_PREPAID = 'prepaid';
    static final String CONST_STRING_TITULAR = 'TIT'; 
    static final String CONST_STRING_FIXA = 'Fixa';
    static final String CONST_STRING_MOVEL = 'Movel';
    static final String CONST_STRING_BlANKVALUE = '---';
    static final String CONST_STRING_CONTROLE = 'CONTROLE';
    static final String CONST_STRING_EASY = 'EASY';
    static final String CONST_STRING_ACTIVE = 'Active';

    public static ServiceResponse callIntegration(String userId){

       if(!userId.contains('-')){
            throw new SubscribedProductsException('O valor: ' + userId + '. Não é valido como user id');
        }
    
       WebService__c webServiceObj = Util.getWebService(CONST_STRING_WEBSERVICENAME);
        webServiceObj.Endpoint__c = webServiceObj.Endpoint__c.replace('{user_id}',userId);
        
        HttpClient client = new HttpClient();
        HttpResponse response = client.get(webServiceObj);

        ServiceResponse serviceResponseObj = new ServiceResponse();
        
        if (response.getStatusCode()/100 == 2) {
            String result = response.getBody();
            serviceResponseObj.body = result;
            serviceResponseObj.success = true;
        }else{
            serviceResponseObj.success = false;
        }

        return serviceResponseObj;
    }
    
    public static List<Asset> validateExistingRecords(Id accountId, List<Asset> ltExisingAssets, List<Asset> ltAsset){
        List<Asset> ltRemoveRecords = new List<Asset>();
        Set<String> setLegacyAssetId = new Set<String>();
              
        CollectionUtil.loadSet(setLegacyAssetId,'LegacyAssetId__c', ltAsset);
               
        for(Asset assetObj : ltExisingAssets){
            
            if(setLegacyAssetId.contains(assetObj.LegacyAssetId__c)){
                continue;
            }

            ltRemoveRecords.add(assetObj);
        }

        return ltRemoveRecords;
    }

    public static void getAddedServiceByType(List<Asset> ltAsset, List<SubscribedProductsTO> ltSubscribedProductsObj, String type){
        Map<String,List<String>> mapSVAForIdentifier = new Map<String,List<String>>();
        String identifier;

        for(SubscribedProductsTO subscribedProductsObj :ltSubscribedProductsObj){
            
            if(!subscribedProductsObj.product_type.contains('value_added_service') || !subscribedProductsObj.tags.contains(type)){
                continue;
            }

            identifier = getProductName(subscribedProductsObj.identifiers);
            
            if(!mapSVAForIdentifier.containsKey(identifier)){
                mapSVAForIdentifier.put(identifier, new List<String>());
            }

            List<String> ltSVA = mapSVAForIdentifier.get(identifier);
            ltSVA.add(subscribedProductsObj.display_name);
            mapSVAForIdentifier.put(identifier,ltSVA);
        }

        for(Asset assetObj :ltAsset){
            
            List<String> ltSVA = mapSVAForIdentifier.get(assetObj.Name);

            if(ltSVA == null){
                continue;
            }

            assetObj.DigitalServices__c = String.join(ltSVA,';');
        }    
    }

    public static Map<String,String> createFromToMapping(Map<String,String> mapFromTo,String type){

        if(mapFromTo == null){
            mapFromTo = new Map<String,String>();
        }
    
        switch on type {
            when 'SubscribedProducts' {		

                List<FromToMapping__mdt> ltFromToMapping = FromToMappingDAO.getByObject(type);
       
                for(FromToMapping__mdt record : ltFromToMapping){
                    mapFromTo.put(record.OriginName__c+'|'+record.DestinyApiName__c, record.DestinyName__c);
                }
            }	
            when 'CustomerType' {		

                List<FromToMapping__mdt> ltFromToMapping = FromToMappingDAO.getByObject(type);
                List<String> lstStringValue = new List<String>();

                for(FromToMapping__mdt record : ltFromToMapping){
                    lstStringValue.clear();

                    if(record.OriginName__c.contains(',')){
                        lstStringValue.addAll(record.OriginName__c.split(','));
                    }else{
                        lstStringValue.add(record.OriginName__c);
                    }
                    //lstStringValue.addAll(record.OriginName__c.contains(',') ? record.OriginName__c.split(',') :  record.OriginName__c);

                    System.debug('Mapa está sendo preenchido com ' + type + ' seguintes valores: ' + lstStringValue);
                    mapFromTo.put(getStringSorted(lstStringValue),record.DestinyName__c);
                }
            }
        }

        return mapFromTo;
    }

    public static List<SubscribedProductsTO> deserializeSubscribedProducts(ServiceResponse serviceResponseObj){
        
        if(serviceResponseObj.body == '' || serviceResponseObj.body == null){
            throw new SubscribedProductsException('Não existe registro de produto para esse cliente');
        }
        
        return (List<SubscribedProductsTO>)JSON.deserialize(serviceResponseObj.body, List<SubscribedProductsTO>.class);
    }

    public static Map<String,String> getBillingAccountInformationResponse(List<SubscribedProductsTO> ltSubscribedProductsObj, List<Asset> ltExisingAssets, String stringDocument, Map<String, String> mapFromTo){
        Map<String,String> mapRecordTypeBillingAccountForName = new Map<String,String>();
        Map<String,List<SubscribedProductsTO>> mapRecords = new Map<String,List<SubscribedProductsTO>>();
        String type;
        String legacyAssetId;

        Map<String,Asset> mapAssetForLegacyAssetId = new Map<String, Asset>();
        CollectionUtil.loadMap(mapAssetForLegacyAssetId, 'LegacyAssetId__c', ltExisingAssets);

        for(SubscribedProductsTO subscribedProductsObj :ltSubscribedProductsObj){
            String identifierFirstValue;
            if(subscribedProductsObj.product_type.contains('value_added_service')){
                continue;
            }

            if(subscribedProductsObj.product_type.contains('bundle')){

                for(SubscribedProductsTO.SubProducts subProductsObj : subscribedProductsObj.sub_products){  
    
                    if(!subProductsObj.product_type.contains('bundle')){
                        identifierFirstValue = getProductName(subProductsObj.identifiers);

                        type = mapFromTo.containsKey(subProductsObj.product_type +'|'+ CONST_STRING_TYPE) ?  mapFromTo.get(subProductsObj.product_type +'|'+ CONST_STRING_TYPE) : null;//Type__c (Fixa ou Movel).
                    }
                    
                    if(subProductsObj.product_type != null && subProductsObj.sub_products != null){
                        
                        for(SubscribedProductsTO.SubProducts subProductsObjAux :subProductsObj.sub_products){  
                            identifierFirstValue = getProductName(subProductsObjAux.identifiers);
                            type = mapFromTo.containsKey(subProductsObjAux.product_type +'|'+ CONST_STRING_TYPE) ?  mapFromTo.get(subProductsObjAux.product_type +'|'+ CONST_STRING_TYPE) : null; //Type__c (Fixa ou Movel).
                        }
                    }    
                }    
            }else{
                identifierFirstValue = getProductName(subscribedProductsObj.identifiers);
                type = mapFromTo.containsKey(subscribedProductsObj.product_type +'|'+ CONST_STRING_TYPE) ? mapFromTo.get(subscribedProductsObj.product_type +'|'+ CONST_STRING_TYPE) : null;//Type__c (Fixa ou Movel).
            }

            legacyAssetId =  identifierFirstValue.contains('+55') ? stringDocument + identifierFirstValue.substring(3, identifierFirstValue.length()) : stringDocument + identifierFirstValue;         

            if(mapAssetForLegacyAssetId.containsKey(legacyAssetId)){

                Asset assetObjAux = mapAssetForLegacyAssetId.get(legacyAssetId);

                if(assetObjAux.vlocity_cmt__BillingAccountId__c != null){
                    mapRecordTypeBillingAccountForName.put(assetObjAux.vlocity_cmt__BillingAccountId__r.Name, type);
                    continue;
                }
            }
                
            mapRecordTypeBillingAccountForName.put(billingAccountNameCreator(subscribedProductsObj,stringDocument), type);
            
        }

        return mapRecordTypeBillingAccountForName;
    }
   
    public static Map<String,Account> billingAccountManager(Map<String, String> mapBillingAccountName,String accountId){
        Map<String,Account> mapBillingAccountForName = new Map<String,Account>();

        List<Account> ltInsertRecords = new List<Account>();
        List<Account> ltExistingBillingAccount = BillingAccountDAO.getByNameOrExternalId(mapBillingAccountName.keySet());
        
        for(Account billingAccountObj :ltExistingBillingAccount){

            if(mapBillingAccountName.containsKey(billingAccountObj.Name) || billingAccountObj.LegacyAccountId__c.contains(billingAccountObj.Name)){
                mapBillingAccountName.remove(billingAccountObj.Name); 
            }
        }
        
        if(!mapBillingAccountName.isEmpty()){
            for(String billingAccountName :mapBillingAccountName.keySet()){
    
                ltInsertRecords.add(new Account(
                        Name = billingAccountName,
                        LegacyAccountId__c = billingAccountName
                        //accountId__c = accountId,
                        //RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get(mapBillingAccountName.get(billingAccountName)).getrecordTypeId()
                    )
                );
            }
    
            if(!ltInsertRecords.isEmpty()){
                insert ltInsertRecords;
                ltExistingBillingAccount.addAll(ltInsertRecords);
            }
        }

        CollectionUtil.loadMap(mapBillingAccountForName,'Name', ltExistingBillingAccount);

        return mapBillingAccountForName;
    }

    public static List<Asset> integrationResponseProcessing(List<SubscribedProductsTO> ltSubscribedProductsObj, Map<String,Account> mapBillingAccountForName, Account accountObj, Map<String, String> mapFromTo){
        List<Asset> ltAsset = new List<Asset>();
        Account billingAccountObj;
        String legacySystem;
        String type;
        String legacyAssetId;

        for(SubscribedProductsTO subscribedProductsObj :ltSubscribedProductsObj){
            
            if(subscribedProductsObj.product_type.contains('value_added_service')){
                continue;
            }

            billingAccountObj = mapBillingAccountForName.get(billingAccountNameCreator(subscribedProductsObj,accountObj.DocumentNumber__c));
                
            if(subscribedProductsObj.product_type.contains('bundle')){

                for(SubscribedProductsTO.SubProducts subProductsObj : subscribedProductsObj.sub_products){  
    
                    if(!subProductsObj.product_type.contains('bundle')){
                        String identifierFirstValue = getProductName(subProductsObj.identifiers);

                        legacySystem = getLegacySystem(mapFromTo,subProductsObj.tags,subscribedProductsObj.tags);
                        type = mapFromTo.containsKey(subProductsObj.product_type +'|'+ CONST_STRING_TYPE) ?  mapFromTo.get(subProductsObj.product_type +'|'+ CONST_STRING_TYPE) : null;
                            
                        ltAsset.add(createAsset(
                            identifierFirstValue, //Name 
                            accountObj.Id,//AccountId 
                            billingAccountObj != null ? billingAccountObj.Id : null,//BillingAccountId 
                            mapFromTo.containsKey(subProductsObj.product_type +'|'+ CONST_STRING_PRODUCTTYPE) ? mapFromTo.get(subProductsObj.product_type +'|'+ CONST_STRING_PRODUCTTYPE) : null,//ProductType__c 
                            type,//Type__c (Fixa ou Movel).
                            subProductsObj.descriptions != null ? subProductsObj.descriptions[0].text : subProductsObj.display_name != null ? subProductsObj.display_name : null,//MainProductDescription__c
                            legacySystem,//LegacySystem__c 
                            subProductsObj.tags != null ? getStringValue(subProductsObj.tags, 'multivivo:') : '',//IsHold
                            subscribedProductsObj.start_date != null ? Date.valueOf(subscribedProductsObj.start_date) : null,//InstallDate 
                            subProductsObj.connection != null ? subProductsObj.connection.downlink_mbps : null,//Speed__c 
                            type == CONST_STRING_FIXA ?  identifierFirstValue : '',//Instance__c 
                            type == CONST_STRING_MOVEL ? identifierFirstValue : '', //PhoneNumber__c
                            accountObj.DocumentNumber__c + identifierFirstValue,//LegacyAssetId__c
                            billingAccountObj != null && billingAccountObj.FullAddress__c != null ?  billingAccountObj.FullAddress__c : null,//Address__c (Não vai usar tirar do create, mantem via carga).
                            subProductsObj.status != null ? subProductsObj.status.capitalize() : CONST_STRING_ACTIVE,
                            subscribedProductsObj.descriptions[0].text != null ? subscribedProductsObj.descriptions[0].text : null, // OfferDescription__c
                            subscribedProductsObj.Id // IdBundle__c
                        ));
                    }
                    
                    if(subProductsObj.product_type != null && subProductsObj.sub_products != null){
    
                        for(SubscribedProductsTO.SubProducts subProductsObjAux :subProductsObj.sub_products){  
                            String identifierFirstValue =  getProductName(subProductsObjAux.identifiers);

                            legacySystem = getLegacySystem(mapFromTo,subProductsObjAux.tags,subProductsObj.tags);
                            type = mapFromTo.containsKey(subProductsObjAux.product_type +'|'+ CONST_STRING_TYPE) ?  mapFromTo.get(subProductsObjAux.product_type +'|'+ CONST_STRING_TYPE) : null;
                                                                                    
                            ltAsset.add(createAsset(
                                identifierFirstValue, //Name 
                                accountObj.Id,//AccountId 
                                billingAccountObj != null ? billingAccountObj.Id : null,//BillingAccountId ?
                                mapFromTo.containsKey(subProductsObjAux.product_type +'|'+ CONST_STRING_PRODUCTTYPE) ? mapFromTo.get(subProductsObjAux.product_type +'|'+ CONST_STRING_PRODUCTTYPE) : null,//ProductType__c 
                                type,//Type__c (Fixa ou Movel).
                                subProductsObjAux.descriptions != null ? subProductsObjAux.descriptions[0].text : subProductsObjAux.display_name != null ? subProductsObjAux.display_name : null,//MainProductDescription__c
                                legacySystem,//LegacySystem__c 
                                subProductsObjAux.tags != null ? getStringValue(subProductsObjAux.tags, 'multivivo:') : '',//IsHold
                                subscribedProductsObj.start_date != null ? Date.valueOf(subscribedProductsObj.start_date) : null,//InstallDate 
                                subProductsObjAux.connection != null ? subProductsObjAux.connection.downlink_mbps : null,//Speed__c 
                                type == CONST_STRING_FIXA ?  identifierFirstValue : '',//Instance__c 
                                type == CONST_STRING_MOVEL ? identifierFirstValue : '', //PhoneNumber__c
                                accountObj.DocumentNumber__c + identifierFirstValue,//LegacyAssetId__c
                                billingAccountObj != null && billingAccountObj.FullAddress__c != null ?  billingAccountObj.FullAddress__c : null,//Address__c (Não vai usar tirar do create, mantem via carga).
                                subProductsObjAux.status != null ? subProductsObjAux.status.capitalize() : CONST_STRING_ACTIVE,
                                subscribedProductsObj.descriptions[0].text != null ? subscribedProductsObj.descriptions[0].text : null, // OfferDescription__c
                                subscribedProductsObj.Id // IdBundle__c
                            ));
                        }
                    }    
                }    
            }else{
                String identifierFirstValue = getProductName(subscribedProductsObj.identifiers);
                type = mapFromTo.containsKey(subscribedProductsObj.product_type +'|'+ CONST_STRING_TYPE) ? mapFromTo.get(subscribedProductsObj.product_type +'|'+ CONST_STRING_TYPE) : null;
                                                    
                ltAsset.add(createAsset(
                    identifierFirstValue, //Name 
                    accountObj.Id,//AccountId 
                    billingAccountObj != null ? billingAccountObj.Id : null,//BillingAccountId ? 
                    mapFromTo.containsKey(subscribedProductsObj.product_type +'|'+ CONST_STRING_PRODUCTTYPE) ? mapFromTo.get(subscribedProductsObj.product_type +'|'+ CONST_STRING_PRODUCTTYPE) : null,//ProductType__c 
                    type,//Type__c (Fixa ou Movel).
                    subscribedProductsObj.descriptions != null ? subscribedProductsObj.descriptions[0].text : subscribedProductsObj.display_name != null ? subscribedProductsObj.display_name : null,//MainProductDescription__c
                    mapFromTo.containsKey(getStringValue(subscribedProductsObj.tags, 'so:') +'|'+ CONST_STRING_LEGACYSYSTEM) ? mapFromTo.get(getStringValue(subscribedProductsObj.tags, 'so:') +'|'+ CONST_STRING_LEGACYSYSTEM) : getStringValue(subscribedProductsObj.tags, 'so:'),//LegacySystem__c 
                    subscribedProductsObj.tags != null ? getStringValue(subscribedProductsObj.tags, 'multivivo:') : 'TIT',//IsHold
                    subscribedProductsObj.start_date != null ? Date.valueOf(subscribedProductsObj.start_date) : null,//InstallDate 
                    subscribedProductsObj.connection != null ? subscribedProductsObj.connection.downlink_mbps : null,//Speed__c 
                    type == CONST_STRING_FIXA ?  identifierFirstValue : '',//Instance__c 
                    type == CONST_STRING_MOVEL ? identifierFirstValue : '', //PhoneNumber__c 
                    accountObj.DocumentNumber__c + identifierFirstValue,//LegacyAssetId__c
                    billingAccountObj != null && billingAccountObj.FullAddress__c != null ?  billingAccountObj.FullAddress__c : null,//Address__c (Não vai usar tirar do create, mantem via carga).
                    subscribedProductsObj.status != null ? subscribedProductsObj.status.capitalize() : CONST_STRING_ACTIVE,
                    subscribedProductsObj.descriptions[0].text != null ? subscribedProductsObj.descriptions[0].text : null, // OfferDescription__c
                    subscribedProductsObj.Id  // IdBundle__c //'Oferta Avulsa'
                ));   
            }
        }

        return ltAsset;
    }

    private static String getProductName(List<String> ltIdentifiers){

        String identifierFirstValue = getFirstValue(ltIdentifiers);
        return identifierFirstValue != null && identifierFirstValue.contains('+55') ? identifierFirstValue.substring(3, identifierFirstValue.length()) : identifierFirstValue;
    }

    private static String getMainProductDescription(SubscribedProductsTO subcribedProductsObj){
        return subcribedProductsObj.descriptions != null ? subcribedProductsObj.descriptions[0].text : subcribedProductsObj.display_name != null ? subcribedProductsObj.display_name : CONST_STRING_BlANKVALUE;
    }

    private static String getFirstValue(List<String> lstStringValue){
        return lstStringValue == null || lstStringValue.isEmpty() ? '' : lstStringValue[0];
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

    private static String getLegacySystem(Map<String, String> mapFromTo,List<String> ltChildRecord, List<String> ltParentRecord){
        String returnValue;

        returnValue = getStringValue(ltChildRecord,'so:');

        if(returnValue == null || returnValue == ''){
            returnValue = getStringValue(ltParentRecord,'so:');
        }   
        
        return mapFromTo.containsKey(returnValue +'|'+ CONST_STRING_LEGACYSYSTEM) ? mapFromTo.get(returnValue +'|'+ CONST_STRING_LEGACYSYSTEM) : returnValue;
    } 

    private static Asset createAsset(String name, Id accountId, Id billingAccountId, String productType, String type, String mainProductDescription, String legacySystem, String isHold,  Date installDate, String speed, String instance, String phoneNumber, String idExterno, Id address, String status, String offerDescription, String idBundle){
        Asset assetObj = new Asset();
        assetObj.Name = name;
        assetObj.AccountId = accountId;
        assetObj.ProductType__c = productType; 
        assetObj.Type__c = type;
        //assetObj.RecordTypeId = Schema.SObjectType.Asset.getRecordTypeInfosByDeveloperName().get(type).getrecordTypeId();
        assetObj.MainProductDescription__c = mainProductDescription != null ? mainProductDescription.toUpperCase() : assetObj.MainProductDescription__c;
        assetObj.LegacySystem__c = legacySystem != null ? legacySystem.toUpperCase() : assetObj.LegacySystem__c;
        assetObj.IsHolder__c = isHold != null && isHold.length() > 3 ? isHold.substring(0,3).toUpperCase() : CONST_STRING_TITULAR;
        assetObj.InstallDate = installDate;
    	assetObj.Status = status;
    	assetObj.OfferDescription__c = offerDescription;
    	assetObj.IdBundle__c = idBundle;
        
        if(speed != null){
            assetObj.Speed__c = speed;
        }
        
        if(instance != ''){
            assetObj.Instance__c = instance;
        }

        if(phoneNumber != ''){
            assetObj.PhoneNumber__c = phoneNumber;
        }
        
        if(idExterno != null){
            assetObj.LegacyAssetId__c  = idExterno;
        }
        if(billingAccountId != null){
            assetObj.vlocity_cmt__BillingAccountId__c = billingAccountId;
        }

        /* if(address != null){
            assetObj.Address__c = address;
        } */

        return assetObj;
    }

    private static String billingAccountNameCreator(SubscribedProductsTO subscribedProductsObj, String stringDocument){
        String stringReturn = '';

        if(subscribedProductsObj.id != null){

            String mainProductDescription  = getMainProductDescription(subscribedProductsObj);
           
            if(mainProductDescription != null && mainProductDescription != '' && (mainProductDescription.toUpperCase().contains(CONST_STRING_CONTROLE) || mainProductDescription.toUpperCase().contains(CONST_STRING_EASY)) && ( subscribedProductsObj.subscription_type == CONST_STRING_CONTROL || subscribedProductsObj.subscription_type == CONST_STRING_PREPAID)){
                stringReturn =  stringDocument+'-CONTROLE';
            }
            
            if(stringReturn == ''){
                stringReturn = validateBillingAccountName(subscribedProductsObj.id) ? Util.getNumbers(subscribedProductsObj.id) : subscribedProductsObj.id;
            }
        }

        return stringReturn;
    }

    public static Boolean validateBillingAccountName(String billingAccountName){

        Pattern objPattern = Pattern.compile('^[A-Za-z]{2}\\d+');
        Matcher objMatcher = objPattern.matcher(billingAccountName);

        return objMatcher.find();
    }

    public static SubscribedProductsTO.ReturnTO createObjectReturn(String status, string message){
        SubscribedProductsTO.ReturnTO returnValue = new SubscribedProductsTO.ReturnTO();

        returnValue.status = status;
        returnValue.message = message;

        return returnValue;
    }

    public static string getClientType(List<SubscribedProductsTO> ltSubscribedProductsObj, Map<String, String> mapFromTo, Id accountId){
        
        Set<String> setType = new Set<String>();
        String type;
        Map<String,Set<String>> mapListTypeForAccountId = new Map<String,Set<String>>();
        mapListTypeForAccountId.put(accountId,new Set<String>());

        for(SubscribedProductsTO subscribedProductsObj :ltSubscribedProductsObj){
            
            if(subscribedProductsObj.product_type.contains('value_added_service')){
                continue;
            }

            if(subscribedProductsObj.product_type.contains('bundle')){

                for(SubscribedProductsTO.SubProducts subProductsObj : subscribedProductsObj.sub_products){  
    
                    if(!subProductsObj.product_type.contains('bundle')){
                        type = mapFromTo.containsKey(subProductsObj.product_type +'|'+ CONST_STRING_TYPE) ?  mapFromTo.get(subProductsObj.product_type +'|'+ CONST_STRING_TYPE) : null;//Type__c (Fixa ou Movel).
                        setType.add(type);
                    }
                    
                    if(subProductsObj.product_type != null && subProductsObj.sub_products != null){
                        
                        for(SubscribedProductsTO.SubProducts subProductsObjAux :subProductsObj.sub_products){  
                            type = mapFromTo.containsKey(subProductsObjAux.product_type +'|'+ CONST_STRING_TYPE) ?  mapFromTo.get(subProductsObjAux.product_type +'|'+ CONST_STRING_TYPE) : null; //Type__c (Fixa ou Movel).
                            setType.add(type);
                        }
                    }    
                }    
            }else{
                
                type = mapFromTo.containsKey(subscribedProductsObj.product_type +'|'+ CONST_STRING_TYPE) ? mapFromTo.get(subscribedProductsObj.product_type +'|'+ CONST_STRING_TYPE) : null;//Type__c (Fixa ou Movel).

                if(type == CONST_STRING_MOVEL && subscribedProductsObj.subscription_type != null && subscribedProductsObj.subscription_type == CONST_STRING_PREPAID && subscribedProductsObj.display_name != null && !subscribedProductsObj.display_name.toUpperCase().contains(CONST_STRING_CONTROLE) && !subscribedProductsObj.display_name.toUpperCase().contains(CONST_STRING_EASY)){
                    type = 'Pré';
                }

                setType.add(type);
            }
        }

        String customerType  = mapFromTo.get(getStringSorted(new List<String>(setType)));
 
        return customerType != null ? customerType : ''; 
    }

    private static String getStringSorted(List<String> lstStringValue){
        String stringValue;

        if(!lstStringValue.isEmpty()){

            lstStringValue.sort();
            stringValue = String.join(lstStringValue,',');
        }

        return stringValue;
    }
}