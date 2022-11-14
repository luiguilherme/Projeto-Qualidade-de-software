({
    callApex: function(component, method, params, callback) {
		if(component){
	        let apexCall = component.get('c.' + method);
            
            if(params != null){
				apexCall.setParams(params);
			}	
	        apexCall.setCallback(this, (response) => {				
				var state = response.getState();
			
				if (state != "SUCCESS") {
					let errors = response.getError();
					let mensagem;
					let type = 'error';
                    let title = 'Erro na consulta';
                    
					if (errors) {
						if (errors[0] && errors[0].message) {
							mensagem = errors[0].message;
						}
                    }
                    		
					if(mensagem == null){
						mensagem = 'Erro na consulta';
					}

					if(mensagem.includes('FIELD_CUSTOM_VALIDATION_EXCEPTION,')){
						let lstError = mensagem.split('FIELD_CUSTOM_VALIDATION_EXCEPTION,');
						mensagem = lstError[1];
						if(mensagem.includes(': []')){
							mensagem =  mensagem.split(': []')[0];
						}
                    }
                    					
					this.showToast(title, mensagem, type, 20);
					component.set('v.showSpinner', false);
				}else{
                    $A.get('e.force:refreshView').fire();
                }
				
				callback(response.getReturnValue());
			});
	        $A.enqueueAction(apexCall);
		} else {
			console.log('this Exception: Component access not granted. Please initialize it.');
		}
    },
    
    showToast: function(title, message, type, duration){
	    var notification = $A.get("e.force:showToast");
	    notification.setParams({
	    	type: type,
	    	title: title,
	        mode: 'dismissible',
	        duration: duration ? duration : 10,
	        message: message
	    });
		notification.fire();
	},

	createInvoiceHistory : function(component, event, helper) {

        helper.callApex(component,'createInvoiceHistory',{customerInteractionId : component.get('v.recordId')},(returnValue) =>{
            this.getMessage(component, event. helper);
			
			if(returnValue != null && returnValue != undefined){
				this.callApex(component, 'updateAssetList', {lstAssetObj : returnValue},(subReturnValue) =>{
					$A.get('e.force:refreshView').fire();
				});
			}
        });
    },

    getMessage : function(component, event, helper){
        this.callApex(component,'getMessage',{customerInteractionId : component.get('v.recordId')},(returnValueMessage) =>{
			component.set("v.messageInvoice",returnValueMessage);
            $A.get('e.force:refreshView').fire();
        });
    }
})