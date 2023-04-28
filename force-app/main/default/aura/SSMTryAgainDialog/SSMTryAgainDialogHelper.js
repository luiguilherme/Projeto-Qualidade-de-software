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
        this.beforeCallAction();

		LightningUtil.callApex(
			component,
			"fetchInformationStatus",
			{},
			(returnValue) => {
                let positionInformationStatus = returnValue["success"];
                let workPositionId = component.get("v.workPositionId"); 

                if (!positionInformationStatus || 
                    positionInformationStatus.statusPosition != "A" || 
                    positionInformationStatus.workPositionId != workPositionId
                ) {
                    component.set("v.disableButtonTryAgain", true);

                } else {
                    let pageOperation = component.get("v.pageOperation");

                    if (pageOperation == "home") {
                        this.closeTryAgainDialog(component);

                    } else {
                        this.getInformationAttendance(component);
                    }
                }

				this.afterCallAction();
			},
			(exceptions) => {
                component.set("v.disableButtonTryAgain", true);
            }
		);
    },

    backHome : function(component, event, helper) {
        LightningUtil.removeItemLocalStorage("SSMErrorMessage");

        this.notifyStoreServiceManager({type: "forceRestart"});
    },

	getInformationAttendance : function(component) {
		this.beforeCallAction();

		LightningUtil.callApex(
			component,
			"fetchInformationAttendance",
			{},
			(returnValue) => {
                let attendanceInformationStatus = returnValue["success"];
                let serviceTicket = component.get("v.serviceTicket"); 

                if (!attendanceInformationStatus ||
                    attendanceInformationStatus.statusAttendance != "2" || 
                    attendanceInformationStatus.ticketId != serviceTicket.ticketId
                ) {
                    component.set("v.disableButtonTryAgain", true);

				} else {
                    this.closeTryAgainDialog(component);
                }
				
				this.afterCallAction();
			},
			(exceptions) => {
                component.set("v.disableButtonTryAgain", true);
			}
		);
	},

    closeTryAgainDialog : function(component) {
        let errorMessage = component.get("v.errorMessage");
        let pageOperation = component.get("v.pageOperation");

        LightningUtil.setItemLocalStorage("SSMErrorMessage", errorMessage, "ERROR");

        if (pageOperation === "home") {
            this.notifySSMHomeOperations(true);
        }

        this.notifyStoreServiceManager({type: "closeTryAgainDialog"});
    },
    
    beforeCallAction : function() {
		this.notifyStoreServiceManager({type: "beforeCallAction"});
	},

	afterCallAction: function() {
		this.notifyStoreServiceManager({type: "afterCallAction", errorMessage: ""});
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