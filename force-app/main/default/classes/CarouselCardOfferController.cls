public with sharing class CarouselCardOfferController {

    @AuraEnabled
    public static CardOfferServiceReturn getCardsOffers(Id accountId, Id customerInteractionId){
        return CarouselCardOfferService.getCardsOffers(accountId, customerInteractionId);
    }

    @AuraEnabled
    public static String setNumberOfOffers(Id customerInteractionId, Integer numberOfOffers){
        return CarouselCardOfferService.setNumberOfOffers(customerInteractionId, numberOfOffers);
    }

    @AuraEnabled
    public static Boolean checkIfAccountHaveUserId(Id accountId){
        return CarouselCardOfferService.checkIfAccountHaveUserId(accountId);
    }

    @AuraEnabled
    public static String postCardOffers(Id customerInteractionId,Id accountId, String card, String acceptOrNot, String reason){
        return CarouselCardOfferService.postCardOffers(customerInteractionId, accountId, card, acceptOrNot, reason);
     }
     
}