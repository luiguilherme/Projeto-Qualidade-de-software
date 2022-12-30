({
    getAccount: function (component) {
        var action = component.get("c.getAccountRetentionMobile");
        action.setParams({
            "recordId": component.get('v.recordId')
        });
        action.setCallback(this, function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {

                var returnMap = response.getReturnValue();
                var ltBilling = returnMap['ltBillingAccount'];

                if (ltBilling != null && ltBilling != undefined) {
                    component.set('v.ltBillingAccount', ltBilling);
                    component.set('v.hasBilling', (ltBilling.length > 0));
                }
            }
        });
        $A.enqueueAction(action);
    },

    callCreditAnalysis: function (component) {
        component.set('v.isLoading', true);

        const callbackError = (exceptions) => {
            component.set('v.isLoading', false);
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
            { recordId: component.get('v.recordId') },
            (result) => {
                component.set('v.isLoading', false);
                if (result.RequiredFields) {
                    component.set('v.accountInconsistent', true)
                    component.set('v.CreditAnalisysErrors', result.RequiredFields)
                    return
                }
                if (result.ltOfferAlta) {
                    component.set('v.ltOfferAlta', result.ltOfferAlta);
                    component.set('v.hasOfferAlta', (result.ltOfferAlta.length));
                }
            },
            callbackError
        );
    },


    showNotification: function (component, title, message, variant) {
        component.find("notifLib").showToast({
            variant,
            title: `${title} \n`,
            message,
        });
    },

})