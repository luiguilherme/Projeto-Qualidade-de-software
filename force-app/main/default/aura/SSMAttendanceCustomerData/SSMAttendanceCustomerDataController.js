({
    doInit : function(component, event, helper) {
        helper.loadSSMAttendanceCustomerData(component, event, helper);
    },

    onCellPhoneChange : function(component, event, helper) {
        helper.onCellPhoneChange(component, event, helper);
    },

    onCategoryChange : function(component, event, helper) {
        helper.onCategoryChange(component, event, helper);
    },

    onMainDocumentTypeChange : function(component, event, helper) {
        helper.onMainDocumentTypeChange(component, event, helper);
    },

    onDocumentNumberChange : function(component, event, helper) {
        helper.onDocumentNumberChange(component, event, helper);
    },

})