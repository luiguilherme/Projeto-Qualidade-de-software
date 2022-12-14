({
    doInit: function (component, event, helper) {		
        component.set('v.showSpinner',true);

        helper.callApex(component,'validateUserIdInformation',{accountId : component.get('v.recordId')},(returnValueSalesforce) =>{
            if(returnValueSalesforce){
                helper.getTicketHistory(component, event, helper);
            }else{
                component.set('v.showSpinner',false); 
            }                    
        });
    },

    onShowComponent: function(component, event, helper){
        var type = event.getParam("type");

        if(type != 'unlockedUserId'){
            return;
        }

        helper.getTicketHistory(component, event, helper);
    }
})