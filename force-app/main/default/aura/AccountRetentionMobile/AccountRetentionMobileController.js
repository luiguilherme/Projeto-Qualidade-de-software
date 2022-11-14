({
    doInit: function (component, event, helper) {

        component.set('v.columnsAsset', [
            {label: 'Plano', fieldName: 'MainProductDescription__c', type: 'text' , cellAttributes: { alignment: 'center' }},
            {label: 'Titular', fieldName: 'HolderDependent__c', type: 'text', cellAttributes: { alignment: 'center' }},
            {label: 'Possui Bônus', fieldName: 'HasBonusFormula__c', type: 'text' , cellAttributes: { alignment: 'center' }},
            {label: 'Possui Desconto', fieldName: 'HasDiscountFormula__c', type: 'text' , cellAttributes: { alignment: 'center' }},
            {label: 'Valor', fieldName: 'PriceCurrent__c', type: 'currency' , cellAttributes: { alignment: 'center' }},
            {label: 'Excedente', fieldName: 'PriceOver__c', type: 'currency' , cellAttributes: { alignment: 'center' }},
            {label: 'Sistema de Origem', fieldName: 'LegacySystem__c', type: 'text' , cellAttributes: { alignment: 'center' }},
        ]);
        
        helper.getAccount(component, event, helper); 
    },

    doEvent: function (component, event, helper) {
        var sourceItem = event.getParam("sourceItem");
        if(sourceItem =='mobile'){
            var cmpEvent = $A.get("e.c:CardOfferEvent");
                cmpEvent.setParams({
                "sourceOffermobile"       : "mobile",
                "ltBillingAccountMobile": component.get("v.ltBillingAccount"),
                "ltOfferAlta": component.get("v.ltOfferAlta"),
                "selectedOfferAltaId": component.get("v.selectedOfferAltaId")
                });
            cmpEvent.fire();
       	}            
    },

    callCreditAnalysis: function (component, event, helper) {
        var accordeonName = component.find("accordionOfferAlta").get('v.activeSectionName')
        if(!accordeonName || accordeonName != 'A')return 
        
        helper.callCreditAnalysis(component)
    }
});