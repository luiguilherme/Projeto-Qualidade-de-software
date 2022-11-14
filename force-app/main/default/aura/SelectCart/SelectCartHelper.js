({
	setOffers : function(component,haveToValidate, event, helper) {
        if(haveToValidate){
            helper.validateUserPermission(component, (returnHasPermission)=>{
                if(returnHasPermission){
                    helper.validateAccountLimit(component, (returnHasLimit)=>{
                        if(returnHasLimit){
                            helper.createCartAccount(component, event, helper);
                        }else{
                            component.set('v.showClientWithoutLimit', true);
                        }
                    });
                }else{
                     component.set('v.showClientWithoutPermission', true);
                 }
            });
        }else{
            helper.createCartAccount(component, event, helper);
        }
	},
   
    validateUserPermission: function(component, callback){
        var apexCall = component.get('c.userHavePermissionSet');

        apexCall.setCallback(this, (response)=>{
            callback(response.getReturnValue());
        });
        $A.enqueueAction(apexCall);     
    },
    
    validateAccountLimit: function(component, callback){
        var apexCall = component.get('c.accountHaveLimit');

        apexCall.setParams({
            'accountId': component.get('v.accountId') 
        });

        apexCall.setCallback(this, (response)=>{
            callback(response.getReturnValue());
        });
        $A.enqueueAction(apexCall);     
    },

    createCartAccount: function(component, event, helper){
        var action = component.get('c.setInsertOffer');
        action.setParams({
            'offerId': JSON.stringify(component.get('v.setOfferSelected')),     
            'ltCardProposal': JSON.stringify(component.get('v.ltCardProposal')),
            'selectedOfferAltaId': component.get('v.selectedOfferAltaId'),
            'accountId': component.get('v.accountId'),
            'userId' : $A.get('$SObjectType.CurrentUser.Id'),
            'ltBillingAccountFixed': JSON.stringify(component.get('v.ltBillingAccountFixed')),
            'ltBillingAccountMobile': JSON.stringify(component.get('v.ltBillingAccountMobile'))
        });
        action.setCallback(this, function(response){
            var state = response.getState();

            if (state === 'SUCCESS') {
                var returnMap = response.getReturnValue();
                if (returnMap.length != 0 || returnMap){
                    component.set('v.listProposal', returnMap['listProposal']);
                    if (returnMap['recordId'] === '' || returnMap['recordId'] === undefined) {
                        component.set('v.isOpen', returnMap['isOpen']);
                    }else {
                        component.set('v.isOpen',false);
                    }
                    component.set('v.templateOffer', returnMap['templateOffer']);
                    component.set('v.recordId', returnMap['recordId']);
                    if (returnMap['recordId'] !== '' && returnMap['recordId'] !== undefined) {
                            var actionURL = component.get('c.gotoURL');
                            $A.enqueueAction(actionURL);
                    }      
                } else{
                    var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        title : 'Ocorreu um erro inesperado',
                        message:'Por gentileza entrar em contato com o administrador!',
                        duration:' 5000',
                        key: 'info_alt',
                        type: 'error',
                        mode: 'pester'
                    });
                    toastEvent.fire();
                }
            }
        });
        $A.enqueueAction(action);
    },

    validateRulesAlta : function(component, event, helper) {
        helper.validateUserPermission(component, (returnHasPermission)=>{
            if(returnHasPermission){
                helper.validateAccountLimit(component, (returnHasLimit)=>{
                    if(returnHasLimit){
                        var msgValidationAltaMovel = component.get('v.msgValidationAltaMovel');
                        var msgResultValidation = `${msgValidationAltaMovel} []`;
                        var offerDescription = component.get('v.ltCardOfferAlta')[0].field2;
                        if (offerDescription !== undefined) {
                            msgResultValidation = `${msgValidationAltaMovel}`;
                        }
                        component.set('v.msgValidationResult', msgResultValidation);
                        var actionOpenModalClienteRetido = component.get('c.openModalClienteRetido');
                        $A.enqueueAction(actionOpenModalClienteRetido); 
                    }else{
                        component.set('v.showClientWithoutLimit', true);
                    }
                });
                
            }else{
                component.set('v.showClientWithoutPermission', true);
            }
        });
    }
})