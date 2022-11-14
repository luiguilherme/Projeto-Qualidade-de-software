({
    doInit: function (component, event, helper) {		

        var customerInteractionId = component.get('v.recordId');
        
        helper.callApex(component,'validateUserIdInformation',{customerInteractionId},(returnValue) =>{
            if(returnValue){
                component.set('v.hasUserIdAccount', true);

                console.log('*** 1 customerInteractionId = ' + customerInteractionId);
                                                               
                                                               
                helper.callApex(component,'getInvoiceHistory',{customerInteractionId},(returnValueInvoice) =>{
                                                               
                    console.log('*** 2 customerInteractionId = ' + customerInteractionId);
                                                               
                    if(!returnValueInvoice){
                        component.set('v.hasInvoiceHistory',returnValue);
                        helper.showToast('', $A.get("$Label.c.LoadingDataMessage"),'info', 5000);   
                        helper.createInvoiceHistory(component, event, helper);
                    }else{
                        helper.getMessage(component, event. helper);
                    }
                });
            }
        });
	},

    onShowComponent: function(component, event, helper){
        var type = event.getParam("type");

        if(type != 'unlockedUserId'){
            return;
        }
        
        component.set('v.hasUserIdAccount', true);
        helper.createInvoiceHistory(component, event, helper);
    }
                                                               
})