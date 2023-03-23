({
    onInit : function(component) {
        LightningUtil.callApex(component, 'getAccountInfo', {accountId: component.get('v.accountId')}, (result) =>{
			if(result['account']){
                component.set('v.account', result['account']);
                component.set('v.buttonIcon' , 'utility:chevronup');
            }
            if(result['billingAccount']){
                component.set('v.billingAccount', result['billingAccount']);
            }
        });
    },

    closeModel : function(component, event, helper) {
        component.set('v.isAccountInfoOpen', false);
        if(component.get('v.buttonIcon') === 'utility:chevrondown'){
            component.set('v.buttonIcon' , 'utility:chevronup');
        } else {
            component.set('v.buttonIcon' , 'utility:chevrondown');
            component.set('v.isAccountInfoOpen', true);
        }
    }
})