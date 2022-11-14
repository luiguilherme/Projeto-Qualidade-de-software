({
    getAccount : function(component){
        var action = component.get("c.getAccountId");
        action.setParams({
            "accountId" : component.get('v.recordId')
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
                component.set("v.selectedLookUpRecord", response.getReturnValue());
                var childComponent = component.find("accountLookup");
                childComponent.initLookup();
            }
        });
        $A.enqueueAction(action);
    },

    getAccountAddressJS : function(component) {
        component.set("v.errorMessage", '');
        var action = component.get("c.getGeographicAddress");
        action.setParams({
            "zipCode" : component.get("v.zipCode"),
            "stNumber": component.get("v.stNumber"),
            "freeText": ""
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            var resp = response.getReturnValue();
            if (state === "SUCCESS" && resp.success == true) {
                var responseJSON = JSON.parse(resp.body);
                component.set("v.ltAddress", responseJSON);

                var eventName = component.get('v.EventName')
                var evt = $A.get('e.c:BroadcastNotification');
        
                evt.setParam('type', eventName );
                evt.setParam('json', responseJSON);
                evt.fire();
            }
            else {
                if(resp.calloutError == true){
                    component.set("v.hasError", true);                
                }
                component.set("v.errorMessage", resp.body);
            }
        });
        $A.enqueueAction(action);
    },
})