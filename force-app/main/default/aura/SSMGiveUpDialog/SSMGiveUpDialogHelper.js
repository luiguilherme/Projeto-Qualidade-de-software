({
	doInit : function(component) {

    },

    onSelectGiveUpReason : function (component, event, helper) {
        event.preventDefault();

        let giveUpReason = event.getParam('name');

        component.set('v.giveUpReason', giveUpReason);
        component.set('v.disableConfirmButton', !giveUpReason);
    },

    closeDialog : function(component, event, helper) {
        this.showErrorMessage(component, "");

        this.notifySSMAttendanceOperations({type: "closeGiveUpDialog"});
    },

    confirmGiveUp : function(component, event, helper) {
        let giveUpReason = component.get("v.giveUpReason");

        this.showErrorMessage(component, "");

        if (giveUpReason) {
            this.notifySSMAttendanceOperations({type: "doGiveUp", giveUpReasonName: giveUpReason});

        } else {
            this.showErrorMessage(component, $A.get("$Label.c.StoreServiceManagerSelectReasonWithdrawal"));
        }
    },

    showErrorMessage : function(component, errorMessage) {
		component.set("v.errorMessage", errorMessage);
    },

    notifySSMAttendanceOperations : function(jsonSSM) {
        let eventSSM = $A.get('e.c:BroadcastNotification');

        eventSSM.setParam("type", "SSMAttendanceOperations");
        eventSSM.setParam("sobject", null);
        eventSSM.setParam("json", jsonSSM);

        eventSSM.fire();
    },

})
