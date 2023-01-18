({
	getServiceHistory : function(component, event, helper) {

		var action = component.get('c.getServiceHistory');
        var self = this;
        
        action.setParams({
            "accountId": component.get('v.recordId') 
        });

        action.setCallback(this,
			function(response) {
                var state = response.getState();
                if (state === 'SUCCESS'){
                	component.set('v.hasServiceHistory', response.getReturnValue());
                    if(response.getReturnValue() == false){
						var toastEvent = $A.get("e.force:showToast");
                        
						toastEvent.setParams({
									message: $A.get("$Label.c.LoadingDataMessage"),
            						type: 'info',
            						duration:'5000',
        				});
        	
            			toastEvent.fire();
                        
        				this.createServiceHistory(component, event, helper);
                    }               
                }
			});

        $A.enqueueAction(action);

},
	createServiceHistory : function(component, event, helper) {

        var action = component.get('c.createServiceHistory');
        action.setParams({
            "accountId": component.get('v.recordId') 
        });
        
        action.setCallback(component,
            function(response) {
                var state = response.getState();
                var res = response.getReturnValue();

                if (state === 'SUCCESS' && res === 'true'){
                    $A.get('e.force:refreshView').fire();
                }
            }
        );
        $A.enqueueAction(action);

	}
})