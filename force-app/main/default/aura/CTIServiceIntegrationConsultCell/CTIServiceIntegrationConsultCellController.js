({
    onInit : function(component, event, helper) {        
        helper.createCellList(component);
    },
 
    btnPerformConsult : function(component, event, helper) {
        helper.PerformConsult(component, event);
    },

    btnFinalizeConsult : function(component, event, helper) {
        helper.FinalizeConsult(component, event)
    },
    
    btnContinueService : function(component, event, helper) {
        helper.ContinueService(component, event)
    },

    btnTalkToTheCustomerClick : function(component, event, helper) {
        helper.talkToTheCustomer(component, event); 
    },

    
})