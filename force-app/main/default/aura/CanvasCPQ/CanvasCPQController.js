({
    onInit : function(component, event, helper) {
        var phoneNumber = component.get('v.phoneNumber');
        if(phoneNumber) {
            helper.canvasLoad(component, event, phoneNumber);
        } else {
            helper.canvasLoad(component, event);
        }
    }
})