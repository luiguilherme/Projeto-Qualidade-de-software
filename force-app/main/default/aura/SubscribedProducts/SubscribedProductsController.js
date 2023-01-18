({
    
    doInit: function (component, event, helper) {

        if(window.LightningUtil === undefined){
            component.set('v.loadUtil', true);
        }else{
            LightningUtil.callApex(component,'validateUserIdInformation',{accountId : component.get('v.recordId')},(returnValue) =>{
                if(returnValue){
                    helper.callSubscribed(component);
                }
            });       
        }
    },

    
    onNotifyFieldFilling : function(component, event, helper){
        var type = event.getParam("type");

        if(type != 'unlockedUserId'){
            return;
        }

        helper.callSubscribed(component);
    }
    
})