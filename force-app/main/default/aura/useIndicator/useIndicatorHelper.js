({
	insertRegister:function(component, event, helper){
        var action = component.get("c.insertIndicator");
        action.setParams({
            "accountId": component.get('v.recordId'),
            "userId" : $A.get("$SObjectType.CurrentUser.Id")
            
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
            }
        });
        $A.enqueueAction(action);
        
    },
})