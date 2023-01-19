({
    callSubscribed : function(component){
		LightningUtil.fireNotification('', $A.get("$Label.c.LoadingDataMessage"),'info', 5000);
		LightningUtil.callApex(component,'getSubscribedProducts',{accountId : component.get('v.recordId')},(returnCall) =>{

			if(returnCall != null && returnCall.Message != null){
				LightningUtil.fireNotification('',returnCall.Message,returnCall.Status, 5000); 

				if(returnCall.Status == 'warning' && returnCall.Message.includes('tipo de cliente')){
					$A.get('e.force:refreshView').fire();
				}
			}else{
				$A.get('e.force:refreshView').fire();
			}
			
			//Envia um start para componente de GPS.
			this.sendEvent();                
		});
	},

	sendEvent: function(){

		var evt = $A.get('e.c:BroadcastNotification');
		evt.setParam('type', 'ServiceFlowGPSInit');
        evt.fire();
	}
})