@isTest
public with sharing class MergeAssetControllerTest {

    @TestSetup
    static void makeData(){
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

        List<Asset> lstAssets = new List<Asset>();
        Asset asset = new Asset(ExternalId__c ='12345678910TV-SPO-81HLO8DAN-050',
                                StartDate__c = Datetime.now().addDays(-3),
                                accountId = acc.id,
                                name = 'TV-SPO-81HLO8DAN-050',
                                vlocity_cmt__ServiceIdentifier__c = 'TV-SPO-81HLO8DAN-050'
        );
        lstAssets.add(asset);
        
        asset = new Asset(ExternalId__c='12345678910SPO-81HLO8VKZ-013',
                                StartDate__c = Datetime.now().addDays(-3),
                                accountId = acc.id,
                                name = 'SPO-81HLO8VKZ-013',
                                vlocity_cmt__ServiceIdentifier__c = 'SPO-81HLO8VKZ-013'       
        );
        lstAssets.add(asset);
        
        asset = new Asset(ExternalId__c='123456789101148696484',
                                StartDate__c = Datetime.now().addDays(-3),
                                accountId = acc.id,
                                name = '1148696484',
                                vlocity_cmt__ServiceIdentifier__c = '1148696484'    
        );
        lstAssets.add(asset);

        asset = new Asset(ExternalId__c='1234567891041992718689',
                                StartDate__c = Datetime.now().addDays(-3),
                                accountId = acc.id,
                                name = '41992718689',
                                vlocity_cmt__ServiceIdentifier__c = '41992718689'
        );
        lstAssets.add(asset);        

        asset = new Asset(ExternalId__c='1234567891011964075581',
                                StartDate__c = Datetime.now().addDays(-3),
                                accountId = acc.id,
                                name = '11964075581',
                                vlocity_cmt__ServiceIdentifier__c = '11964075581'          
        );
        lstAssets.add(asset);        
                
        asset = new Asset(ExternalId__c='12345678910TV-CTA-81HLRDN9B-050',
                                StartDate__c = Datetime.now().addDays(-3),
                                accountId = acc.id,
                                name = 'TV-CTA-81HLRDN9B-050',
                                vlocity_cmt__ServiceIdentifier__c = 'TV-CTA-81HLRDN9B-050'          
        );
        lstAssets.add(asset);
        
        vlocity_cmt__Subscription__c subs = new vlocity_cmt__Subscription__c (vlocity_cmt__SubscriptionNumber__c = 'teste');
        insert subs;
        
        asset = new Asset(StartDate__c = Datetime.now().addDays(-3),
                          accountId = acc.id,
                          name = '11941620775',
                          vlocity_cmt__ServiceIdentifier__c = '11941620775' ,
                          vlocity_cmt__SubscriptionId__c = subs.id
        );
        lstAssets.add(asset);
        insert lstAssets;        
    }
    
    @isTest
    public static void createAssetTest(){
        Account acc = [SELECT id, DocumentNumber__c FROM Account WHERE Name = 'Account' limit 1];        
        
        List<Object> obj = (List<Object>) JSON.deserializeUntyped('[ { "tags":[ "so:amdocs", "produto-avulso" ], "subscription_type":"postpaid", "sub_products":null, "status":"active", "start_date":"2022-08-10T18:49:29.000Z", "product_type":"mobile", "identifiers":[ "+5511964075581" ], "display_name":"VIVO FAMILIA 55GB+", "descriptions":[ { "text":"3 linhas adicionais grátis" }, { "text":"-" }, { "text":"4 segundos" }, { "text":"Promocionalmente isento" }, { "text":"Velocidade de transmissão de dados em internet móvel pode variar, entre outros motivos, por fenômenos naturais, deslocamento, distância da Estação Rádio Base e picos de tráfego. Consulte mais informações, cobertura e condições para navegar na velocidade 5G em vivo.com.br/pos" } ], "connection":null }, { "tags":[ "whatsapp", "ilimitado" ], "subscription_type":null, "sub_products":null, "status":"active", "start_date":"2022-08-10T18:49:29.000Z", "product_type":"value_added_service", "identifiers":[ "+5511964075581" ], "display_name":"WhatsApp", "descriptions":[ { "text":"WhatsApp" } ], "connection":null }, { "tags":[ "waze", "ilimitado" ], "subscription_type":null, "sub_products":null, "status":"active", "start_date":"2022-08-10T18:49:29.000Z", "product_type":"value_added_service", "identifiers":[ "+5511964075581" ], "display_name":"Waze", "descriptions":[ { "text":"Waze" } ], "connection":null }, { "tags":[ "moovit", "ilimitado" ], "subscription_type":null, "sub_products":null, "status":"active", "start_date":"2022-08-10T18:49:29.000Z", "product_type":"value_added_service", "identifiers":[ "+5511964075581" ], "display_name":"Moovit", "descriptions":[ { "text":"Moovit" } ], "connection":null }, { "tags":[ "so:amdocs", "produto-avulso" ], "subscription_type":"postpaid", "sub_products":null, "status":"active", "start_date":"2022-08-25T17:55:11.000Z", "product_type":"mobile", "identifiers":[ "+5541992718689" ], "display_name":"INTERNET_MOVEL_100GB", "descriptions":[ { "text":"-" }, { "text":"Aplicativos disponíveis:NBA Básico; Skeelo Premium; Go Read" }, { "text":"-" }, { "text":"Promocionalmente isento" }, { "text":"Velocidade de transmissão de dados em internet móvel pode variar, entre outros motivos, por fenômenos naturais, deslocamento, distância da Estação Rádio Base e picos de tráfego. Consulte mais informações, cobertura e condições para navegar na velocidade 5G em vivo.com.br/pos" } ], "connection":null }, { "tags":[ "goread", "incluso" ], "subscription_type":null, "sub_products":null, "status":"active", "start_date":"2022-08-25T17:55:11.000Z", "product_type":"value_added_service", "identifiers":[ "+5541992718689" ], "display_name":"Go Read", "descriptions":[ { "text":"Seu plano inclui aplicativos com conteúdos exclusivos, é só baixar na Vivo App Store" } ], "connection":null }, { "tags":[ "nba", "incluso" ], "subscription_type":null, "sub_products":null, "status":"active", "start_date":"2022-08-25T17:55:11.000Z", "product_type":"value_added_service", "identifiers":[ "+5541992718689" ], "display_name":"NBA", "descriptions":[ { "text":"Seu plano inclui aplicativos com conteúdos exclusivos, é só baixar na Vivo App Store" } ], "connection":null }, { "tags":[ "skeelo", "incluso" ], "subscription_type":null, "sub_products":null, "status":"active", "start_date":"2022-08-25T17:55:11.000Z", "product_type":"value_added_service", "identifiers":[ "+5541992718689" ], "display_name":"Skeelo", "descriptions":[ { "text":"Seu plano inclui aplicativos com conteúdos exclusivos, é só baixar na Vivo App Store" } ], "connection":null }, { "tags":[ "so:siebel" ], "subscription_type":null, "sub_products":[ { "tags":[ "so:siebel" ], "subscription_type":null, "sub_products":null, "status":"active", "start_date":"2022-04-16T09:00:00.000Z", "product_type":"landline", "identifiers":[ "+551148696484" ], "display_name":"Fixo Voz", "descriptions":[ { "text":"Vivo Fixo Ilimitado Brasil" } ], "connection":null }, { "tags":[ "so:siebel" ], "subscription_type":null, "sub_products":null, "status":"active", "start_date":"2022-04-16T09:00:00.000Z", "product_type":"internet", "identifiers":[ "SPO-81HLO8VKZ-013" ], "display_name":"Vivo Internet", "descriptions":[ { "text":"50 Mbps" } ], "connection":{ "uplink_mbps":"25", "type":"fiber", "downlink_mbps":"50" } }, { "tags":[ "so:siebel" ], "subscription_type":null, "sub_products":null, "status":"active", "start_date":"2022-04-16T09:00:00.000Z", "product_type":"iptv", "identifiers":[ "TV-SPO-81HLO8DAN-050" ], "display_name":"TV", "descriptions":[ { "text":"Vivo Play Ultra" } ], "connection":null } ], "status":"active", "start_date":"2022-04-16T09:00:00.000Z", "product_type":"bundle", "identifiers":[ "+551148696484", "SPO-81HLO8VKZ-013", "TV-SPO-81HLO8DAN-050" ], "display_name":"Vivo Casa Conectada", "descriptions":[ { "text":"Fixo Voz + Vivo Internet + TV" } ], "connection":null }, { "tags":[ "nba", "incluso" ], "subscription_type":null, "sub_products":null, "status":"active", "start_date":"2022-08-25T17:55:11.000Z", "product_type":"value_added_service", "identifiers":[ "+5541992718689" ], "display_name":"NBA", "descriptions":[ { "text":"Seu plano inclui aplicativos com conteúdos exclusivos, é só baixar na Vivo App Store" } ], "connection":null }, { "tags":[ "whatsapp", "ilimitado" ], "subscription_type":null, "sub_products":null, "status":"active", "start_date":"2022-08-10T18:49:29.000Z", "product_type":"value_added_service", "identifiers":[ "+5511964075581" ], "display_name":"WhatsApp", "descriptions":[ { "text":"WhatsApp" } ], "connection":null }, { "tags":[ "goread", "incluso" ], "subscription_type":null, "sub_products":null, "status":"active", "start_date":"2022-08-25T17:55:11.000Z", "product_type":"value_added_service", "identifiers":[ "+5541992718689" ], "display_name":"Go Read", "descriptions":[ { "text":"Seu plano inclui aplicativos com conteúdos exclusivos, é só baixar na Vivo App Store" } ], "connection":null }, { "tags":[ "skeelo", "incluso" ], "subscription_type":null, "sub_products":null, "status":"active", "start_date":"2022-08-25T17:55:11.000Z", "product_type":"value_added_service", "identifiers":[ "+5541992718689" ], "display_name":"Skeelo", "descriptions":[ { "text":"Seu plano inclui aplicativos com conteúdos exclusivos, é só baixar na Vivo App Store" } ], "connection":null }, { "tags":[ "waze", "ilimitado" ], "subscription_type":null, "sub_products":null, "status":"active", "start_date":"2022-08-10T18:49:29.000Z", "product_type":"value_added_service", "identifiers":[ "+5511964075581" ], "display_name":"Waze", "descriptions":[ { "text":"Waze" } ], "connection":null }, { "tags":[ "moovit", "ilimitado" ], "subscription_type":null, "sub_products":null, "status":"active", "start_date":"2022-08-10T18:49:29.000Z", "product_type":"value_added_service", "identifiers":[ "+5511964075581" ], "display_name":"Moovit", "descriptions":[ { "text":"Moovit" } ], "connection":null }, { "tags":[ "so:salesforce" ], "product_characteristics":[ { "key":"plan_validity_period", "value":"Franquia válida por 1 dia" }, { "key":"ob_plan_code", "value":"VIVOTODAGSM" } ], "descriptions":[ { "text":"Plano Toda Hora GSM - Movel" }, { "text":"Ativo", "title":"status_comercial", "category":"general" } ], "id":"PRE:11941620775", "status":"active", "product_type":"mobile", "identifiers":[ "+5511941620775" ], "start_date":"2024-08-26T16:56:52.000Z", "subscription_type":"prepaid", "display_name":"Pré-Pago", "offer_id":"not_provided", "status_description":"Ativo" } ]');
        
        Map<String, Object> inputs = new Map<String, Object>();
        inputs.put('AccountId', acc.id);
        inputs.put('DocumentNumber', acc.DocumentNumber__c);
        inputs.put('lstProducts', obj); 

        MergeAssetController controller = new MergeAssetController();
        controller.invokeMethod('mergeAssets', inputs, new Map<String, Object>(), new Map<String, Object>());
        Asset assetToUpdate = [SELECT Id, ExternalId__c, StartDate__c FROM Asset WHERE ExternalId__c = '12345678910TV-SPO-81HLO8DAN-050' LIMIT 1];
        List<Asset> assetToDelete = [SELECT Id, ExternalId__c FROM Asset WHERE ExternalId__c = '12345678910TV-CTA-81HLRDN9B-050'
        AND Platform__c != 'Prepaid'
        AND Product2Id = null];
        List<Asset> assetToCreate = [SELECT Id, ExternalId__c FROM Asset];        
        System.assert(assetToUpdate.StartDate__c == Datetime.newInstanceGMT(2022,04,16,09,00,00), 'O campo StartDate__c não foi atualizado como deveria.');        
        System.assert(assetToDelete.isEmpty(), 'O asset foi deletado.');
    }

    @isTest
    public static void getPlatformWhenMobileAndPostpaidTest(){
        MergeAssetController.WrapperAPI assetToCreate = new MergeAssetController.WrapperAPI();

        assetToCreate.product_type = 'mobile';
        assetToCreate.subscription_type = 'postpaid';
       
        Test.startTest();
        String result = MergeAssetController.getPlatform(assetToCreate);
        Test.stopTest();

        Assert.areEqual('Postpaid', result, 'O resultado deve ser igual a Postpaid');
    }

    @isTest
    public static void getPlatformWhenMobileAndPrepaidTest(){
        MergeAssetController.WrapperAPI assetToCreate = new MergeAssetController.WrapperAPI();

        assetToCreate.product_type = 'mobile';
        assetToCreate.subscription_type = 'prepaid';

        Test.startTest();
        String result = MergeAssetController.getPlatform(assetToCreate);
        Test.stopTest();

        Assert.areEqual('Prepaid', result, 'O resultado deve ser igual a Prepaid');
    }

    @isTest
    public static void getPlatformWhenMobileAndEmptyTest(){
        MergeAssetController.WrapperAPI assetToCreate = new MergeAssetController.WrapperAPI();

        assetToCreate.product_type = 'mobile';
        assetToCreate.subscription_type = '';

        Test.startTest();
        String result = MergeAssetController.getPlatform(assetToCreate);
        Test.stopTest();

        Assert.areEqual('', result, 'O resultado deve ser igual a uma string vazia');
    }

    @isTest
    public static void getPlatformWhenEmptyTest(){
        MergeAssetController.WrapperAPI assetToCreate = new MergeAssetController.WrapperAPI();

        assetToCreate.product_type = '';
        assetToCreate.subscription_type = '';

        Test.startTest();
        String result = MergeAssetController.getPlatform(assetToCreate);
        Test.stopTest();

        Assert.areEqual('', result, 'O resultado deve ser igual a uma string vazia');
    }

    @isTest
    public static void getMainProductDescriptionWhenSourceSystemNginTest(){
        List<MergeAssetController.Descriptions> descLst = new List<MergeAssetController.Descriptions>();

        MergeAssetController.Descriptions description = new MergeAssetController.Descriptions();
        description.text = 'wrong value';
        description.title = 'wrong_value';
        descLst.add(description);

        MergeAssetController.Descriptions description2 = new MergeAssetController.Descriptions();
        description2.text = 'correct value';
        description2.title = 'commercial_name';
        descLst.add(description2);

        MergeAssetController.Descriptions description3 = new MergeAssetController.Descriptions();
        description3.text = 'wrong value';    
        description3.title = 'notthisvalue';
        descLst.add(description3);

        MergeAssetController.WrapperAPI assetToCreate = new MergeAssetController.WrapperAPI();
        assetToCreate.descriptions = descLst;
        assetToCreate.display_name = 'Teste';
        String sourceSystem = 'Ngin';

        Test.startTest();
        String result = MergeAssetController.getMainProductDescription(assetToCreate, sourceSystem);
        Test.stopTest();

        Assert.areEqual(description2.text, result, 'O resultado esperado é correct value');
    }

    @isTest
    public static void getMainProductDescriptionWhenSourceSystemNotEqualsToNginTest(){
        MergeAssetController.WrapperAPI assetToCreate = new MergeAssetController.WrapperAPI();
        List<MergeAssetController.Descriptions> descLst = new List<MergeAssetController.Descriptions>();
        assetToCreate.descriptions = descLst;
        assetToCreate.display_name = 'Teste';
        String sourceSystem = 'Test';

        Test.startTest();
        String result = MergeAssetController.getMainProductDescription(assetToCreate, sourceSystem);
        Test.stopTest();

        Assert.areEqual(assetToCreate.display_name, result, 'O resultado deve ser igual ao displayName');
    }

    @isTest
    public static void getMainProductDescriptionWhenDescriptionNotNullTest(){
        List<MergeAssetController.Descriptions> descLst = new List<MergeAssetController.Descriptions>();

        MergeAssetController.Descriptions description = new MergeAssetController.Descriptions();
        description.text = 'wrong value';
        description.title = 'wrong_value';
        descLst.add(description);

        MergeAssetController.Descriptions description2 = new MergeAssetController.Descriptions();
        description2.text = 'correct value';
        description2.title = 'commercial_name';
        descLst.add(description2);

        MergeAssetController.Descriptions description3 = new MergeAssetController.Descriptions();
        description3.text = 'wrong value';    
        description3.title = 'notthisvalue';
        descLst.add(description3);
 
        MergeAssetController.WrapperAPI assetToCreate = new MergeAssetController.WrapperAPI();
        assetToCreate.descriptions = descLst;
        String sourceSystem = 'Test';

        Test.startTest();
        String result = MergeAssetController.getMainProductDescription(assetToCreate, sourceSystem);
        Test.stopTest();

        Assert.areEqual(description2.text, result, 'O resultado esperado é correct value');
    }

    @isTest
    public static void getMainProductDescriptionWhenDescriptionListIsEmpty(){
        MergeAssetController.WrapperAPI assetToCreate = new MergeAssetController.WrapperAPI();
        List<MergeAssetController.Descriptions> descLst = new List<MergeAssetController.Descriptions>();
        assetToCreate.descriptions = descLst;
        String sourceSystem = 'Test';

        Test.startTest();
        String result = MergeAssetController.getMainProductDescription(assetToCreate, sourceSystem);
        Test.stopTest();

        Assert.areEqual('', result, 'O resultado deve ser igual a uma string vazia');
    }
}