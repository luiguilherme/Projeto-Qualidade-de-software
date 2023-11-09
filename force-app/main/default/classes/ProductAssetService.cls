/*
 * Class created to update line Asset with values received from RM and SmartSIM
 * Related IP: valProductDetailsPromotionService
 * @date: 19/09/2023
 * @Author: Diogo Sousa
 */
global class ProductAssetService implements vlocity_cmt.VlocityOpenInterface2 {
	public class applicationException extends Exception {}
    //Esse mapa será o 'de para' dos nomes do serviço -> attribute
    private static Map<String, String> mapServiceAttribute {
        get {
            if (mapServiceAttribute == null) {
                mapServiceAttribute = new Map<String, String>{
                    	'IntCallCenter' => 'ATT_DT_INTERCEPTACAO_URA_CADASTRO',//Não encontrei o atributo desse cara
                        'bina' => 'ATT_RT_SRV_BINA',	
                        'roaming' => 'ATT_RT_ROAMING', //Colocar switch case quando os valores for 0,1,2, 3
                        'ldCall'=> 'ATT_DT_SRV_LD_CALL',//Necessário fazer lógica para pegar valor do serviceCharac
                        'svcCxPostal'=> 'ATT_RT_SRV_CX_POSTAL',
                        'svcVivoAvisa'=> 'ATT_RT_SRV_VIVO_AVISA',
                        'smso'=> 'ATT_DT_SRV_SMS_O',
                        'smst'=> 'ATT_DT_SRV_SMS_T',
                        'collCall'=> 'ATT_RT_SRV_COLL_CALL',
                        'conference'=> 'ATT_RT_SRV_VOICE_CONFERENCE',
                        'callWait'=> 'ATT_RT_SRV_CALL_WAIT',
                        'callFwd'=> 'ATT_RT_SRV_CALL_FWD',
                        'dataBlock' => 'ATT_DT_BLOQUEIO_DADOS',
                        'svaBundleSvc' => 'ATT_DT_BLOQUEIO_DADOS',//ver como armazenar dois atributos
                        'trfDataFreeFire' => 'ATT_DT_TRAFEGO_APP_GAMES', //verificar qual e esse
                        'trfDataVivoNoite' => 'ATT_DT_TRAFEGO_INTERNET_NOITE',
                        'trfDataSocial' => 'ATT_DT_TRAFEGO_APP_REDES_SOCIAIS',
                        'trfDataEssenc' => 'ATT_DT_TRAFEGO_APP_ESSENCIAIS',
                        'trfDataMsgs' => 'ATT_DT_TRAFEGO_APP_MENSAGENS',
                        'volte' => 'ATT_RT_SRV_VOLTE'
                };
            }
            
            return mapServiceAttribute;
        }
        set;
    }
    
    global Boolean invokeMethod(String methodName, Map<String, Object> inputMap, Map<String, Object> outputMap, Map<String, Object> optionMap) {

        System.debug('methodName: ' + methodName);
		System.debug('inputMap: ' + json.serialize(inputMap));
		System.debug('outputMap: ' + json.serialize(outputMap));
		System.debug('optionMap: ' + json.serialize(optionMap));

        Boolean success = true;
        String errors;
        
        try {
            Map<String, Asset> mapCurrentAsset = new Map<String, Asset>();
            String accountId = String.valueOf(inputMap.get('accountId'));
            
            for(Asset assetCurrent : [SELECT Id, Status, Product2.vlocity_cmt__SubType__c, LegacyIdentifier__c, vlocity_cmt__ServiceIdentifier__c,StartDateTime__c, EndDateTime__c, vlocity_cmt__AttributeSelectedValues__c FROM Asset WHERE AccountId =: accountId]){ 
                if(!String.isBlank(assetCurrent.LegacyIdentifier__c)){
                    String legacyIdenfierCurrent = assetCurrent.LegacyIdentifier__c.substring(0,assetCurrent.LegacyIdentifier__c.length()-3);
                    System.debug('legacyIdenfierCurrent: '+legacyIdenfierCurrent);
                	mapCurrentAsset.put(legacyIdenfierCurrent, assetCurrent);
                }
            }
            System.debug('passou do for');
            if(mapCurrentAsset.values().isEmpty()){
                throw new applicationException('Não existe ativos dessa linha na base Salesforce.');
            }
            
            switch on methodName {
                when 'updateProduct' {
                    updateProduct(inputMap, outputMap, mapCurrentAsset); 
                }
                when 'updateService' {
                    updateService(inputMap, outputMap, mapCurrentAsset); 
                }
            }

        } catch(Exception e) {
            errors = e.getMessage(); 
            success = false;
        }

        outputMap.put('success', success);
        outputMap.put('error', errors);

        return success;
    }
                  
    /*
     * Method to update Asset Service
     * @Author: Diogo Sousa
     */
    public static void updateService(Map<String, Object> inpMap, Map<String, Object> outMap, Map<String, Asset> mapCurrentAsset){
        //inputs iniciais
        ServiceRelationshipWrapper serviceAssetWrapper = (ServiceRelationshipWrapper) JSON.deserialize(JSON.serialize(inpMap), ServiceRelationshipWrapper.class);
        Map<String, Asset> mapJsonUpdatedService = new Map<String, Asset>();
        
        if(serviceAssetWrapper.listServiceRelationship.isEmpty()){
            System.debug('Não tem serviços para atualização');
            return;
        }

        System.debug('serviceAssetWrapper: '+serviceAssetWrapper);
        System.debug('jsonProducts: '+serviceAssetWrapper.listServiceRelationship);
        
        //contem a os produtos e a lista de serviços desses produtos
        List<ServiceRelationship> listServiceRelationship = serviceAssetWrapper.listServiceRelationship;
        
        for(ServiceRelationship itemService : listServiceRelationship){
            System.debug('Antes');
			System.debug('itemService.Id: '+itemService.Id);
            //conficional para pegar o os dados do Salesforce com o idExterno
            String legacyIdentifierId = itemService.Id;
            if(itemService.Id != null && itemService.Id.length() > 17)
            	legacyIdentifierId = itemService.Id == 'defaultContract' ? 'defaultContract' : itemService.Id.substring(0,18);
            
            if(mapCurrentAsset.containsKey(legacyIdentifierId)){
                System.debug('Entrou no if');
                //montar lógica para atualizar dados do serviço do Asset
                mapJsonUpdatedService.put(legacyIdentifierId, updateAttributeSelectedValues(itemService.service, mapCurrentAsset.get(itemService.Id)));                
            }else if(legacyIdentifierId == 'defaultContract'){
                Asset objAsset;
                for(Asset assetItem : mapCurrentAsset.values()){
                    if(assetItem.Product2.vlocity_cmt__SubType__c == 'Plan'){
                        objAsset = assetItem;
                    }
                }
                System.debug('objAsset.LegacyIdentifier__c: '+ objAsset.LegacyIdentifier__c);
				System.debug('itemService.serviceAsset: '+itemService.service);
                mapJsonUpdatedService.put(objAsset.LegacyIdentifier__c, updateAttributeSelectedValues(itemService.service, objAsset));
            }
        }

        System.debug('json map');
        //System.debug(JSON.serializePretty(mapCurrentAsset.values()));
        if(!Test.isRunningTest())
        	update mapJsonUpdatedService.values();
    }	
    
    private static Asset updateAttributeSelectedValues(List<Service> listServiceAsset, Asset itemAsset){
        String nameAttributeService;
        Map<String, Object> mapJson = (Map<String, Object>)JSON.deserializeUntyped(itemAsset.vlocity_cmt__AttributeSelectedValues__c);
        //Map<String, String> mapJsonUpdatedService = new Map<String, String>();

        for(Service itemServiceAsset : listServiceAsset){
            if(mapServiceAttribute.containsKey(itemServiceAsset.id)){
                nameAttributeService = mapServiceAttribute.get(itemServiceAsset.id);
                System.debug('nameAttributeService: '+JSON.serialize(nameAttributeService));
                if(nameAttributeService == null) continue;
                    
                if(mapJson.containsKey(nameAttributeService)){
                    System.debug('Enrou no IF');
                    String newStatus;
                    if(itemServiceAsset.id == 'roaming' || itemServiceAsset.id == 'ldCall'){
                        String valueType = itemServiceAsset.serviceCharacteristic[0].value;
                        switch on valueType {
                            when '0' {		
                                newStatus = 'LocalCallRoaming';
                            }
                            when '1' {		  
                                newStatus = 'NationalRoaming';
                            }
                            when '2' {		  
                                newStatus = 'NationalInternationalRoaming';
                            }
                        }
                    }else{
                        switch on itemServiceAsset.status {
                            when 'A'{		
                                newStatus = 'Yes';
                            }	
                            when 'C' {		
                                newStatus = 'No';
                            }
                        }
                    }
                    mapJson.put(nameAttributeService, newStatus);
                    //mapJsonUpdatedService.put(nameAttributeService, newStatus);
                } 
            }
        }
        //System.debug('maoJson: '+JSON.serialize(mapJsonUpdatedService));
        //itemAsset.vlocity_cmt__AttributeSelectedValues__c = JSON.serialize(mapJsonUpdatedService);
        itemAsset.vlocity_cmt__AttributeSelectedValues__c = JSON.serialize(mapJson);
        return itemAsset;
    }
    
    /*
     * Method to update Promotion, Plan and Package
     * @Author: Diogo Sousa
     */
    public static void updateProduct(Map<String, Object> inpMap, Map<String, Object> outMap, Map<String, Asset> mapCurrentAsset){
        System.debug('inicio');
        
        ProductsAssetWrapper assetWrapper = (ProductsAssetWrapper) JSON.deserialize(JSON.serialize(inpMap), ProductsAssetWrapper.class);
        System.debug('assetWrapper: '+assetWrapper);
        System.debug('serviceIdentifier: '+assetWrapper.serviceIdentifier);
        System.debug('jsonProducts: '+assetWrapper.jsonProducts);
        List<ProductAsset> listProductsAsset = assetWrapper.jsonProducts;
		
        if(listProductsAsset.isEmpty()){
            throw new applicationException('Não existe produtos para atualização.');
        }
        for(ProductAsset itemProduct : listProductsAsset){
            //fazer de para dos produtos do Asset da base e da lista de produtos
            System.debug('Antes');
			System.debug('itemProduct.Id: '+itemProduct.Id);
            if(mapCurrentAsset.containsKey(itemProduct.Id)){
                System.debug('Entrou no if');
                Asset newAsset = mapCurrentAsset.get(itemProduct.Id);
                if(itemProduct.validfor.startDateTime != null){
                    newAsset.StartDateTime__c = (DateTime)JSON.deserialize('"' + itemProduct.validfor.startDateTime + '"', DateTime.class);
                }
                if(itemProduct.validfor.endDateTime != null){
                    newAsset.EndDateTime__c = (DateTime)JSON.deserialize('"' + itemProduct.validfor.endDateTime + '"', DateTime.class);
                }
                newAsset.Status = itemProduct.status == 'ProductActive'? 'Active' : 'Inactive';
                mapCurrentAsset.put(itemProduct.Id, newAsset);
            }
        }
        System.debug('json map');
        System.debug(JSON.serializePretty(mapCurrentAsset.values()));
        if(!Test.isRunningTest())
        	update mapCurrentAsset.values();
        
        System.debug('Asset Atualizado.');
    }
    
    /* 
     * Format json received from products(Promotion, Plan and Package) from RM response
     * @Author: Diogo Sousa
     */ 
    class ProductsAssetWrapper {
        String serviceIdentifier;
        String accountId;
        List<ProductAsset> jsonProducts;
    }
    
    class ProductAsset {
        public String id;
        public String productSpecificationId;
        public String name;
        public String status;
        public String productCode;
        public ValidFor validfor;
    }
    
    class ValidFor {
        String startDateTime;
        String endDateTime;
    }
    
    /* 
     * Format json received from products(Promotion, Plan and Package) from SmartSIM response
     * @Author: Diogo Sousa
     */
    class ServiceRelationshipWrapper {
        String serviceIdentifier;
        String accountId;
        List<ServiceRelationship> listServiceRelationship;
    }
    
    class ServiceRelationship {
        String relationshipType;
        String id;
        String processingDateTime;
        String requestDateTime;
        String deactivationDateTime;
        String activationDateTime;
        String creationDateTime;
        String status;
        String externalId;
        String reason;
        String name;
        List<ServiceCharacteristic> serviceCharacteristic;
        List<Service> service;        
    }
    
    class Service {
        String id;
        String name;
        String status;
        String value;
        List<ServiceCharacteristic> serviceCharacteristic;
    }
    
    class ServiceCharacteristic {
        String name;
        String value;
    }
   
}