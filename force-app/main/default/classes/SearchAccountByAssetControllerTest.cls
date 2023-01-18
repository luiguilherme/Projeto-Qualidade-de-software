@isTest
public with sharing class SearchAccountByAssetControllerTest {
    @TestSetup
    public static void setup(){
        Account acc = DataFactory.createAccount();
        // acc.CustomerType__c = 'Fixa';
        acc.CustomerSegment__c = 'VIP';
        insert acc;

        insert new Asset(
            AccountId = acc.Id,
            Name = '1199887766'
        );
    }

    @isTest
    public static void searchByAssetNumberTest(){
        List<Asset> assets;
        Test.startTest();
        assets = SearchAccountByAssetController.searchByAssetNumber('1199887766');
        Test.stopTest();

        System.assert(!assets.isEmpty(), 'A controller não retornou Assets para o numero enviado');
    } 
}