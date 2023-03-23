({  
    doInit: function(component, event, helper) {
        let evt = $A.get('e.c:BroadcastNotification');
        evt.setParam('type', 'GPSCanvasIntegration_GetCaseWDE');
        evt.setParam('json', component.get('v.recordId'));
        evt.fire();
    },

    onInit : function(component) {
        component.set("v.isLoading", false);
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
        evt.setParam('json', eventPayload.CustomerInteractionId__c);
        evt.setParam('sobject', eventPayload);
        evt.fire();
    },

    handleNewServiceSameClient : function(component){
        //var evt = component.getEvent("ServiceContainerEvent");        
        //evt.setParam('type', 'ServiceFlowGPS_NewServiceSameClient');
        //evt.fire();        
        this.handleCloseCanvasFlex(component, event, helper);
    },
    handleEventToAura : function(component, event, helper) {
        var params = event.getParam('params');
        window.console.log('aura: ' + JSON.stringify(params));
        component.set('v.caseId', params.CaseId)
        helper.setParameters(component, event, params);
    },
    handleCloseCanvasFlex : function(component, event, helper) {
        component.set("v.canOpenCanvas", false);
		component.set("v.canvasAppName",    '');
		component.set("v.canvasParameters",    {});
        window.console.log('Debug# go to fireFinishFlow');
        component.find('gpscanvaschild').fireFinishFlow();
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
    },

    handleBroadcastNotification : function (component, event, helper) {
        var typeEvent = event.getParam('type');
        var eventCustomerId = event.getParam('json');

        if (eventCustomerId == component.get('v.recordId')) {
            if(typeEvent == 'CTIServiceIntegration_IsCallActive'){
                let isCallActive = JSON.stringify(event.getParam('sobject'));

                let parameters = JSON.parse(component.get("v.canvasParameters"));
                parameters.IsCallActive = isCallActive;
                component.set("v.canvasParameters", JSON.stringify(parameters));
                component.set("v.isCallActive", JSON.parse(isCallActive));
                component.find('gpscanvaschild').canvasOpened();
                component.set("v.canOpenCanvas", true);

            }if(typeEvent == 'GPSCanvasIntegration_SetCaseWDE'){
                let gpsCase = JSON.parse(JSON.stringify(event.getParam('sobject')));

                if(gpsCase && gpsCase.Origin == 'GPS' && gpsCase.Closure__c == null){
                    let params ={
                        AccountId : gpsCase.AccountId,
                        TopicTreeId : gpsCase.CustomerInteractionTopicTree__c,
                        Asset : gpsCase.ComplainedAsset__c,
                        CaseId : gpsCase.Id,
                        CustomerInteractionId : component.get('v.recordId')
                    }

                    component.set('v.caseId', gpsCase.Id);
                    helper.setParameters(component, event, params);
                    component.find('gpscanvaschild').canvasOpened();
                }
            }
        }

    }
})