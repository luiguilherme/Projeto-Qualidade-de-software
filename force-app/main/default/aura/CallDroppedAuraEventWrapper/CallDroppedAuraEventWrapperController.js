({
    handleAplicationEvent : function (component, event) {
        console.log('CallDroppedAuraEventWrapper > handleAplicationEvent');        
        var eventPayload = event.getParam('params');        

        let evt = $A.get('e.c:BroadcastNotification');
        evt.setParam('sobject', eventPayload);
        evt.setParam('json', eventPayload.CustomerInteractionId__c);
        evt.setParam('type', 'GPSCanvasIntegration_CallDropped');
        evt.fire();
    },
    
    handleBroadcastNotification : function (component, event, helper) {
        var typeEvent = event.getParam('type');
        var eventCustomerId = event.getParam('json');
    }
})