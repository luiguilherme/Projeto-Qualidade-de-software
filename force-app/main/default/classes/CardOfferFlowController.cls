/*
---------------------------------------------------
@authors - Rafael Amaral
@company - everis do Brasil
@date - 04/06/2020
@AuraComponent - CardOfferFlow
@description - Retorna uma oferta ao componente lightning
---------------------------------------------------
Changes
2020-09-30 @Alvaro B2C7551-402 - MobilePriceOffer__c removido do SOQL em Offer__c.
*/
public with sharing class CardOfferFlowController 
{
    @AuraEnabled
    public static Offer__c getOffer(String aOfferId)
    {
        return [SELECT Id, Name, OfferDescriptionConcat__c, PackageOffer__c, TypePlan__c, MobileInternetDescription__c,
                MobileDescription__c, TotalPrice__c, IsActive__c FROM Offer__c WHERE Id = :aOfferId ];
    }
}