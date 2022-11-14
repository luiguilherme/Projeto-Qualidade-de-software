({
    loadColumsAsset: function(component){
		component.set('v.columnsAsset', [
            {label: 'Plano', fieldName: 'MainProductDescription__c', type: 'text'},
            {label: 'Instância', fieldName: 'Instance__c', type: 'text'},
            {label: 'Massiva Fixa', type: 'button', initialWidth: 150, typeAttributes:
                { label: { fieldName: 'actionLabelFixed'}, title: 'Click para visualizar casos de massiva fixa', name: 'viewFixedMassive', label: 'Verificar', iconName: 'utility:preview', disabled: {fieldName: 'actionDisabledFixed'}, class: 'btn_next'}},
            {label: 'Suspeita de Massiva', type: 'button', initialWidth: 150, typeAttributes:
                { label: { fieldName: 'actionLabelSuspect'}, title: 'Click para visualizar casos de suspeita de massivas', name: 'viewSuspicionMassive', label: 'Verificar', iconName: 'utility:preview', disabled: {fieldName: 'actionDisabledSuspicion'}, class: 'btn_next'}}
        ]);
	},

	loadColumsTicket: function(component){
		component.set('v.columnsTicket', [
            {label: 'Origem da Incidência', fieldName: 'OrigemIncidencia', type: 'text'},
            {label: 'Produto Afetado', fieldName: 'ProdutoAfetado', type: 'text'},
            {label: 'Previsão de Normalização', fieldName: 'PrevisaoNormalizacao', type: 'text'},
        ]);
	},

	getMassive : function(component, row, origin){
		var ltMassive = [];
		ltMassive = component.get('v.ltMassive');
	
		var ltBillingAccount = component.get('v.ltAccount');
		for(var index in ltBillingAccount){
			for(var baIndex in ltBillingAccount[index].ltAsset ){
				if(ltBillingAccount[index].ltAsset[baIndex].Id === row.Id){
					ltBillingAccount[index].ltAsset[baIndex].actionDisabledFixed = true;
				}
				
			}
		}

		component.set('v.ltAccount', ltBillingAccount);

		LightningUtil.callApex(component,'getMassiveFixed',{assetInstance : row.Instance__c},(retorno) =>{
            if(retorno['success'] === 'null' || retorno['success'] === ''){
				this.showToast('', $A.get("$Label.c.MassiveBillingAccountWithoutItem"),'error', 5000);
			}                  
			else if(retorno['success'] !== undefined ){
				var returnMap = JSON.parse(retorno['success']);

				if(returnMap.NetworkProblems.length == 0 ){
					this.showToast('', $A.get("$Label.c.MassiveBillingAccountWithoutItem"),'error', 5000);   
				}

				for(var i = 0; i < returnMap.NetworkProblems.length; i++){
					var massiveFixed = {}
					massiveFixed.OrigemIncidencia = origin;
					massiveFixed.ProdutoAfetado = '';
					if(returnMap.NetworkProblems[i].NetworkProblem.resourcesAffected != null && returnMap.NetworkProblems[i].NetworkProblem.resourcesAffected.length > 0){
						for(var index = 0; index < returnMap.NetworkProblems[i].NetworkProblem.resourcesAffected.length; index++){
							massiveFixed.ProdutoAfetado += returnMap.NetworkProblems[i].NetworkProblem.resourcesAffected[index] + ' ' ;
						}
					}
					massiveFixed.PrevisaoNormalizacao = returnMap.NetworkProblems[i].NetworkProblem.previsionDate;

					ltMassive.push(massiveFixed);

				}

				component.set('v.showMassive', true);
				component.set('v.ltMassive', ltMassive);
        }else if(retorno['error'] !== undefined){
				this.showToast('', $A.get("$Label.c.MassiveBillingAccountWithoutItem"),'error', 5000);
			}
        });
	},

	getSuspicion : function(component, row, origin){
		var ltMassive = [];
		var productType = '';
		ltMassive = component.get('v.ltMassive');
	
		var ltBillingAccount = component.get('v.ltAccount');
		for(var index in ltBillingAccount){
			for(var baIndex in ltBillingAccount[index].ltAsset ){
				if(ltBillingAccount[index].ltAsset[baIndex].Id === row.Id){
					ltBillingAccount[index].ltAsset[baIndex].actionDisabledSuspicion = true;
					if(ltBillingAccount[index].ltAsset[baIndex] != undefined && ltBillingAccount[index].ltAsset[baIndex].ProductType__c != undefined){
						productType = ltBillingAccount[index].ltAsset[baIndex].ProductType__c;
					}
				}	
			}
		}
		component.set('v.ltAccount', ltBillingAccount);
		
		LightningUtil.callApex(component,'getMassiveSuspicion',{assetInstance : row.Instance__c},(retorno) =>{
			if(retorno['success'] === '{}'){
				this.showToast('', $A.get("$Label.c.MassiveBillingAccountWithoutItem"),'error', 5000);
			}else if(retorno['success'] !== undefined){
				var returnMap = JSON.parse(retorno['success']);

				var massiveSuspicion = {};
				massiveSuspicion.OrigemIncidencia = origin;
				massiveSuspicion.ProdutoAfetado = productType;
				if(returnMap.networkProblem != undefined && returnMap.networkProblem.previsionDate != undefined){
					massiveSuspicion.PrevisaoNormalizacao = returnMap.networkProblem.previsionDate;
				}

				ltMassive.push(massiveSuspicion);
				component.set('v.showMassive', true);
				component.set('v.ltMassive', ltMassive);
			} else if(retorno['error'] !== undefined){
				this.showToast('', $A.get("$Label.c.MassiveBillingAccountError"),'error', 5000);
			}
        });
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

})