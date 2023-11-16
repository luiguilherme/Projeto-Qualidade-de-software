public with sharing class CarouselCardOfferService {
    public static Boolean checkIfAccountHaveUserId(Id accountId) {
        return CarouselCardOfferEngine.checkIfAccountHaveUserId(accountId);
    }

    public static CardOfferServiceReturn getCardsOffers(Id accountId, Id customerInteractionId) {
        CardOfferServiceReturn cardOffer = CarouselCardOfferEngine.getCardsOffers(accountId, customerInteractionId);
        return CarouselCardOfferEngine.toShapeCardOffer(cardOffer);
    }

    public static String setNumberOfOffers (Id customerInteractionId, Integer numberOfOffers){
        return CarouselCardOfferEngine.setNumberOfOffers(customerInteractionId, numberOfOffers);
    }

    public static String postCardOffers(Id customerInteractionId, Id accountId, String card, String acceptOrNot, String reason){
        CardOfferServiceReturn.Card cardOffer = (CardOfferServiceReturn.Card) JSON.deserialize(card, CardOfferServiceReturn.Card.class);
        Boolean isSuccess = CarouselCardOfferEngine.postCardOffers(customerInteractionId, accountId, cardOffer, acceptOrNot, reason);
        return CarouselCardOfferEngine.createNboCartAccount(customerInteractionId, accountId, cardOffer, acceptOrNot, reason, isSuccess);
    }
}