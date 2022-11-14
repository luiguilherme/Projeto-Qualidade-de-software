({
    doInit: function (component, event, helper) {

        component.set('v.columnsAsset', [
            {label: 'Plano', fieldName: 'MainProductDescription__c', type: 'text'},
            {label: 'Instância', fieldName: 'Instance__c', type: 'text'},
            {label: 'Streaming', fieldName: 'Streaming__c', type: 'text'},
            {label: 'Sistema de Origem', fieldName: 'LegacySystem__c', type: 'text'}
        ]);
        
        helper.getAccount(component, event, helper); 
    },
    
    doEvent: function (component, event, helper) {        
        var sourceItem = event.getParam("sourceItem");
        if(sourceItem == 'fixed'){
            
            var cmpEvent = $A.get("e.c:CardOfferEvent");
            cmpEvent.setParams({
                "sourceOfferfixed"       : "fixed",            
                "ltBillingAccountFixed": component.get("v.ltBillingAccount")
            });
            cmpEvent.fire();
            
        }       
        
    },   
});