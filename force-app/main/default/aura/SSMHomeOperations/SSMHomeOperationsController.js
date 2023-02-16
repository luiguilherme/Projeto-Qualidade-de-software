({
    doInit: function(component, event, helper) {
        /* Context for future improvements
        helper.doInit(component);
        */
    },

    doEnable : function(component, event, helper) {
        helper.activate(component, true);
    },

    doDisable : function(component, event, helper) {
        helper.activate(component, false);
    },

    btnManualServiceClick : function(component, event, helper) {
        helper.manualAttendance(component, event, helper);
    },

    btnServiceClick : function(component, event, helper) {
        helper.preAttendance(component, helper.AttendanceType.Forced);
    },

    BroadcastNotificationHandler : function(component, event, helper) {
        helper.BroadcastNotificationHandler(component, event, helper);
    },

})
