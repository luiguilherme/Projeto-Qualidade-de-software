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

        Asset asset = new Asset(vlocity_cmt__ServiceIdentifier__c='SPO-V0001NO4OR-013',
                                StartDate__c = Datetime.newInstance(2022,03,29,18,11,34),
                                accountId = acc.id,
                                name = 'SPO-V0001NO4OR-013'          
        );
        List<Asset> lstAssets = new List<Asset>{asset};
        asset = new Asset(vlocity_cmt__ServiceIdentifier__c='SPI-V0001NO4OR-013',
                                StartDate__c = system.now().addDays(-1),
                                accountId = acc.id,
                                name = 'SPI-V0001NO4OR-013'          
        );
        lstAssets.add(asset);
        insert lstAssets;
    }

    @isTest
    public static void createAssetTest(){
        Account acc = [SELECT id, DocumentNumber__c FROM Account WHERE Name = 'Account' limit 1];
        List<Object> obj = (List<Object>) JSON.deserializeUntyped('[{"connection":{"downlink_mbps":200,"uplink_mbps":100,"type":"fiber"},"address":"RUAOSWALDOCASIMIROMULLER,242","tags":["so:amdocs","produto-avulso"],"start_date":"2022-04-29T18:11:34.000Z","identifiers":["SPO-V0001NO4OR-013"],"descriptions":[{"text":"200MbpsEspecial"}],"product_type":"internet","display_name":"200MbpsEspecial","status":"active","id":"AMDOCS:SPO-V0001NO4OR-013"},{"linhaGroupIdAccountId":"1128520090","linhaSubscriptionIdAccountId":"400427792","accountId":"310081987","subscription_type":"postpaid","tags":["so:amdocs","produto-avulso"],"start_date":"2022-04-29T13:07:47.000Z","identifiers":["+5511998939397"],"descriptions":[{"text":"TITULARVIVOFAMILIA100GB"}],"product_type":"mobile","display_name":"TITULARVIVOFAMILIA100GB","status":"active","id":"AMDOCS:11998939397"},{"id":"ilimitado:cabify:11998939397","identifiers":["+5511998939397"],"status":"active","descriptions":[{"text":"Cabify"}],"tags":["cabify","ilimitado"],"start_date":"2022-04-29T13:07:47.000Z","product_type":"value_added_service","display_name":"Cabify"},{"id":"ilimitado:easytaxi:11998939397","identifiers":["+5511998939397"],"status":"active","descriptions":[{"text":"EasyTaxi"}],"tags":["easytaxi","ilimitado"],"start_date":"2022-04-29T13:07:47.000Z","product_type":"value_added_service","display_name":"EasyTaxi"}]');
        Map<String, Object> inputs = new Map<String, Object>();
        inputs.put('AccountId', acc.id);
        inputs.put('DocumentNumber', acc.DocumentNumber__c);
        inputs.put('lstProducts', obj);

        MergeAssetController controller = new MergeAssetController();
        controller.invokeMethod('mergeAssets', inputs, new Map<String, Object>(), new Map<String, Object>());
        Asset assetToUpdate = [SELECT Id, vlocity_cmt__ServiceIdentifier__c, StartDate__c FROM Asset WHERE vlocity_cmt__ServiceIdentifier__c = 'SPO-V0001NO4OR-013' LIMIT 1];
        List<Asset> assetToDelete = [SELECT Id, vlocity_cmt__ServiceIdentifier__c FROM Asset WHERE vlocity_cmt__ServiceIdentifier__c = 'SPI-V0001NO4OR-013'];
        List<Asset> assetToCreate = [SELECT Id, vlocity_cmt__ServiceIdentifier__c FROM Asset];
        System.assert(assetToUpdate.StartDate__c == Datetime.newInstanceGMT(2022,04,29,18,11,34), 'O campo StartDate__c não foi atualizado como deveria.');
        System.assert(assetToDelete.isEmpty(), 'O asset não foi deletado.');
        System.assert(assetToCreate.size() == 2, 'Não foi criado o asset recebido pela classe.');
    }
}