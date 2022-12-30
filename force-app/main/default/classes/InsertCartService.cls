public without sharing class InsertCartService {
    public static Map<String, Object> setInsertOffer(String offerId, String ltCardProposal, Id accountId, Id selectedOfferAltaId, Id userId, String ltBillingAccountFixed, String ltBillingAccountMobile){
        return InsertCartEngine.setInsertOffer(offerId, ltCardProposal, accountId, selectedOfferAltaId, userId, ltBillingAccountFixed, ltBillingAccountMobile);
    }
}