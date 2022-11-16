public class OfferBO {
    
    public static void validateActiveCartOffer(List<Offer__c> lstOffer){
        Set<Id> setIdOffer = new Set<Id>();
        List<CartOffer__c> lstCartOffer = new List<CartOffer__c>();
        Map<Id, CartOffer__c> mapCartOffer = new Map<Id, CartOffer__c>();

        for(Offer__c offer : lstOffer){
            setIdOffer.add(offer.Id);
        }

        lstCartOffer = CartOfferDAO.getCartOfferByOfferId(setIdOffer);
        
        for(CartOffer__c cartOffer : lstCartOffer){
            mapCartOffer.put(cartOffer.OfferId__c, cartOffer);
        }

        for(Offer__c offer : lstOffer){
            CartOffer__c cartOffer = new CartOffer__c();
            cartOffer = mapCartOffer.get(offer.Id);

            if(cartOffer != null){
                offer.addError(System.Label.DeleteActiveOfferCartValidation);
            }
        }
    }
}