({
    doInit : function(component, event, helper) {
        let today = new Date();

        let hours =  (
            today.getHours().toString().padStart(2, "0") + ":" + 
            today.getMinutes().toString().padStart(2, "0")
        );

        component.set("v.scheduleTime", hours);
    },

    onCellPhoneChange : function(component, event, helper) {
        let cellPhone = (
            event.getParam("value")
                .replace(/\D+/g, '')
                .match(/(\d{0,2})(\d{0,5})(\d{0,4})/)
        );

        cellPhone = (
            ((!cellPhone[2])
                ? cellPhone[1] 
                : `${cellPhone[1]} ${cellPhone[2]}` + ((cellPhone[3]) ? `-${cellPhone[3]}` : ``)
            )
        );

        component.set("v.cellPhone", cellPhone);
    },

    closeDialog : function(component, event, helper) {
        this.showErrorMessage(component, "");

        this.notifySSMHomeOperations({type: "closeManualServiceDialog"});
    },

    manualAttendance : function(component, event, helper) {
        var scheduleTime = component.get("v.scheduleTime").substring(0, 5);
        var cellPhone = component.get("v.cellPhone");
        
        this.showErrorMessage(component, "");

        if (!scheduleTime || !cellPhone) {
            this.showErrorMessage(component, $A.get("$Label.c.RequiredField"));

            return;
        }

        let refScheduleTime = scheduleTime.replace(":", "");
        let refCellPhone = cellPhone.replace(" ", "").replace("-", "");

        if ((refScheduleTime.length != 4 || !/^\d+$/.test(refScheduleTime)) ||
            (refCellPhone.length != 11 || !/^\d+$/.test(refCellPhone))
        ) {
            this.showErrorMessage(component, $A.get("$Label.c.EntryDoesntMatchPattern"));

            return
        }

        let workPositionId = component.get("v.workPositionId");
        let displayAlert = component.get("v.displayAlert");
        
        let manualAttendanceParams = {
            workPositionId: workPositionId, 
            displayAlert: displayAlert,
            scheduleTime: (scheduleTime + ((scheduleTime.length == 5) ? ":00" : "")),
            cellPhone: cellPhone
        }

		this.beforeCallAction();

		LightningUtil.callApex(
			component,
			"generateTicket",
			manualAttendanceParams,
			(returnValue) => {
				let errorMessage = "";

				if (returnValue["success"]) {
                    this.notifySSMHomeOperations({
                        type: "confirmManualAttendance", 
                        serviceTicket: returnValue["success"]
                    });

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

    showErrorMessage : function(component, errorMessage) {
		component.set("v.errorMessage", errorMessage);
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

    notifySSMHomeOperations : function(jsonSSM) {
        this.notitySSM("SSMHomeOperations", jsonSSM);
    },

    notitySSM : function(typeSSM, jsonSSM) {
        let eventSSM = $A.get('e.c:BroadcastNotification');

        eventSSM.setParam("type", typeSSM);
        eventSSM.setParam("sobject", null);
        eventSSM.setParam("json", jsonSSM);

        eventSSM.fire();
    },

})
