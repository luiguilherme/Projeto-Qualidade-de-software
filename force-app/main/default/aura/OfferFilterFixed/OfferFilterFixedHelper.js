({
    callApex: function (component, method, params, callback) {
        if (component) {
            let apexCall = component.get('c.' + method);
            
            if (params != null) {
                apexCall.setParams(params);
            }
            apexCall.setCallback(this, function (response) {
                callback(response);
            });
            $A.enqueueAction(apexCall);
        } else {
            console.log('this Exception: Component access not granted. Please initialize it.');
        }
    },

    doInitHelper: function(component,event,helper){

        let withBiling = component.get('v.hasBillingAccount');
        if(withBiling){
            this.handleClickHelper(component,event);
        }else{
            this.WithoutBilling(component,event, helper);
        }

    },

    WithoutBilling: function(component,event,helper){
        let param = {
            "recordId": component.get('v.recordId')
        };        
        this.callApex(component, "getAccountRetentionFixedWithoutBilling", param, function(response){ 
            var state = response.getState();
            let retorno = response.getReturnValue();
   
            let errorText;
            let flag = false;
            let errorIcon = 'utility:error';
            let errorIconVariant = 'error';

            if (state === "SUCCESS") {
                if(retorno){
                    component.set('v.accBilling', retorno);
                    helper.handleClickHelper(component,event);
                }else{
                    flag = true;
                    errorText = $A.get("$Label.c.OfferComponentValidationOfferAccess");
                }
            } else {
                flag = true;
                errorText = $A.get("$Label.c.OfferComponentValidationOfferAccess");

            }

            component.set('v.errorIcon', errorIcon);
            component.set('v.errorText', errorText);
            component.set('v.errorIconVariant', errorIconVariant);
            component.set('v.errorFlag', flag);
            $A.get('e.force:refreshView').fire();
        });
    },

    handleClickHelper: function(component,event){
        let param = {
            "accBilling": component.get('v.accBilling') || null
        };
                
        this.callApex(component, "getOfferFilterFixed", param, function(response){ 
            let retorno = response.getReturnValue();
            let state = response.getState();
            let errorText;
            let flag = true;
            let errorIcon = 'utility:error';
            let errorIconVariant = 'error';

            component.set("v.spinnerFlag",true);
            component.set('v.accBilling.ltOffer',[]);
            
            if (state === "SUCCESS") {
                if(retorno != 0){
                    component.set('v.accBilling.ltOffer',retorno);
                    component.set('v.accBilling.hasOffer', true);
                    flag = false;
                }else{
                    component.set('v.accBilling.hasOffer', false);

                    
                    errorText = $A.get("$Label.c.OfferComponentValidationOffers");
                }
            }else {
                errorText = $A.get("$Label.c.OfferComponentValidationOfferAccess");  
            }

            component.set('v.errorIcon', errorIcon);
            component.set('v.errorText', errorText);
            component.set('v.errorIconVariant', errorIconVariant);
            component.set('v.errorFlag', flag);

            component.set("v.spinnerFlag",false);
        });

    },
    
});