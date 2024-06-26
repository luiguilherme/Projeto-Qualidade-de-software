({
    doInit : function(component, event, helper){
        helper.checkAccessToComponent(component);
    },
    
    startMigrationProcess : function (component, event, helper) {
        helper.checkAccessToComponent(component);
        var haveTokenAccess = component.get('v.haveTokenAccess')
        var haveUserAccess = component.get('v.haveUserAccess')
        var showCanvas = component.get('v.showCanvas')
		
        if (haveTokenAccess && haveUserAccess) {
            component.set('v.showAssetMigrationSelection', true);
        } else {
            component.set('v.showModal', true);
        }
        
        if (showCanvas) {
            component.set('v.showAssetMigrationSelection', false);
        }
    },
    
    handleComponentEvent : function (component,event, helper) {
        var selectedTypeFromEvent = event.getParam("type");

        if (selectedTypeFromEvent == 'closeCanvas') {
            component.set('v.showCanvas ', false);   
            component.set('v.showResetButton', false);
        }
    },

    handleClick : function (cmp, event, helper) {
        cmp.set('v.assetMigrationNumber ', JSON.parse(event.getParam('data'))); //Para remover as Aspas duplas
        cmp.set('v.showAssetMigrationSelection', false);
        helper.createCustomerInteractionTopic(cmp);
        cmp.set('v.showResetButton', true);
    },

    updateTitle : function (cmp, event, helper) {
        cmp.set('v.title ', JSON.parse(event.getParam('data')));
    },

    resetCanvasHybris : function(component, event, helper) {
        //helper.closeCustomerInteractionTopic(cmp);
        component.set('v.title ', 'Troca de Ofertas');
        component.set('v.showCanvas', false);
        component.set('v.showAssetMigrationSelection', true);
        component.set('v.showResetButton', false);

        var compEvent = component.getEvent("BroadcastNotification");
        
        compEvent.setParams({
            type: "closeCanvasHybris"
        });
        compEvent.fire();
    },

    modalClosed : function(component, event){
        component.set('v.showModal', false);
    }
})