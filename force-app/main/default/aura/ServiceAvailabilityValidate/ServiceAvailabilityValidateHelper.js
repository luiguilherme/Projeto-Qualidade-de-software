({
    getCoverage : function(component, event, helper) {
        component.set("v.isLoading", true);
        var selectedAddress = component.get("v.selectedAddress"); 
        delete selectedAddress.aliasedGeographicAddress.streetPrefix;
    
        if(selectedAddress.aliasedGeographicAddress.streetNrFirst == null ||  selectedAddress.streetNrFirst == null ){
            selectedAddress.streetNrFirst = 'SN';
            selectedAddress.aliasedGeographicAddress.streetNrFirst = 'SN';
        }

        var action = component.get("c.getAddressCoverage");
        action.setParams({
            "requestJSON": JSON.stringify(selectedAddress.aliasedGeographicAddress)
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            var resp = response.getReturnValue();
            component.set("v.isLoading", false);

            if (state === "SUCCESS"  && resp.success == true) {
                var responseJSON = JSON.parse(resp.body);
                var eventName = component.get('v.EventName')
                var evt = $A.get('e.c:BroadcastNotification');
                var ltRecords = component.get('v.data');
                evt.setParam('type', eventName );
                evt.setParam('sobject', selectedAddress);
                evt.setParam('json', ltRecords.length);
                evt.fire();
            }
            else {
                state != "SUCCESS";
                var eventName = 'ADDRESS_VALIDATE_ERROR';
                var evt = $A.get('e.c:BroadcastNotification');
                evt.setParam('type', eventName);
                evt.setParam('sobject', selectedAddress);
                evt.setParam('json', resp.body);
                evt.fire();
                // component.set("v.errorMessage", resp.body);
            }
        });
        $A.enqueueAction(action);                               

    },

    isBtnDisabled : function(component, event, helper) {
        if(component.get('v.selectedAddress') != null || component.get('v.selectedAddress') != '' ){
            component.set('v.isBtnDisabled', false );
        } else {
            component.set('v.isBtnDisabled', true);
        }
    },


})