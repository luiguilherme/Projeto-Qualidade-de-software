({
	getGPSFlow : function (component, event, helper) {
        LightningUtil.callApex(component, 'getGPSFlow', { flowId : component.get('v.recordId') }, (returnValue) => {
            if(returnValue['success'] !== undefined){
                var listFlow = returnValue['success'];
                component.set("v.listFlow", listFlow);                        
                
				$A.get('e.force:refreshView').fire();
		} else if(returnValue['error'] !== undefined){

			var toastEvent = $A.get("e.force:showToast");
			toastEvent.setParams({
				message: returnValue['error'],
				type: 'error',
				duration:'5000',
            });

            toastEvent.fire();
			$A.get('e.force:refreshView').fire();
			$A.get('e.force:closeQuickAction').fire();
            }
        })

        $A.enqueueAction(action);
	},

	updateGPSFlowId : function (component, event, helper, recordId, flowId, gpsFlow) {
		LightningUtil.callApex(component, 'updateGPSFlowId', {recordId : recordId , flowId : flowId, gpsFlow : gpsFlow}, (returnValueSalesforce) => {
			if (returnValueSalesforce) {
				component.set("v.listflow", returnValueSalesforce);
			}
		})
        location.reload();
	}
})