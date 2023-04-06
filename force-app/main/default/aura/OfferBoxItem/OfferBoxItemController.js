({
    setOffer: function (component, event, helper) {
        if (component.get("v.sourceItem") != 'ITV') {
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
        }

        component.set('v.msgServiceSummary', component.get("v.offer.field3"));
        component.set('v.openModal', true);
        
        // Event
        var appEvent = $A.get("e.c:OfferBoxItemEvent");

        appEvent.setParams({
            "sourceItem": component.get("v.sourceItem")
        });
        
        appEvent.fire();
    },

    closeModal: function(component, event, helper){
        component.set('v.openModal',false);
    },

})