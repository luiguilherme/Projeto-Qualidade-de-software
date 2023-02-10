({
	setParameters : function(component, event, params) {
		component.set("v.isloading", true);
		component.set("v.canvasAppName",    '');
		component.set("v.canvasParameters",    {});

        const callbackError = (exceptions) => {
            component.set("v.isloading", false);
            component.set("v.canOpenCanvas", false);
            component.set("v.showErrorMessage", true);
            this.showNotification(
                component,
                "Erro",
                "Ocorreu um erro ao recuperar os parâmetros para abertura do canvas GPS, tente novamente.",
                "error"
            );
        };

		try {
			var action = component.get("c.getCanvasData");

			
			action.setParams({ recordId : params.AccountId, serviceFlowId : params.TopicTreeId, assetInstance : params.Asset, caseId : params.CaseId });
			action.setCallback(this, function(response) {
				var state = response.getState();
				debugger;
				
				if (state === "SUCCESS") {
					let resultCanvas = response.getReturnValue();
					window.console.log('resultCanvas: ' + JSON.stringify(resultCanvas));
					component.set("v.isloading", false);
					component.set("v.canOpenCanvas",    resultCanvas.canOpenCanvas);
					component.set("v.showErrorMessage", !(resultCanvas.canOpenCanvas));
					component.set("v.canvasAppName",    resultCanvas.canvasAppName);
					resultCanvas.parameters.CustomerInteractionId = params.CustomerInteractionId;
					resultCanvas.parameters.CustomerInteractionTopicId = params.CustomerInteractionTopicId;
					component.set("v.canvasParameters", JSON.stringify(resultCanvas.parameters));
					
				}
			});

			$A.enqueueAction(action);
			
		} catch (error) {
			window.console.log(error);
		}
		
	},
    showNotification: function (component, title, message, variant) {
        component.find("notifLib").showToast({
            variant,
            title: `${title} \n`,
            message,
        });
    },
})