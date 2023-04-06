({
    getAccount : function(component) {
        let action = component.get("c.getAccountRetentionMobile");

        action.setParams({
            "recordId": component.get("v.recordId")
        });

        action.setCallback(this, function(response) {
            let state = response.getState();

            if (state === "SUCCESS") {
                let returnMap = response.getReturnValue();
                let ltBilling = returnMap["ltBillingAccount"];
                let hasBilling = false;

                if (ltBilling != null && ltBilling != undefined && ltBilling.length > 0) {
                    ltBilling.forEach(item=>{
                        item.ltAssetMovel.forEach(asset=>{
                            asset.checkboxSelected = false;
                        })
                    });

                    component.set("v.ltBillingAccount", ltBilling);

                    hasBilling = (ltBilling.length > 0);
                }

                component.set("v.hasBilling", hasBilling);
            }
        });

        $A.enqueueAction(action);
    },

    callCreditAnalysis : function(component) {
        component.set("v.isLoading", true);

        const callbackError = (exceptions) => {
            component.set("v.isLoading", false);
            
            try {
                this.showNotification(
                    component,
                    "Erro",
                    exceptions[0].message,
                    "error"
                );

            } catch (ex) {
                this.showNotification(
                    component,
                    "Erro",
                    "Erro ao realizar a operação. Tente novamente mais tarde.",
                    "error"
                );
            }
        };

        LightningUtil.callApex(
            component,
            "checkCreditAnalysis",
            {recordId: component.get("v.recordId")},
            (result) => {
                component.set("v.isLoading", false);

                if (result.RequiredFields) {
                    component.set("v.accountInconsistent", true);
                    component.set("v.CreditAnalisysErrors", result.RequiredFields);

                } else {
                    if (result.ltOfferAlta) {
                        component.set("v.ltOfferAlta", result.ltOfferAlta);
                        component.set("v.hasOfferAlta", (result.ltOfferAlta.length));
                    }

                    if (result.ltOfferITVAlta) {
                        component.set("v.ltOfferITVAlta", result.ltOfferITVAlta);
                    }
                }
            },
            callbackError
        );
    },

    showNotification : function(component, title, message, variant) {
        component.find("notifLib").showToast({
            variant,
            title: `${title} \n`,
            message,
        });
    },

})