({
	showOffer : function(component) {
        component.set('v.isLoading', true);
		var userId = $A.get('$SObjectType.CurrentUser.Id');
		var action = component.get('c.showOffer');
        action.setParams({
            "userId" : userId 
        });
        action.setCallback(this, function(response) {
            component.set('v.isLoading', false);
            var state = response.getState();
            if (state === 'SUCCESS') {
                var storeResponse = response.getReturnValue();
                component.set('v.isCanvasHybris', storeResponse);
            }
        });
        $A.enqueueAction(action);
	},  

    createCustomerInteractionTopic : function(component) {
        var customerInteractionId = component.get('v.recordId');
		var action = component.get('c.createCustomerInteractionTopic');
        action.setParams({
            "customerInteractionId" : customerInteractionId 
        });
        action.setCallback(this, function(response) {
            component.set('v.isLoading', false);
            var state = response.getState();
            if (state === 'SUCCESS') {
            }
        });
        $A.enqueueAction(action);
    },

    showNotification: function (component, title, message, variant) {
        component.find("notifLib").showToast({
            variant,
            title: `${title} \n`,
            message,
        });
    }
})