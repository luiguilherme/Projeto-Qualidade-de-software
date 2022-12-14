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
				};
				
				callback(response.getReturnValue());
			});
	        $A.enqueueAction(apexCall);
		} else {
			console.log('this Exception: Component  TicketHistory access not granted. Please initialize it.');
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

	getTicketHistory: function(component, event, helper){
		let accountId = component.get('v.recordId');
		
		helper.callApex(component,'getTicketHistory',{accountId},(returnValueSalesforce) =>{                    
            
            if(returnValueSalesforce){
                helper.showToast('', $A.get("$Label.c.LoadingDataMessage"), 'info', 50);
                
                helper.callApex(component,'createTicketHistory',{accountId},(returnValueIntegration) =>{
                    if(returnValueIntegration){
                        $A.get('e.force:refreshView').fire();  
                    }
                    component.set('v.showSpinner',false);
                });
            }else{
                component.set('v.showSpinner',false);
            }
        });
	}
})