({
    doInit: function(component, event, helper) {
        helper.doInit(component);
    },

    doFinish : function(component, event, helper) {
        helper.finish(component);
    },

    doReady : function(component, event, helper) {
        helper.ready(component);
    },

    btnPauseClick : function(component, event, helper) {
        helper.prePause(component);
    },

    btnCancelPauseDialog : function(component, event, helper) {
        helper.cancelPause(component);
    },

    btnConfirmPauseDialog : function(component, event, helper) {
        helper.confirmPause(component);
    },

    btnUpdateClick : function(component, event, helper) {
        helper.update(component);
    },

    btnStartClick : function(component, event, helper) {
        helper.preStart(component);
    },

    btnFinishClick : function(component, event, helper) {
        helper.preFinish(component);
    },
 
    BroadcastNotificationHandler : function(component, event, helper) {
        helper.BroadcastNotificationHandler(component, event, helper);
    },

})