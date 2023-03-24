({
    btnCallDroppedClick : function(component, event, helper) {
        let evt = $A.get('e.c:BroadcastNotification');

        evt.setParam('type', 'CTIServiceIntegration_CallDropped');
        evt.setParam('json', component.get('v.recordId'));
        evt.fire();
    }
})