({
    doInit: function(component, event, helper) {
        if (window.LightningUtil === undefined) {
            component.set("v.loadUtil", true);

        } else {
            helper.doInit(component);
        }
    },

    BroadcastNotificationHandler : function(component, event, helper) {
        helper.BroadcastNotificationHandler(component, event, helper);
    },

})