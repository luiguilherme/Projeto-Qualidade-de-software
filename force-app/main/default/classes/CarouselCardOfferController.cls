public with sharing class CarouselCardOfferController {

    @AuraEnabled
    public static CardOfferServiceReturn getCardsOffers(Id accountId){
        return CarouselCardOfferService.getCardsOffers(accountId);
    }

    @AuraEnabled
    public static Boolean checkIfAccountHaveUserId(Id accountId){
        return CarouselCardOfferService.checkIfAccountHaveUserId(accountId);
    }

    @AuraEnabled
    public static String postCardOffers(Id accountId, String card, String acceptOrNot, String reason){
        return CarouselCardOfferService.postCardOffers(accountId, card, acceptOrNot, reason);
     }
}