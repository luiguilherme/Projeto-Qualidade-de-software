({
    doInit : function(component, event, helper) {
        helper.doInit(component, true);
    },

    onCellPhoneChange : function(component, event, helper) {
        helper.onCellPhoneChange(component, event, helper);
    },

    btnCancelClick : function(component, event, helper) {
        helper.closeDialog(component, event, helper);
    },    

    btnConfirmClick : function(component, event, helper) {
         helper.manualAttendance(component, event, helper);
    },

})