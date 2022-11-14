({
    doInit : function(component) { 
        var action = component.get('c.downloadInvoice');
        
        action.setParams({
            'invoiceId' : component.get('v.recordId'), 
            'secondaryDownload' : true
        });

        action.setCallback(this, function(response) {
            $A.get("e.force:closeQuickAction").fire();
            
            if (response.getState() === "SUCCESS") {
                $A.get('e.force:refreshView').fire();
            }
        });

        $A.enqueueAction(action);
    }
})