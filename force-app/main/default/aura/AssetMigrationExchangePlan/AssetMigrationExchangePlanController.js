({
    doInit : function(component, event, helper){
        helper.showOffer(component);
    },
    
    showCanvas : function (component, event, helper) {
        //helper.callCreditAnalysis(component);
        var isCanvasHybris = component.get('v.isCanvasHybris')
        if (isCanvasHybris) {
            console.log("exibe canvas")
        } else {
            LightningUtil.fireNotification(
                'Atenção',
                'No momento você está sem acesso à funcionalidade de Troca de Oferta, verifique com o seu CSL/SAL.',
                'error',
                5000
            );

            //component.set('v.showErrors ', true);
            console.log("nao exibe canvas")
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
    }

})