({
    doInit : function(component, event, helper){
        helper.showOffer(component);
    },
    
    startMigrationProcess : function (component, event, helper) {
        var isCanvasHybris = component.get('v.isCanvasHybris')
        if (isCanvasHybris) {
            helper.createCustomerInteractionTopic(component);
            component.set('v.showAssetMigrationSelection', true);
        } else {
            LightningUtil.fireNotification(
                'Atenção',
                'No momento você está sem acesso à funcionalidade de Troca de Oferta, verifique com o seu CSL/SAL.',
                'error',
                5000
            );
        }
    },
    
    handleComponentEvent : function (component,event, helper) {
        var selectedTypeFromEvent = event.getParam("type");
        var accountId = event.getParam("sobject");

        if (selectedTypeFromEvent == 'closeCanvasHybris') {
            if (accountId != component.get('v.recordId')) {
                component.set('v.showCanvas ', false);    
            }
            
        }
    },

    handleClick : function (cmp, event, helper) {
        cmp.set('v.assetMigrationNumber ', JSON.parse(event.getParam('data'))); //Para remover as Aspas duplas
        cmp.set('v.showCanvas', true);
    }
})