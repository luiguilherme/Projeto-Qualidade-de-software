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
    
    private static Map<String, String> mapServiceAttributeByName {
        get {
            if (mapServiceAttributeByName == null) {
                mapServiceAttributeByName = new Map<String, String>{
                    	'IntCallCenter' => 'ATT_DT_INTERCEPTACAO_URA_CADASTRO',//Não encontrei o atributo desse cara
                        'Identificador de Chamada (Bina)' => 'ATT_RT_SRV_BINA',	
                        'Roaming' => 'ATT_RT_ROAMING', //Colocar switch case quando os valores for 0,1,2, 3
                        'Chamada Longa Distância'=> 'ATT_DT_SRV_LD_CALL',//Necessário fazer lógica para pegar valor do serviceCharac
                        'Caixa Postal'=> 'ATT_RT_SRV_CX_POSTAL',
                        'Vivo Avisa'=> 'ATT_RT_SRV_VIVO_AVISA',
                        'Originação de SMS (Envio)'=> 'ATT_DT_SRV_SMS_O',
                        'Terminação de SMS (Recebimento)'=> 'ATT_DT_SRV_SMS_T',
                        'Recebimento de Chamadas a  Cobrar'=> 'ATT_RT_SRV_COLL_CALL',
                        'Serviço de Conferência de Voz'=> 'ATT_RT_SRV_VOICE_CONFERENCE',
                        'Chamada em Espera'=> 'ATT_RT_SRV_CALL_WAIT',
                        'Siga-me (Encaminhamento de chamadas)'=> 'ATT_RT_SRV_CALL_FWD',
                        'Bloqueio de Dados' => 'ATT_DT_BLOQUEIO_DADOS',
                        'Tráfego de APP Games' => 'ATT_DT_TRAFEGO_APP_GAMES', //verificar qual e esse
                        'Tráfego de Vivo Internet Noite' => 'ATT_DT_TRAFEGO_INTERNET_NOITE',
                        'Tráfego de APP Redes Sociais' => 'ATT_DT_TRAFEGO_APP_REDES_SOCIAIS',
                        'Tráfego de APP Essenciais' => 'ATT_DT_TRAFEGO_APP_ESSENCIAIS',
                        'Tráfego de APP Mensagens' => 'ATT_DT_TRAFEGO_APP_MENSAGENS',
                        'VOLTE' => 'ATT_RT_SRV_VOLTE',
                        'Serviço 5G SA' => 'ATT_DT_5G_SA'
                };
            }
            
            return mapServiceAttributeByName;
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
            switch on methodName {
                when 'updateService' {
                    updateService(inputMap, outputMap); 
                }
                when 'updateServiceByAPI' {
                    updateServiceByAPI(inputMap, outputMap); 
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
    public static void updateService(Map<String, Object> inpMap, Map<String, Object> outMap){
        Map<String, Asset> mapCurrentAsset = new Map<String, Asset>();
        String accountId = String.valueOf(inpMap.get('accountId'));
        
        for(Asset assetCurrent : [SELECT Id, ExternalId__c, Product2Id, LegacyIdentifier__c,Name,vlocity_cmt__AttributeSelectedValues__c,AccountId,StartDate__c
            FROM Asset WHERE AccountId =: accountId]){ 
            if(!String.isBlank(assetCurrent.LegacyIdentifier__c)){
                String legacyIdenfierCurrent = assetCurrent.LegacyIdentifier__c.substring(0,assetCurrent.LegacyIdentifier__c.length()-3);
                System.debug('legacyIdenfierCurrent: '+legacyIdenfierCurrent);
                mapCurrentAsset.put(legacyIdenfierCurrent, assetCurrent);
            }
        }
        System.debug('passou do for');
        
        if(mapCurrentAsset.values().isEmpty()) throw new applicationException('Não existe ativos dessa linha na base Salesforce.');
        
        ServiceRelationshipWrapper serviceAssetWrapper = (ServiceRelationshipWrapper) JSON.deserialize(JSON.serialize(inpMap), ServiceRelationshipWrapper.class);
        Map<String, Asset> mapJsonUpdatedService = new Map<String, Asset>();
        System.debug(JSON.serialize(serviceAssetWrapper));
        if(serviceAssetWrapper.listServiceRelationship.isEmpty()){
            System.debug('Não tem serviços para atualização');
            return;
        }

        System.debug('serviceAssetWrapper: '+serviceAssetWrapper);
        System.debug('jsonProducts: '+serviceAssetWrapper.listServiceRelationship);
        System.debug('mapCurrentAsset: '+mapCurrentAsset.values());
        
        //contem a os produtos e a lista de serviços desses produtos
        List<ServiceRelationship> listServiceRelationship = serviceAssetWrapper.listServiceRelationship;
        
        for(ServiceRelationship itemService : listServiceRelationship){
            System.debug('Antes');
			System.debug('itemService.Id: '+itemService.Id);
            //conficional para pegar o os dados do Salesforce com o idExterno
            String legacyIdentifierId = itemService.Id;
            if(itemService.Id != null && itemService.Id.length() > 17)
            	legacyIdentifierId = itemService.Id == 'defaultContract' ? 'defaultContract' : itemService.Id.substring(0,15);
            System.debug('legacyIdentifierId: '+legacyIdentifierId);
            System.debug(mapCurrentAsset.keySet());
            System.debug(mapCurrentAsset.containsKey(legacyIdentifierId));
            if(mapCurrentAsset.containsKey(legacyIdentifierId)){
                System.debug('Entrou no if');
                //montar lógica para atualizar dados do serviço do Asset
                mapJsonUpdatedService.put(legacyIdentifierId, updateAttributeSelectedValues(itemService.service, mapCurrentAsset.get(legacyIdentifierId)));                
            }else if(legacyIdentifierId == 'defaultContract'){
                Asset objAsset = new Asset();
                for(Asset assetItem : mapCurrentAsset.values()){
                    System.debug('subtype: '+assetItem.Product2.vlocity_cmt__SubType__c);
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
        System.debug(itemAsset);
        String nameAttributeService;
        Map<String, Object> mapJson = (Map<String, Object>)JSON.deserializeUntyped(itemAsset.vlocity_cmt__AttributeSelectedValues__c);
        Map<String, String> mapJsonUpdatedService = new Map<String, String>();

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
                    
                    mapJsonUpdatedService.put(nameAttributeService, newStatus);
                } 
            }
        }
        System.debug('maoJson: '+JSON.serialize(mapJsonUpdatedService));
        itemAsset.vlocity_cmt__AttributeSelectedValues__c = JSON.serialize(mapJsonUpdatedService);
        return itemAsset;
    }

    /*
     * Method to update Asset Service by API Product Ordering
     * @Author: Diogo Sousa
     */
    public static void updateServiceByAPI(Map<String, Object> inpMap, Map<String, Object> outMap){
		System.debug('API Product Ordering');
        InputsIPWrapper inputsAPI = (InputsIPWrapper) JSON.deserialize(JSON.serialize(inpMap), InputsIPWrapper.class);
        
        System.debug('deserilize');
        //busca ativos do tipo Plan apenas
        ProductModel productAPI = inputsAPI.product;
        Map<String, Object> mapJson = (Map<String, Object>)JSON.deserializeUntyped(inputsAPI.attributeSelectedValues);
        
        String nameAttributeService;
        System.debug('map json');
        for(ServiceCharacteristic itemService : productAPI.productCharacteristic){
            System.debug('entrou no for: '+itemService.name);
            if(mapServiceAttributeByName.containsKey(itemService.name)){
                nameAttributeService = mapServiceAttributeByName.get(itemService.name);
                System.debug('nameAttributeService: '+JSON.serialize(nameAttributeService));
                
                if(nameAttributeService == null) continue;
                
                mapJson.put(nameAttributeService, itemService.value);
            }
        }
        Asset assetUpdate = new Asset();
        assetUpdate.Id = inputsAPI.assetId;
        assetUpdate.vlocity_cmt__AttributeSelectedValues__c = JSON.serialize(mapJson);
		
        System.debug(JSON.serializePretty(mapJson));
        System.debug(assetUpdate.vlocity_cmt__AttributeSelectedValues__c);
        System.debug(JSON.serializePretty(assetUpdate));
        System.debug('tudo ok para atualizar');
        
        if(!Test.isRunningTest())
            update assetUpdate;
    }

    /* 
     * Model Request Product Ordering
     * @Author: Diogo Sousa
     */
    class InputsIPWrapper{
        String assetId;
        String attributeSelectedValues;
		ProductModel product;
    }	

    class ProductModel{
        String msisdn;
        List<ServiceCharacteristic> productCharacteristic;
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