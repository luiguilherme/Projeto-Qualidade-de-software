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
        var assetObject = component.get('v.assetMigrationNumber');
        action.setParams({
            "customerInteractionId" : customerInteractionId, 
            "assetId" : assetObject.Id
        });
        action.setCallback(this, function(response) {
            component.set('v.isLoading', false);
            var state = response.getState();
            if (state === 'SUCCESS') {
                let assetObj = component.get('v.assetMigrationNumber'); 
                assetObj.topicId = response.getReturnValue().success.Id;
                component.set('v.topicId', response.getReturnValue().success.Id);
                component.set('v.assetMigrationNumber', assetObj);
                component.set('v.showCanvas', true);
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
    },
    
    closeCustomerInteractionTopic: function (component) {
       //apex para trocar o motivo QUANDO FOR "Solicitação > Comercial > Migrar / Alterar Plano > Fluxo em Andamento" do customerInte
    }
})