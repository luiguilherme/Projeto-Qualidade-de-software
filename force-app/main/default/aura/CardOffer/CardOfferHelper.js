({
    setOffer : function(component, event, helper) {  
        var action = component.get("c.getBillingAccountCard");
        
        action.setParams({
            
            "JSONFixed": JSON.stringify(component.get('v.ltBillingAccountFixed')),            
            "JSONMobile": JSON.stringify(component.get('v.ltBillingAccountMobile')),
            "JSONMobileAlta": JSON.stringify(component.get('v.ltOfferAlta')),
            "IdOfferAlta": component.get('v.selectedOfferAltaId'),
            "accountId": component.get('v.recordId'),           
            "userId" : $A.get("$SObjectType.CurrentUser.Id") 	
                         
            
        });
        
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {               

                var returnMap = response.getReturnValue();
                component.set('v.ltCardFixed', returnMap['ltCardFixed']);
                component.set('v.ltCardMobile', returnMap['ltCardMobile']);
                component.set('v.ltCardProposal', returnMap['ltCardProposal']);
                component.set('v.hasOfferFixed', returnMap['hasOfferFixed']);
                component.set('v.hasOfferMobile', returnMap['hasOfferMobile']);
                component.set('v.hasOfferAlta', returnMap['hasOfferAlta']);
                component.set('v.hasTotalProposal', returnMap['hasTotalProposal']);
                component.set('v.ltCardOfferAlta', returnMap['ltCardOfferAlta']);
                component.set('v.ltCardProposalAlta', returnMap['ltCardProposalAlta']);
                component.set('v.returnProposal', returnMap['returnProposal']);
                component.set('v.billingValueProposal', returnMap['billingValueProposal']);
                component.set('v.setOfferSelected', returnMap['setOfferSelected']); 
                component.set('v.totalDiscount', 
                    this.calculateTotalDiscount(returnMap['ltCardFixed'])
                );
                component.set('v.totalProposal',
                    this.calculateTotalProposal(returnMap['ltCardProposal'],returnMap['ltCardOfferAlta'])
                );
            }
            
        });
        $A.enqueueAction(action);
   },

   showToast : function (aType, aTitle, aMessage, aMode)
   {
       var toastEvent = $A.get("e.force:showToast");
       toastEvent.setParams
       ({
           "type" : aType,
           "title" : aTitle,
           "message" : aMessage,
           "mode" : aMode
       });
       toastEvent.fire();
   },

   calculateTotalDiscount :  function(cardFixed) 
   {
        var total = 0;
        if(cardFixed.length > 0) {
            cardFixed.forEach(item => {
                total += parseFloat(item.field6);
                total += parseFloat(item.field7);
                total += parseFloat(item.field8);
            });
        } else {
            total += 0;
        }
        return total;
   },

   calculateTotalProposal: function(cardFixed, cardMobile)
    {
        let totalProposal = 0;

        cardFixed.forEach(item =>{
            if (item.billingProposalValue !== undefined && item.billingProposalValue !== '') 
                totalProposal += parseFloat(item.billingProposalValue);       
        });
        
        cardMobile.forEach(item => {
            if (item.field1 !== undefined && item.field1 !== '')
                totalProposal += parseFloat(item.field1);
        });  
        
        return totalProposal;
    }
    
 })