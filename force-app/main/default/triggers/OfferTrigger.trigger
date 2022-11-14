trigger OfferTrigger on Offer__c (before delete) {
    
    if (trigger.isBefore){
        if (Trigger.isDelete) {
            OfferBO.validateActiveCartOffer(trigger.old);                
        }
    }
}