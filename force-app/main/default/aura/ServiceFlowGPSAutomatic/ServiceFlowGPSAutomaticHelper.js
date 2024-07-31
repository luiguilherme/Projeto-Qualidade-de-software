({
    openCanvas : function(component) {
        component.set("v.showButton", false);
        component.set("v.isLoading", true);
        var action = component.get("c.getCanvasParametersFromCase");
        action.setParams({ caseId : component.get('v.recordId')});
        try{
            action.setCallback(this, function(response) {
                var state = response.getState();
                
                if (state === "SUCCESS") {
                    let resultCanvas = response.getReturnValue();
                    if (resultCanvas.parameters.TipificacaoId) {
                        component.set("v.hasGPSFlowId", true);
                        component.set("v.canOpenCanvas", true);
                        component.set("v.canvasAppName",    resultCanvas.canvasAppName);					
                        component.set("v.canvasParameters", JSON.stringify(resultCanvas.parameters));
                        component.set("v.isLoading", false);
                        console.log("Result Canvas Automatic", JSON.stringify(resultCanvas));
                    }
                } 
                
                component.set("v.isLoading", false);
            });
            
            $A.enqueueAction(action);
        }
        catch(error){
            component.set("v.isLoading", false);
        }
    }
})