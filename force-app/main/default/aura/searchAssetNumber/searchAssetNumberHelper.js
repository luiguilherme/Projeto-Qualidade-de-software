({
    navigateToRecordPage: function(component){
        var account = component.get("v.account")
        $A.get("e.force:navigateToSObject").setParams({recordId: account.Id}).fire();
    },

    searchAccount: function(component){
        var searchKey = component.find("searchInput").get('v.value')
        component.set("v.isloading", true);

        const callbackError = (exceptions) => {
            component.set("v.isloading", false);
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
            'searchByAssetNumber',
            { searchKey },
            (result) => {
                component.set("v.isloading", false);
               
                if(!result || result.length == 0 ){
                    component.set('v.showCustomerDetail', false)
                    component.set('v.account', null)
                    component.set("v.emptyAccount", true)
                    return
                }
                
                component.set('v.account', result[0].Account)
                component.set("v.emptyAccount", false)
                component.set('v.showCustomerDetail', true)
                
            
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