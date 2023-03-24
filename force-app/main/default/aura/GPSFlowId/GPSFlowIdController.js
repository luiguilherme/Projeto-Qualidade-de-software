({
    doInit: function(component, event, helper) {
        try {
            if (window.LightningUtil === undefined) {
                component.set('v.loadUtil', true);
            }else{
                helper.getGPSFlow(component, event, helper);
            }
            
        } catch (e) {
            console.log(e.message);
        }    
    },
    
    onSelectedItemTree : function (component, event, helper) {
        event.preventDefault();

        component.set('v.flowId', event.getParam('name'));
    },
    
    onConfirmFlowId : function (component, event, helper) {
        var recordId = component.get('v.recordId');
        var flowId = component.get('v.flowId');
        var listFlow = component.get('v.listFlow');
        var gpsFlow = '';
        for(var i = 0; i< listFlow.length; i++){
            if(listFlow[i].name == flowId){
                gpsFlow = listFlow[i].label;
            }
        }
        helper.updateGPSFlowId(component, event, helper, recordId, flowId, gpsFlow);
    },

    onCancelFlowId : function (component, event, helper) {
        $A.get("e.force:closeQuickAction").fire();
    },
})