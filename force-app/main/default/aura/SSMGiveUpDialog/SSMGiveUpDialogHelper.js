({
	doInit : function(component) {
        /* Context for future improvements
		let serviceTicket = component.get("v.serviceTicket");
		
        if (serviceTicket.giveUpReasonDialog) {
            if (serviceTicket.giveUpReasonDialog !== "?") {               
                let treeGiveUpReasons = component.find("treeGiveUpReasons");

                treeGiveUpReasons.set("v.selectedItem", serviceTicket.giveUpReasonDialog);

                component.set('v.giveUpReason', serviceTicket.giveUpReasonDialog);
                component.set('v.disableConfirmButton', !serviceTicket.giveUpReasonDialog);
            }

        } else {
            this.updateGiveUpReasonDialog(component, "?");
        }
        */
    },

    onSelectGiveUpReason : function (component, event, helper) {
        event.preventDefault();

        let giveUpReason = event.getParam('name');

        component.set('v.giveUpReason', giveUpReason);
        component.set('v.disableConfirmButton', !giveUpReason);

        /* Context for future improvements
        this.updateGiveUpReasonDialog(component, giveUpReason);
        */
    },

    /* Context for future improvements
    updateGiveUpReasonDialog : function(component, giveUpReason) {
		let serviceTicket = component.get("v.serviceTicket");

        if (giveUpReason !== serviceTicket.giveUpReasonDialog) {
            serviceTicket.giveUpReasonDialog = giveUpReason;

            LightningUtil.setItemLocalStorage("SSMTicketInfo", JSON.stringify(serviceTicket), "TICKET");            
        }
    },
    */

    closeDialog : function(component, event, helper) {
        this.showErrorMessage(component, "");

        /* Context for future improvements
        this.updateGiveUpReasonDialog(component, "");
        */

        this.notifySSMAttendanceOperations({type: "closeGiveUpDialog"});
    },

    confirmGiveUp : function(component, event, helper) {
        let giveUpReason = component.get("v.giveUpReason");

        this.showErrorMessage(component, "");

        if (giveUpReason) {
            /* Context for future improvements
            this.updateGiveUpReasonDialog(component, "");
            */

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
