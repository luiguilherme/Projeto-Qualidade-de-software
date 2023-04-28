({
    doInit : function(component, event, helper) {
        let pageOperation = component.get("v.pageOperation");
        let errorMessage = component.get("v.errorMessage");
        let lastErrorMessage = LightningUtil.getItemLocalStorage("SSMErrorMessage", "ERROR");

        if (lastErrorMessage && lastErrorMessage === errorMessage) {
            component.set("v.errorMessage", $A.get("$Label.c.StoreServiceManagerErrorEndService"));
            component.set("v.disableButtonTryAgain", true);
        }

        if (pageOperation === "home") {
            this.notifySSMHomeOperations(false);
        }
    },

    tryAgain : function(component, event, helper) {
        let errorMessage = component.get("v.errorMessage");
        let pageOperation = component.get("v.pageOperation");

        LightningUtil.setItemLocalStorage("SSMErrorMessage", errorMessage, "ERROR");

        if (pageOperation === "home") {
            this.notifySSMHomeOperations(true);
        }

        this.notifyStoreServiceManager({type: "closeTryAgainDialog"});
    },

    backHome : function(component, event, helper) {
        LightningUtil.removeItemLocalStorage("SSMErrorMessage");

        this.notifyStoreServiceManager({type: "forceRestart"});
    },

    notifyStoreServiceManager : function(jsonSSM) {
        this.notitySSM("StoreServiceManager", jsonSSM);
    },

    notifySSMHomeOperations : function(toggle) {
        this.notitySSM("SSMHomeOperations", {type: "activate", value: toggle});
    },

    notitySSM : function(typeSSM, jsonSSM) {      
        let eventSSM = $A.get('e.c:BroadcastNotification');

        eventSSM.setParam("type", typeSSM);
        eventSSM.setParam("sobject", null);
        eventSSM.setParam("json", jsonSSM);

        eventSSM.fire();
    },
    
})