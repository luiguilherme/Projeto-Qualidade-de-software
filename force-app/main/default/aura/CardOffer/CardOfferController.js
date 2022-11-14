({  

    updateOffer :  function (component, event, helper) {
        
        var sourceOffermobile = event.getParam("sourceOffermobile");
        var sourceOfferfixed = event.getParam("sourceOfferfixed");
        
        if(sourceOffermobile){
            
            var ltBillingMobile = event.getParam("ltBillingAccountMobile");
            var ltBillingFixed = component.get("v.ltBillingAccountFixed");
            var ltOfferAlta = event.getParam("ltOfferAlta");
            var selectedOfferAltaId = event.getParam("selectedOfferAltaId");
            
            
            component.set("v.ltBillingAccountMobile", ltBillingMobile),
            component.set("v.ltBillingAccountFixed", ltBillingFixed),
            component.set("v.ltOfferAlta", ltOfferAlta);
            component.set("v.selectedOfferAltaId", selectedOfferAltaId);
            
            helper.setOffer(component);
        }else if(sourceOfferfixed){
            var ltBillingFixed = event.getParam("ltBillingAccountFixed");
            var ltBillingMobile = component.get("v.ltBillingAccountMobile");      
            
            
            component.set("v.ltBillingAccountFixed", ltBillingFixed),
            component.set("v.ltBillingAccountMobile", ltBillingMobile),
                
                helper.setOffer(component);   
        }
            else{
                helper.getAccount(component, event, helper);    
            }
        
       
    },
    
    copytextfixa: function(component, event, helper) {
        // Create new element
        var el = document.createElement('textarea');
        // Set value (string to be copied)
        el.value = event.getSource().get("v.value");
        // Set non-editable to avoid focus and move outside of view
        el.setAttribute('readonly', '');
        el.style = {position: 'absolute', left: '-9999px'};
        document.body.appendChild(el);
        // Select text inside element
        el.select();
        // Copy text to clipboard
        document.execCommand('copy');
        // Remove temporary element
        document.body.removeChild(el);
        
        
        var orignalLabel = event.getSource().get("v.value");
        event.getSource().set("v.iconName" , 'utility:check');
        event.getSource().set("v.value" , 'copied');
        setTimeout(function(){ 
            event.getSource().set("v.iconName" , 'utility:copy'); 
            event.getSource().set("v.value" , orignalLabel);
        }, 700);
    },
    copytextmovel: function(component, event, helper) {
        // Create new element
        var el = document.createElement('textarea');
        // Set value (string to be copied)
        el.value = event.getSource().get("v.value");
        // Set non-editable to avoid focus and move outside of view
        el.setAttribute('readonly', '');
        el.style = {position: 'absolute', left: '-9999px'};
        document.body.appendChild(el);
        // Select text inside element
        el.select();
        // Copy text to clipboard
        document.execCommand('copy');
        // Remove temporary element
        document.body.removeChild(el);
        
        
        var orignalLabel = event.getSource().get("v.value");
        event.getSource().set("v.iconName" , 'utility:check');
        event.getSource().set("v.value" , 'copied');
        setTimeout(function(){ 
            event.getSource().set("v.iconName" , 'utility:copy'); 
            event.getSource().set("v.value" , orignalLabel);
        }, 700);
    },

    openScript : function (component, event, helper)
    {
        let oferta = component.get('v.ltCardOfferAlta');
        let offerId;
        oferta.forEach(element => {
            offerId = element.billingAccount;
        });
        component.set('v.selectedOfferId', offerId);

        component.set('v.isToOpenScript', true);
    }
})