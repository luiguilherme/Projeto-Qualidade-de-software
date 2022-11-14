({
    doInit: function (component, event, helper) {
        component.set('v.isPhone', $A.get('$Browser.isPhone'));
        var cpm = component.get('v.isPhone');
        console.log('cpm ', cpm);
    },

    copyInputFieldValue : function(component, event, helper) {
        var textForCopy = event.getSource().get("v.value");
        helper.copyTextFieldHelper(component,event,textForCopy);
    }
})