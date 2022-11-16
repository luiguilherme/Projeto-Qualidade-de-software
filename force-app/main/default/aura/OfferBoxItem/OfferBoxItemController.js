({
    setOffer: function (component, event, helper) {
        
        
        if (component.get("v.selectedOfferId") == component.get("v.offer.idOffer")) {
            component.set("v.selectedOfferId", "");
            
        } else {
            component.set("v.selectedOfferId", component.get("v.offer.idOffer"));
            
        }
        if (component.get("v.selectedOfferAltaId") == component.get("v.offer.idOffer")) {
            component.set("v.selectedOfferAltaId", "");
            
        } else {
            component.set("v.selectedOfferAltaId", component.get("v.offer.idOffer"));
            
        }
         
        console.log('Offer ID', component.get("v.offer.idOffer"));
        console.log('SOURCE', JSON.stringify(component.get("v.sourceItem")));

        
        // Event
        var appEvent = $A.get("e.c:OfferBoxItemEvent");
        appEvent.setParams({
            "sourceItem": component.get("v.sourceItem")
            
        });
        
        appEvent.fire();
    }
})