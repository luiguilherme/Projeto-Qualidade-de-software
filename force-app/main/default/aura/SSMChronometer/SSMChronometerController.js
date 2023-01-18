({
    doInit : function(component, event, helper) {
        helper.doInit(component);
    },

    doPlay : function(component, event, helper) {
        helper.startChronometer(component);
    },

    doStop : function(component, event, helper) {
        helper.stopChronometer();
    },

    doReset : function(component, event, helper) {
        helper.resetChronometer(component);
    },

    BroadcastNotificationHandler : function(component, event, helper) {
        helper.BroadcastNotificationHandler(component, event, helper);
    },
    
})