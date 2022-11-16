({
    doInit : function(component) { 
        var action = component.get("c.downloadInvoice");
        var self = this;
        action.setParams({ 
            "invoiceId" : component.get("v.recordId"),
            "secondaryDownload" : false           
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            console.log('state = ' ,state);
            if (state === "SUCCESS") {
                $A.get("e.force:closeQuickAction").fire();
                $A.get('e.force:refreshView').fire();
            }
            else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                    }
                } else {
                }
               
        		$A.get('e.force:refreshView').fire();
        		$A.get("e.force:closeQuickAction").fire();
            }
        });
        $A.enqueueAction(action);
    }
})