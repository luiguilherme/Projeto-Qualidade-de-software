({
    doInit: function (component, event, helper) {

        if(window.LightningUtil === undefined){
			component.set('v.loadUtil', true);
		}else{
            helper.loadColumsAsset(component);
            helper.loadColumsTicket(component); 

            LightningUtil.callApex(component,'getAccountRetentionFixed',{accountId : component.get('v.recordId')},(retorno) =>{
            
                for(var index in retorno){
                    for(var baIndex in retorno[index].ltAsset ){
                        retorno[index].ltAsset[baIndex].actionDisabledFixed = false;
                        retorno[index].ltAsset[baIndex].actionDisabledSuspicion = false;
                    }
                }
                component.set('v.ltAccount', retorno);
             });
        }   
    },

    handleRowAction :function(component, event, helper){ 
        var action = event.getParam('action');
        var row = event.getParam('row');
        helper.showToast('', $A.get("$Label.c.LoadingDataMessage"),'info', 3000);   

        switch(action.name){
            case 'viewFixedMassive':
                helper.getMassive(component, row, 'Massiva');
                break;
            case 'viewSuspicionMassive':
                helper.getSuspicion(component, row, 'Suspeita de Massiva');
                break;
            default:
                break;    
        }
    },

    handleClickAction :function(component, event, helper){ 
        var action = event.getSource().get("v.name");
        var row = event.getSource().get("v.value");
        helper.showToast('', $A.get("$Label.c.LoadingDataMessage"),'info', 3000);



        switch(action){
            case 'viewFixedMassive':
                helper.getMassive(component, row, 'Massiva');
                break;
                case 'viewSuspicionMassive':
                helper.getSuspicion(component, row, 'Suspeita de Massiva');
                break;
            default:
                break;    
    }
}
})