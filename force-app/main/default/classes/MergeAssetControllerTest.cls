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
        Asset asset = new Asset(ExternalId__c ='123456789104130517247',
                                StartDate__c = Datetime.now().addDays(-3),
                                accountId = acc.id,
                                name = '4130517247'          
        );
        lstAssets.add(asset);
        
        asset = new Asset(ExternalId__c='12345678910CTA-81HLRD2L5-013',
                                StartDate__c = Datetime.now().addDays(-3),
                                accountId = acc.id,
                                name = 'CTA-81HLRD2L5-013'          
        );
        lstAssets.add(asset);
        
        asset = new Asset(ExternalId__c='12345678910TV-CTA-81HLRDN9B-05000',
                                StartDate__c = Datetime.now().addDays(-3),
                                accountId = acc.id,
                                name = 'TV-CTA-81HLRDN9B-05000'          
        );
        lstAssets.add(asset);        
                
        insert lstAssets;        
    }
    
    @isTest
    public static void createAssetTest(){
        Account acc = [SELECT id, DocumentNumber__c FROM Account WHERE Name = 'Account' limit 1];
        //List<Object> obj = (List<Object>) JSON.deserializeUntyped('[{"connection":{"downlink_mbps":200,"uplink_mbps":100,"type":"fiber"},"address":"RUAOSWALDOCASIMIROMULLER,242","tags":["so:amdocs","produto-avulso"],"start_date":"2022-04-29T18:11:34.000Z","identifiers":["SPO-V0001NO4OR-013"],"descriptions":[{"text":"200MbpsEspecial"}],"product_type":"internet","display_name":"200MbpsEspecial","status":"active","id":"AMDOCS:SPO-V0001NO4OR-013"},{"linhaGroupIdAccountId":"1128520090","linhaSubscriptionIdAccountId":"400427792","accountId":"310081987","subscription_type":"postpaid","tags":["so:amdocs","produto-avulso"],"start_date":"2022-04-29T13:07:47.000Z","identifiers":["+5511998939397"],"descriptions":[{"text":"TITULARVIVOFAMILIA100GB"}],"product_type":"mobile","display_name":"TITULARVIVOFAMILIA100GB","status":"active","id":"AMDOCS:11998939397"},{"id":"ilimitado:cabify:11998939397","identifiers":["+5511998939397"],"status":"active","descriptions":[{"text":"Cabify"}],"tags":["cabify","ilimitado"],"start_date":"2022-04-29T13:07:47.000Z","product_type":"value_added_service","display_name":"Cabify"},{"id":"ilimitado:easytaxi:11998939397","identifiers":["+5511998939397"],"status":"active","descriptions":[{"text":"EasyTaxi"}],"tags":["easytaxi","ilimitado"],"start_date":"2022-04-29T13:07:47.000Z","product_type":"value_added_service","display_name":"EasyTaxi"}]');
        List<Object> obj = (List<Object>) JSON.deserializeUntyped('[ { "tags": [ "so:siebel" ], "subscription_type": null, "sub_products": [ { "tags": [ "so:siebel" ], "subscription_type": null, "sub_products": null, "status": "active", "start_date": "2022-04-01T20:00:00.000Z", "product_type": "landline", "identifiers": [ "+554130517247" ], "display_name": "Fixo Voz", "descriptions": [ { "text": "Vivo Fixo Ilimitado Brasil" } ], "connection": null }, { "tags": [ "so:siebel" ], "subscription_type": null, "sub_products": null, "status": "active", "start_date": "2022-04-01T20:00:00.000Z", "product_type": "internet", "identifiers": [ "CTA-81HLRD2L5-013" ], "display_name": "Vivo Internet", "descriptions": [ { "text": "50 Mbps" } ], "connection": { "uplink_mbps": "25", "type": "fiber", "downlink_mbps": "50" } }, { "tags": [ "so:siebel" ], "subscription_type": null, "sub_products": null, "status": "active", "start_date": "2022-04-01T20:00:00.000Z", "product_type": "iptv", "identifiers": [ "TV-CTA-81HLRDN9B-050" ], "display_name": "TV", "descriptions": [ { "text": "Vivo Play Ultra" } ], "connection": null } ], "status": "active", "start_date": "2022-04-01T20:00:00.000Z", "product_type": "bundle", "identifiers": [ "+554130517247", "CTA-81HLRD2L5-013", "TV-CTA-81HLRDN9B-050" ], "display_name": "Vivo Casa Conectada", "descriptions": [ { "text": "Fixo Voz + Vivo Internet + TV" } ], "connection": null } ]');
        Map<String, Object> inputs = new Map<String, Object>();
        inputs.put('AccountId', acc.id);
        inputs.put('DocumentNumber', acc.DocumentNumber__c);
        inputs.put('lstProducts', obj); 

        MergeAssetController controller = new MergeAssetController();
        controller.invokeMethod('mergeAssets', inputs, new Map<String, Object>(), new Map<String, Object>());
        Asset assetToUpdate = [SELECT Id, ExternalId__c, StartDate__c FROM Asset WHERE ExternalId__c = '12345678910CTA-81HLRD2L5-013' LIMIT 1];
        List<Asset> assetToDelete = [SELECT Id, ExternalId__c FROM Asset WHERE ExternalId__c = '12345678910TV-CTA-81HLRDN9B-050'];
        List<Asset> assetToCreate = [SELECT Id, ExternalId__c FROM Asset];
        System.assert(assetToUpdate.StartDate__c == Datetime.newInstanceGMT(2022,04,01,20,00,00), 'O campo StartDate__c não foi atualizado como deveria.');
        System.assert(!assetToDelete.isEmpty(), 'O asset foi deletado.');
    }
}