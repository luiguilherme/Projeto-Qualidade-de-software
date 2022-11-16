({
    doInit : function (component, event, helper)
    {
        helper.openFlow(component, event, helper);
    },

    statusChange : function (component, event, helper)
    { 
        if (event.getParam('status') === "FINISHED") 
        {
            helper.closeModal(component, event, helper);
        }
    },

    closeModal : function (component, event, helper)
    {
        helper.closeModal(component, event, helper);
    }
})