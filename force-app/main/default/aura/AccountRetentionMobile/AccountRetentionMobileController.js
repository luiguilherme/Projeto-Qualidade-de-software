({
    doInit : function(component, event, helper) {
        component.set("v.columnsAsset", [
            {label: "Plano", fieldName: "MainProductDescription__c", type: "text" , cellAttributes: {alignment: "center"}},
            {label: "Titular", fieldName: "HolderDependent__c", type: "text", cellAttributes: {alignment: "center"}},
            {label: "Possui Bônus", fieldName: "HasBonusFormula__c", type: "text" , cellAttributes: {alignment: "center"}},
            {label: "Possui Desconto", fieldName: "HasDiscountFormula__c", type: "text" , cellAttributes: {alignment: "center"}},
            {label: "Valor", fieldName: "PriceCurrent__c", type: "currency" , cellAttributes: {alignment: "center"}},
            {label: "Excedente", fieldName: "PriceOver__c", type: "currency" , cellAttributes: {alignment: "center"}},
            {label: "Sistema de Origem", fieldName: "LegacySystem__c", type: "text" , cellAttributes: {alignment: "center"}},
        ]);
        
        helper.getAccount(component, event, helper); 
    },

    doEvent : function(component, event, helper) {
        let sourceItem = event.getParam("sourceItem");

        if (sourceItem == "mobile") {
            let cmpEvent = $A.get("e.c:CardOfferEvent");

            cmpEvent.setParams({
                "sourceOffermobile": "mobile",
                "ltBillingAccountMobile": component.get("v.ltBillingAccount"),
                "ltOfferAlta": component.get("v.ltOfferAlta"),
                "selectedOfferAltaId": component.get("v.selectedOfferAltaId")
            });

            cmpEvent.fire();

        } else if (sourceItem == "ITV") {
            // component.set("v.openModal", true); => See OfferBoxItem.cmp
        }            
    },

    closeModal : function(component, event, helper) {
        component.set("v.openModal", false);
    },

    callCreditAnalysis : function(component, event, helper) {
        let accordeonName = component.find("accordionOfferAlta").get("v.activeSectionName");

        if (accordeonName && accordeonName === "A") {
            helper.callCreditAnalysis(component)
        }
    },
    
    onChangeCheckBox : function(component, event, helper) {
        let list = component.get("v.ltBillingAccount");
        let indexList = event.getSource().get("v.name").split("/");

        list[indexList[0]].ltAssetMovel[indexList[1]].checkboxSelected = !list[indexList[0]].ltAssetMovel[indexList[1]].checkboxSelected;
        
        component.set("v.ltBillingAccount", list);

        $A.get("e.force:refreshView").fire();
    },
    
});