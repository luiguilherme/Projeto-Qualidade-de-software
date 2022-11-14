/*
---------------------------------------------------
@authors - Rafael Amaral
@company - everis do Brasil
@date - 08/06/2020
@description - Classe de teste da classe 
CardOfferFlowController
---------------------------------------------------
*/
@IsTest
public with sharing class CardOfferFlowControllerTest 
{
    @IsTest static void getOfferTest()
    {
        
        Account lAccount = DataFactory.createConsumerAccount();
        insert lAccount;
        
        Account lBillingAccountFixed = DataFactory.createBillingAccount(lAccount.Id, 'Fixa');
        Account lBillingAccountMobile = DataFactory.createBillingAccount(lAccount.Id, 'Móvel');
        
        insert lBillingAccountFixed;
        insert lBillingAccountMobile;

        Account lServiceAccountFixed = DataFactory.createServiceAccount(lAccount.Id, lBillingAccountFixed.Id, 'Fixa');
        Account lServiceAccountMobile = DataFactory.createServiceAccount(lAccount.Id, lBillingAccountMobile.Id, 'Móvel');
        
        insert lServiceAccountFixed;
        insert lServiceAccountMobile;


        List<Offer__c> lstOffer = new List<Offer__c>();
        Offer__c offer = DataFactory.createOfferFixed(lAccount.Id);
        Offer__c offerCabinet = DataFactory.createOfferFixed(lAccount.Id);
        offerCabinet.OfferCityCategory__c = null;
        
        lstOffer.add(offer);
        lstOffer.add(offerCabinet);
        lstOffer.add(DataFactory.createOfferMobile(lAccount.Id, 'Movel'));
        lstOffer.add(DataFactory.createOfferMobile(lAccount.Id, 'AltaMovel'));
        insert lstOffer;
        
        List<Asset> lstAsset = new List<Asset>();
        Asset asset = DataFactory.createAsset(lAccount.Id, lBillingAccountFixed.Id, lServiceAccountFixed.Id, 'Fixa');
        // asset.Address__c = address.Id;
        lstAsset.add(asset);
        lstAsset.add(DataFactory.createAsset(lAccount.Id, lBillingAccountMobile.Id, lServiceAccountMobile.Id, 'Movel'));
        insert lstAsset;

        List<OfferFilter__c> lstOfferFilter = new List<OfferFilter__c>();
        lstOfferFilter.add(DataFactory.createOfferFilter('Cabinet'));
        lstOfferFilter.add(DataFactory.createOfferFilter('CityCategory'));
        insert lstOfferFilter;
        
        Offer__c ltOffer = [SELECT Id FROM Offer__c where RecordType.DeveloperName = 'AltaMovel' limit 1];

        Test.startTest();
        Offer__c lOfferReturned = CardOfferFlowController.getOffer(ltOffer.Id);
        system.assert(lOfferReturned != null);
        Test.stopTest();
    }
}