({
    doInit: function(component, event, helper) {
        helper.doInit(component);
    },

    btnRecallClick : function(component, event, helper) {
        helper.recall(component, event, helper);
    },
    
    btnBackToHomePageClick : function(component, event, helper) {
        helper.backToHome(component, event, helper);
    },

    btnGiveUpClick : function(component, event, helper) {
        helper.preGiveUp(component, event, helper);
    },
    
    btnFinishClick : function(component, event, helper) {
        helper.finish(component, event, helper);
    },

    btnReturnToAttendanceClick : function(component, event, helper) {
        helper.returnToAttendance(component, event, helper);
    },

    btnConfirmServiceClick : function(component, event, helper) {
        helper.confirmService(component, event, helper);
    },

    BroadcastNotificationHandler : function(component, event, helper) {
        helper.BroadcastNotificationHandler(component, event, helper);
    },

})
