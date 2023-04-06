({
    onInit : function(component, event, helper) {
        var assetName = component.get('v.assetName');
        if(assetName) {
            helper.canvasLoad(component, event, assetName);
        } else {
            helper.canvasLoad(component, event);
        }
    }
})