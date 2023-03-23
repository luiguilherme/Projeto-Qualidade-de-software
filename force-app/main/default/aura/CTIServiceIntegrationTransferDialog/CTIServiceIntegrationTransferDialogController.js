({
    onInit : function(component, event, helper) {        
        helper.createCellList(component);
    },
 
    onDestinyChange : function(component, event, helper) {
        helper.onDestinyChange(component, event);
    },

    btnDirectTransferClick : function(component, event, helper) {
        helper.directTransfer(component, event)
    },
    
    btnAssistedTransferClick : function(component, event, helper) {
        helper.assistedTransfer(component, event)
    },

    btnAssistedTransferConfirmClick : function(component, event, helper) {
        helper.assistedTransferConfirm(component, event)
    },

    btnTalkToTheCustomerClick : function(component, event, helper) {
        helper.talkToTheCustomer(component, event); 
    },

    btnCancelClick: function(component, event, helper) {
        helper.cancelTransfer(component, event);
    },

})