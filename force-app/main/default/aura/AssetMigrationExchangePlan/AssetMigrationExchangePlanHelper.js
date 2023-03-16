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
                console.log("LAS "+ storeResponse);
            }
        });
        $A.enqueueAction(action);
	},  

    callCreditAnalysis: function (component) {
        component.set('v.isLoading', true);
            const callbackError = (exceptions) => {
            component.set('v.isLoading', false);
            try {
                this.showNotification(
                    component,
                    "Erro",
                    exceptions[0].message,
                    "error"
                );

            } catch (ex) {
                this.showNotification(
                    component,
                    "Erro",
                    "Erro ao realizar a operação. Tente novamente mais tarde.",
                    "error"
                );
            }
        };

        LightningUtil.callApex(
            component,
            "checkCreditAnalysis",
            { accountId: component.get('v.recordId') },
            (result) => {
                component.set('v.isLoading', false);
                if (result.success) {
                    var evt = $A.get('e.c:BroadcastNotification');
                    evt.setParam('type', 'updateCurrentAccountId' );
                    evt.setParam('sobject', component.get('v.recordId'));
            
                    evt.fire();
                    component.set('v.showCanvas', true);
                } else {
                    component.set('v.CreditAnalisysErrors', result.RequiredFields);
                }
                
                console.log('AssetMigrationExchangePlanController.doInit - action.callback - resultValue ', result);
            },
            callbackError
        );
    },

        showNotification: function (component, title, message, variant) {
            component.find("notifLib").showToast({
                variant,
                title: `${title} \n`,
                message,
            });
        },

})