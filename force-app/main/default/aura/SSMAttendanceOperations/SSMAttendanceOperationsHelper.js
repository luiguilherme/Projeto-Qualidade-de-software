({
	doInit : function(component) {

    },

    recall : function(component, event, helper) {
        var serviceTicket = component.get("v.serviceTicket");

		this.beforeCallAction();

		LightningUtil.callApex(
			component,
			"recallTicket",
			{serviceTicket: serviceTicket},
			(returnValue) => {
				let errorMessage = "";

                if (returnValue["success"]) {
                    serviceTicket.startTime = returnValue["startTime"];

                } else {
                   errorMessage = returnValue["error"];
				}

                this.notitySSMChronometer({type: "restart"});

			    this.afterCallAction(errorMessage);
			},
			(exceptions) => {
				try {
                    this.afterCallAction(exceptions[0].message);

				} catch (ex) {
                    this.afterCallAction(601);
				}
			}
		);
    },

    backToHome : function(component, event, helper) {
        var serviceTicket = component.get("v.serviceTicket");

        this.beforeCallAction();

        LightningUtil.callApex(
            component,
            "returnToHome",
            {serviceTicket: serviceTicket},
            (returnValue) => {
				let errorMessage = "";

                if (returnValue["success"]) {
                    this.notifyStoreServiceManager({type: "backToHome"});

                } else {
                    errorMessage = returnValue["error"];
                }

                this.afterCallAction(errorMessage);
            },
            (exceptions) => {
                try {
                    this.afterCallAction(exceptions[0].message);

                } catch (ex) {
                    this.afterCallAction(601);
                }
            }
        );
    },

    preGiveUp : function(component, event, helper) {
        component.set("v.isOpenGiveUpDialog", true);
    },

    giveUp : function(component, giveUpReasonName) {
        let ltGiveUpReasons = component.get("v.ltGiveUpReasons");

        let giveUpReason = ltGiveUpReasons.filter(function(checkItemGiveUpReason) {
            return checkItemGiveUpReason.name === giveUpReasonName;
        });

        component.set("v.isOpenGiveUpDialog", false);

        var serviceTicket = component.get("v.serviceTicket");

        serviceTicket.giveUpReason = JSON.stringify(giveUpReason[0]);

        component.set("v.serviceTicket", serviceTicket);

        this.beforeCallAction();

        LightningUtil.callApex(
            component,
            "giveUp",
            {serviceTicket: serviceTicket},
            (returnValue) => {
				let errorMessage = "";

                if (returnValue["success"]) {
                    this.notifyStoreServiceManager({type: "backToHome"});

                } else {
                    errorMessage = returnValue["error"];
                }

                this.afterCallAction(errorMessage);
            },
            (exceptions) => {
                try {
                    this.afterCallAction(exceptions[0].message);

                } catch (ex) {
                    this.afterCallAction(601);
                }
            }
        );
    },   

    finish : function(component) {
        let serviceTicket = component.get("v.serviceTicket");

        this.beforeCallAction();

        if (!serviceTicket.customerName ||
            !serviceTicket.customerCellPhone ||
            !serviceTicket.category ||
            (serviceTicket.mainDocumentType && !serviceTicket.documentNumber)
        ) {
            this.afterCallAction($A.get("$Label.c.RequiredField"));

            return;
        }

        let refCellPhone = serviceTicket.customerCellPhone
            .replace(" ", "")
            .replace("-", "");

        if (refCellPhone.length != 11 || !/^\d+$/.test(refCellPhone)) {
            this.afterCallAction($A.get("$Label.c.EntryDoesntMatchPattern"));

            return
        }

        this.toggleAttendancePage(component, "ENDSERVICE");

        this.afterCallAction("");
    },

    returnToAttendance : function(component, event, helper) {
        this.toggleAttendancePage(component, "ATTENDANCE");
    },

    toggleAttendancePage : function(component, view) {
        component.set("v.showView", view);

        this.notifySSMAttendance({type: "changeView", view: view});
    },

    confirmService : function(component, event, helper) {
        var serviceTicket = component.get("v.serviceTicket");

        this.beforeCallAction();

        if (!serviceTicket.activities) {
            this.afterCallAction($A.get("$Label.c.RequiredField"));

            return;
        }

        if (serviceTicket.notes) {
            let regex = /^[A-Za-z0-9 .,]+$/;

            if (!regex.test(serviceTicket.notes)) {
                this.afterCallAction($A.get("$Label.c.StoreServiceManagerSpecialCharacterNotAllowedNotes"));

                return;
            }
        }

        serviceTicket.giveUpReason = "";

        component.set("v.serviceTicket", serviceTicket);

        LightningUtil.callApex(
            component,
            "confirmService",
            {serviceTicket: serviceTicket},
            (returnValue) => {
                let errorMessage = "";

                if (returnValue["success"]) {
                    this.notifyStoreServiceManager({type: "backToHome"});

                } else {
                    errorMessage = returnValue["error"];
                }

                this.afterCallAction(errorMessage);
            },
            (exceptions) => {
                try {
                    this.afterCallAction(exceptions[0].message);

                } catch (ex) {
                    this.afterCallAction(601);
                }
            }
        );    
    },

    BroadcastNotificationHandler : function(component, event) {
        if (event.getParam("type") == "SSMAttendanceOperations") {
            event.stopPropagation();

            let jsonSSM = event.getParam("json");

            if (jsonSSM.type == "closeGiveUpDialog") {
                component.set("v.isOpenGiveUpDialog", false);

            } else if (jsonSSM.type == "doGiveUp") {
                this.giveUp(component, jsonSSM.giveUpReasonName);

            } else if (jsonSSM.type == "doFinish") {
                this.finish(component);
            }
        }
    },

    showErrorMessage : function(errorMessage) {
		this.notifyStoreServiceManager({type: "showErrorMessage", errorMessage: errorMessage});
	},

    beforeCallAction : function() {
		this.notifyStoreServiceManager({type: "beforeCallAction"});
	},

	afterCallAction: function(errorMessage) {
		this.notifyStoreServiceManager({type: "afterCallAction", errorMessage: errorMessage});
	},

    notifyStoreServiceManager : function(jsonSSM) {
        this.notitySSM("StoreServiceManager", jsonSSM);
    },

    notifySSMAttendance : function(jsonSSM) {
        this.notitySSM("SSMAttendance", jsonSSM);
    },

    notitySSMChronometer : function(jsonSSM) {
        this.notitySSM("SSMChronometer", jsonSSM);
    },
    
    notitySSM : function(typeSSM, jsonSSM) {
        let eventSSM = $A.get('e.c:BroadcastNotification');

        eventSSM.setParam("type", typeSSM);
        eventSSM.setParam("sobject", null);
        eventSSM.setParam("json", jsonSSM);

        eventSSM.fire();
    },

})
