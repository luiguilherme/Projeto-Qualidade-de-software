({
    doInit : function(component, event, helper) {
        let ltGiveUpReasons = component.get("v.ltGiveUpReasons");

        if (ltGiveUpReasons) {
            if (ltGiveUpReasons.length > 0) {
                component.set("v.ltGiveUpReasons", ltGiveUpReasons);

            } else {
                this.showErrorMessage(component, $A.get("$Label.c.StoreServiceManagerListReasonsWithdrawalEmpty"));
            }

        } else {
            this.showErrorMessage(component, $A.get("$Label.c.StoreServiceManagerListReasonsWithdrawalError"));
        }
    },

    onSelectGiveUpReason : function (component, event, helper) {
        event.preventDefault();

        component.set('v.disableConfirmButton', false);
        component.set('v.giveUpReason', event.getParam('name'));
    },

    closeDialog : function(component, event, helper) {
        this.showErrorMessage(component, "");

        this.notifySSMAttendanceOperations({type: "closeGiveUpDialog"});
    },

    confirmGiveUp : function(component, event, helper) {
        var giveUpReason = component.get("v.giveUpReason");

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