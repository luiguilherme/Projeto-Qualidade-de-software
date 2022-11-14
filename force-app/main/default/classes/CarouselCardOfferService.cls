public with sharing class CarouselCardOfferService {
    public static Boolean checkIfAccountHaveUserId(Id accountId) {
        return CarouselCardOfferEngine.checkIfAccountHaveUserId(accountId);
    }

    public static CardOfferServiceReturn getCardsOffers(Id accountId) {
        CardOfferServiceReturn cardOffer = CarouselCardOfferEngine.getCardsOffers(accountId);
        return CarouselCardOfferEngine.toShapeCardOffer(cardOffer);
    }

    public static String postCardOffers(Id accountId, String card, String acceptOrNot, String reason){
        CardOfferServiceReturn.Card cardOffer = (CardOfferServiceReturn.Card) JSON.deserialize(card, CardOfferServiceReturn.Card.class);
        Boolean isSuccess = CarouselCardOfferEngine.postCardOffers(accountId, cardOffer, acceptOrNot, reason);
        return CarouselCardOfferEngine.createNboCartAccount(accountId, cardOffer, acceptOrNot, reason, isSuccess);
    }
}