({
    doInit : function(component, event, helper){
        helper.showOffer(component);
    },
    
    startMigrationProcess : function (component, event, helper) {
        var isCanvasHybris = component.get('v.isCanvasHybris')
        if (isCanvasHybris) {
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
        var interactionId = event.getParam("sobject");

        if (selectedTypeFromEvent == 'closeCanvasHybris') {
            if (interactionId != component.get('v.recordId')) {
                component.set('v.showCanvas ', false);   
                component.set('v.showResetButton', false);
            }
        }
    },

    handleClick : function (cmp, event, helper) {
        cmp.set('v.assetMigrationNumber ', JSON.parse(event.getParam('data'))); //Para remover as Aspas duplas
        cmp.set('v.showAssetMigrationSelection', false);
        helper.createCustomerInteractionTopic(cmp);
        cmp.set('v.showResetButton', true);
    },

    resetCanvasHybris : function(component, event, helper) {
        //helper.closeCustomerInteractionTopic(cmp);
        component.set('v.showCanvas', false);
        component.set('v.showAssetMigrationSelection', true);
        component.set('v.showResetButton', false);

        var compEvent = component.getEvent("c:BroadcastNotification");
        compEvent.setParams({
            type: "closeCanvasHybris"
        });
        compEvent.fire();
    }
})