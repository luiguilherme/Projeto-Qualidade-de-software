({
    onInit : function(component) {
        component.set("v.isloading", false);
    },
    handleCloseCanvas : function(component){
        var evt = component.getEvent("ServiceContainerEvent");
        evt.setParam('type', 'ServiceFlowGPS_RestartCanvas');
        evt.fire();
    },

    handleCanvasEvent : function(component, event){
        var eventPayload = JSON.parse(JSON.stringify(event.getParam('payload')));
        let evt = $A.get('e.c:BroadcastNotification');
        evt.setParam('type', eventPayload.OperationType__c);
        evt.setParam('json', eventPayload.AccountId__c);
        evt.setParam('sobject', eventPayload);
        evt.fire();
    },

    handleNewServiceSameClient : function(component){
        var evt = component.getEvent("ServiceContainerEvent");
        evt.setParam('type', 'ServiceFlowGPS_NewServiceSameClient');
        evt.fire();
    },
    handleEventToAura : function(component, event, helper) {
        var params = event.getParam('params');
        window.console.log('aura: ' + JSON.stringify(params));
        helper.setParameters(component, event, params);
    },
    handleCloseCanvasFlex : function(component, event, helper) {
        component.set("v.canOpenCanvas", false);
		component.set("v.canvasAppName",    '');
		component.set("v.canvasParameters",    {});
        component.find('gpscanvaschild').fireFinishFlow();
        
        var evt = component.getEvent("ServiceContainerEvent");
        evt.setParam('type', 'ServiceFlowGPS_RestartCanvas');
        evt.fire();
    },

    handleAplicationEvent : function (component, event) {
        console.log('Enter into handleAplicationEvent method');        
        var eventPayload = event.getParam('params');
        console.log('eventPayload: ' + JSON.stringify(eventPayload));
        console.log('eventPayload.CustomerInteractionId: ' + eventPayload.CustomerInteractionId__c);        

        let evt = $A.get('e.c:BroadcastNotification');
        evt.setParam('sobject', eventPayload);
        evt.setParam('json', eventPayload.CustomerInteractionId__c);
        evt.setParam('type', 'GPSCanvasIntegration_CallDropped');
        evt.fire();
    }
})