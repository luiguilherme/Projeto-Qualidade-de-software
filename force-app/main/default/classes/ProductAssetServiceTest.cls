@isTest
private class ProductAssetServiceTest {

     @testSetup 
    static void setup() {
    	Account billingAcc = new Account(Name = 'Billing Account',
                                    RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Billing').getrecordTypeId(),
                                    DocumentNumber__c = '12345678910'
        );
        insert billingAcc;

        Account acc = new Account(Name = 'Account',
                                    BillingAccount__c = billingAcc.Id,
                                    DocumentNumber__c = '12345678910'
        );
        insert acc;
        
        Product2 prod = new Product2();
        prod.vlocity_cmt__SubType__c = 'Plan';
        prod.name = 'teste produto';
        insert prod;
        
        
        List<Asset> lstAssets = new List<Asset>();
        Asset asset = new Asset(ExternalId__c ='12345678910TV-SPO-81HLO8DAN-050',
                                StartDate__c = Datetime.now(),
                                accountId = acc.id,
                                vlocity_cmt__ServiceIdentifier__c = '11999999999',
                                vlocity_cmt__AttributeSelectedValues__c = '{"ATT_DT_DATAPACK":null,"ATT_DATASHARE":"No","ATT_DT_ROLLOVER":"No","ATT_DT_INCLUDED_VAS":"GoRead + Vivo Recado + Vivo Avisa","ATT_DT_SMS_ON_NET":"300","ATT_DT_SMS_OFF_NET":"15","ATT_DT_VOICE_ON_NET":"1440","ATT_DT_VOICE_OFF_NET":"30","ATT_DT_OPENING_BALANCE":10,"ATT_RT_ME_LIGA":"Yes","ATT_RT_IP_TYPE":"Public","ATT_RT_ROAMING":"NationalInternationalRoaming","ATT_RT_SRV_VOLTE":"No","ATT_RT_SRV_CX_POSTAL":"Yes","ATT_RT_SRV_VIVO_AVISA":"No","ATT_DT_SRV_SMS_O":"Yes","ATT_DT_SRV_SMS_T":"Yes","ATT_RT_SRV_COLL_CALL":"No","ATT_RT_SRV_VOICE_CONFERENCE":"No","ATT_RT_SRV_CALL_WAIT":"Yes","ATT_RT_SRV_CALL_FWD":"No","ATT_RT_SRV_BINA":"Yes","ATT_DT_TRAFEGO_APP_MENSAGENS":"No","ATT_DT_SRV_LD_CALL":"NationalInternationalCall","ATT_DT_TRAFEGO_APP_REDES_SOCIAIS":"No","ATT_DT_TRAFEGO_INTERNET_NOITE":"No","ATT_DT_TRAFEGO_APP_ESSENCIAIS":"No","ATT_DT_TRAFEGO_APP_GAMES":"No","ATT_DT_VOICE_ON_NET_FIXO":null,"ATT_DT_VOICE_ON_NET_MOVEL":null,"ATT_DT_HAS_TASTING_RECURRENCY":null,"ATT_DT_HAS_TASTING":null,"ATT_DT_MUST_WAIT_FIRST_REFILL":null,"ATT_RT_DISPLAY_PRICE":"R$ 2,49","ATT_DT_DURATION":1,"ATT_DT_DURATION_UOM":"Days","ATT_DT_HAS_AUTOMATIC_RECURRENCY":"No","ATT_RT_VALUE_IN_TASTING":null,"ATT_DT_AVISO_NUMERO_ALTERADO":null,"ATT_DT_BLOQUEIO_DADOS":null,"ATT_DT_SERVICO_CAIXA_POSTAL":null,"ATT_DT_SIGA_ME":null,"ATT_DT_CHAMADAS_A_COBRAR":null,"ATT_DT_MSG_CAIXA_POSTAL":null,"ATT_DT_CHAMADA_DADOS":null,"ATT_DT_CONFERENCIA_CHAMADAS":null,"ATT_DT_INTERCEPTACAO_URA_CADASTRO":null,"ATT_DT_SERVICO_ME_LIGA":null,"ATT_DT_VOLTE_4G":null,"ATT_DT_ENVIO_MMS":null,"ATT_DT_COMPRA_SVA":null,"ATT_DT_BINA":null,"ATT_DT_NOTIFICACAO_SALDO":null,"ATT_DT_ORIGINAÇÃO_CHAMADAS_VOZ":null,"ATT_DT_ROAMING_CHAMADAS_VOZ":null,"ATT_DT_5G_SA":"No","ATT_DC_RM_PLAN_PO_3_NAME":"Vivo Pré Diário","ATT_DC_RM_PLAN_PO_1":"PO_C_PRIME_PD_WITH_SVA_XX","ATT_DC_RM_PLAN_PO_2":"PO_C_PRIME_PD_VOICE_OFFNET_WITH_SVA_XX","ATT_DC_RM_PLAN_PO_3":"PO_C_PRIME_PD0_WITH_SVA_XX","ATT_DC_RM_PLAN_PO_4":"PO_C_PRIME_PD0_VOICE_OFFNET_WITH_SVA_XX","ATT_DC_RM_PLAN_PO_1_NAME":"Vivo Pré Diário","ATT_DC_RM_PLAN_PO_2_NAME":"Vivo Pré Diário Voz OffNet","ATT_DC_RM_PLAN_PO_4_NAME":"Vivo Pré Diário Voz OffNet","ATT_DC_RM_BASIC_TARIF_PO_1":"PO_C_PAYG_INI_XX","ATT_DC_RM_BASIC_TARIF_PO_1_NAME":"Oferta PAYG INI","ATT_DC_RM_BASIC_TARIF_PO_2":"PO_C_PAYG_NO_INI_XX","ATT_DC_RM_BASIC_TARIF_PO_2_NAME":"Oferta PAYG No INI"}',
                                name = 'TestClass',
                                LegacyIdentifier__c = '80276000005vlnJAAQ',
                                Product2Id = prod.Id
        );
        lstAssets.add(asset);       
                
        insert lstAssets;
    }
    
    @isTest
    static void testUpdateService() {
        Account acc = [SELECT Id, Name FROM Account WHERE Name = 'Account' LIMIT 1];
        System.debug('account: '+acc);
        
		Service itemService = new Service();
        itemService.id = 'volte';
        itemService.name = 'Servico VOLTE';
        itemService.status = 'A';
        
        Service itemService2 = new Service();
        itemService2.id = 'IntCallCenter';
        itemService2.name = 'Interceptacao para Cadastro';
        itemService2.status = 'C';

        ServiceCharacteristic characteristic = new ServiceCharacteristic();
        characteristic.name = 'contractName'; 
        characteristic.value = 'contrato Default';
        
        ServiceRelationship listServices = new ServiceRelationship();
        listServices.id = '80276000005vlnJAAQ';
        listServices.name = 'default Contract';
        listServices.status = 'Active';
        listServices.creationDateTime = '2023-05-04T17:08:26.262Z';
        listServices.deactivationDateTime = '';
        listServices.serviceCharacteristic = new List<ServiceCharacteristic>{characteristic};
        listServices.service = new List<Service>{itemService, itemService2};
        
  
        Map<String, Object> inputMap = new Map<String, Object>{
			'serviceIdentifier' => '11999999999',
            'accountId' => acc.Id,
                'listServiceRelationship' => new List<ServiceRelationship>{listServices}
        };
        Map<String, Object> outputMap = new Map<String, Object>();
        Map<String, Object> optionMap = new Map<String, Object>();

        // Chame o método da classe ProductAssetService que você deseja testar
        ProductAssetService pas = new ProductAssetService();
        
        Boolean success = pas.invokeMethod('updateService', inputMap, outputMap, optionMap);

        // Realize as asserções para verificar se o método funcionou corretamente
        //System.assertEquals(true, success);
    }
    
    @isTest
    static void testUpdateServiceByAPI() {
        Asset assetItem = [SELECT Id, Name,vlocity_cmt__AttributeSelectedValues__c  FROM Asset WHERE LegacyIdentifier__c = '80276000005vlnJAAQ' LIMIT 1];
        
        ServiceCharacteristic characteristic = new ServiceCharacteristic();
        characteristic.name = 'Serviço 5G SA'; 
        characteristic.value = 'Yes';
        
        ProductModel products = new ProductModel();
        products.msisdn = '11999999999';
        products.productCharacteristic = new List<ServiceCharacteristic>{characteristic}; 
        
        ProductAssetService pas = new ProductAssetService();
        Map<String, Object> inputMap = new Map<String, Object>{
			'serviceIdentifier' => '11999999999',
            'attributeSelectedValues' => assetItem.vlocity_cmt__AttributeSelectedValues__c,
                'product' => products
        };
        Map<String, Object> outputMap = new Map<String, Object>();
        Map<String, Object> optionMap = new Map<String, Object>();
        Boolean success = pas.invokeMethod('updateServiceByAPI', inputMap, outputMap, optionMap);

        // Realize as asserções para verificar se o método funcionou corretamente
        System.assertEquals(true, success);

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
    
    class InputsIPWrapper{
        String assetId;
        String attributeSelectedValues;
		ProductModel product;
    }
    
    class ProductModel{
        String msisdn;
        List<ServiceCharacteristic> productCharacteristic;
    }
}