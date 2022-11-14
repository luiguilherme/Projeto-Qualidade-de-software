({
	getPrevisionDate: function(component, event, helper){
		LightningUtil.callApex(component,'getTicketPrevisionDate',{ticketId : component.get('v.recordId')},(returnValueSalesforce) =>{
			
			if(returnValueSalesforce){
				$A.get('e.force:refreshView').fire();
				
				switch(returnValueSalesforce){
					case '200':
						LightningUtil.fireNotification('','Dados atualizados com sucesso','success', 5000);   
						break;

					case '404':
						LightningUtil.fireNotification('','Não há dados para atualizar o bilhete de defeito!','info', 5000);   
						break;

					default:
						LightningUtil.fireNotification('',$A.get("$Label.c.ContactTheAdministrator"),'error', 5000);   
						break;
				}
			}
		});    
	}
})