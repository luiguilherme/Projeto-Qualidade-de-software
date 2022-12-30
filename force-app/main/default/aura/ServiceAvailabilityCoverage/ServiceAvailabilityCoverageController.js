({
    handleFinish : function(component,event,helper){
        var eventName = component.get('v.EventName')
        var evt = $A.get('e.c:BroadcastNotification');
        evt.setParam('type', eventName );
        evt.fire();

    },
    
    handleComponentEvent : function(component, event, helper) {
        var selectedTypeFromEvent = event.getParam("type");
        if(selectedTypeFromEvent === 'ADDRESS_VALIDATE'){
            helper.getCoverage(component, event, helper);    
        }
        if(selectedTypeFromEvent === 'ADDRESS_VALIDATE_ERROR'){
            helper.getCoverageError(component, event, helper);
        }
        if(selectedTypeFromEvent === 'ADDRESS_CLEAR'){
            component.set('v.data', []); 
            component.set('v.selectedAddress', []);
            component.set('v.objectResponse', []);
            component.set('v.isDisabled', true);
            component.set("v.isLoading", true);
        }
    },

    handlePrevious : function(component,event,helper){
        var evt = $A.get('e.c:BroadcastNotification');
        evt.setParam('type', 'RETURN_TO_VALIDATE');
        evt.fire();
    },

})