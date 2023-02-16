({
    doInit: function(component, event, helper) {
        /* Context for future improvements
        helper.doInit(component);
        */
    },

    onSelectGiveUpReason : function (component, event, helper) {
        helper.onSelectGiveUpReason(component, event, helper);
    },

    btnCancelClick: function(component, event, helper) {
        helper.closeDialog(component, event, helper);
    },    

    btnConfirmClick: function(component, event, helper) {
         helper.confirmGiveUp(component, event, helper);
    },

})
