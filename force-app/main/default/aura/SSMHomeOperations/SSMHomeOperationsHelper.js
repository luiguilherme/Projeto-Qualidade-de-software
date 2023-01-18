({
    AttendanceType : {
        Auto: "AUTO",
        Manual: "MANUAL",
        Forced: "FORCED"
    },

    doInit : function(component, event, helper) {
        let attendant = component.get("v.attendant");

        if (!attendant || !attendant.StoreSegment__c) {
            return;
        }
        
        let workPositionId = component.get("v.workPositionId");
        let timeAutomaticTicketCall = component.get("v.timeAutomaticTicketCall")

        if (workPositionId && !timeAutomaticTicketCall) {
            this.getTimeAutomaticTicketCall(component, false, false);
        }
    },

    getTimeAutomaticTicketCall : function(component, doActivate, enable) {
        var defaultTimeAutomaticTicketCall = 15;

        this.beforeCallAction();

		LightningUtil.callApex(
			component,
			"getTimeAutomaticTicketCallParam",
			{},
			(returnValue) => {
                let timeAutomaticTicketCall = defaultTimeAutomaticTicketCall;
				let errorMessage = "";

				if (returnValue["success"]) {
                    timeAutomaticTicketCall = returnValue["success"];

                } else {
                    errorMessage = returnValue["error"];
				}

                component.set("v.timeAutomaticTicketCall", timeAutomaticTicketCall);

                this.notitySSMChronometer({type: "secondsToAction", value: timeAutomaticTicketCall});

                if (doActivate) {
                    this.activate(component, enable);
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
    
    preActivate : function(component, enable) {
        let timeAutomaticTicketCall = component.get("v.timeAutomaticTicketCall")

        if (!timeAutomaticTicketCall) {
            this.getTimeAutomaticTicketCall(component, true, enable);

        } else {
            this.activate(component, enable);
        }
    },

    activate : function(component, enable) {
        let workPositionId = component.get("v.workPositionId");
        let pauseReasonId = component.get("v.pauseReasonId");

        let activatedOthers = (workPositionId && !pauseReasonId);

        component.set("v.activatedOthers", activatedOthers);
        component.set("v.activated", enable);

        this.notitySSMChronometer((enable) ? {type: "play"} : {type: "stop"});
    },

    manualAttendance : function(component, event, helper) {
        this.notitySSMChronometer({type: "stop"});

        component.set("v.isOpenManualServiceDialog", true);
    },

    preAttendance : function(component, type) {
        component.set("v.attendanceType", type)

        this.notifySSMTickets({type: "getServiceTicket", index: 0, attendanceType: type, notify: "SSMHomeOperations"});
    },

    attendance : function(component) {
        var attendanceType = component.get("v.attendanceType");
        var serviceTicket = component.get("v.serviceTicket");

        let workPositionId = component.get("v.workPositionId");
        let displayAlert = component.get("v.displayAlert");

        serviceTicket.type = attendanceType;
        serviceTicket.workPositionId = workPositionId;
        serviceTicket.displayAlert = displayAlert;

		this.beforeCallAction();

		LightningUtil.callApex(
			component,
			"startAttendance",
			{serviceTicket: serviceTicket},
			(returnValue) => {
				let errorMessage = "";

				if (returnValue["success"]) {
                    serviceTicket.startTime = returnValue["startTime"];
                    
                    component.set("v.serviceTicket", serviceTicket);
                    
                    this.posAttendance(component);

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

    posAttendance : function(component) {
        let serviceTicket = component.get("v.serviceTicket");

        this.notitySSMChronometer({type: "stop"});

        if (serviceTicket.type == this.AttendanceType.Manual) {
            serviceTicket.serviceName = $A.get("$Label.c.StoreServiceManagerManualService");

        } else {
            if (!serviceTicket.serviceName) {
                serviceTicket.serviceName = $A.get("$Label.c.StoreServiceManagerTicketService");
            }
        }

        component.set("v.serviceTicket", serviceTicket);
        component.set("v.isOpenManualServiceDialog", false);
    
        let eventSSM = $A.get('e.c:BroadcastNotification');

        eventSSM.setParam("type", "StoreServiceManager");
        eventSSM.setParam("sobject", null);
        eventSSM.setParam("json", {type: "attendance", serviceTicket: serviceTicket});

        eventSSM.fire();
    },

    BroadcastNotificationHandler : function(component, event) {       
        if (event.getParam("type") == "SSMHomeOperations") {
            event.stopPropagation();

            let jsonSSM = event.getParam("json");

            if (jsonSSM.type == "activate") {
                this.preActivate(component, jsonSSM.value);

            } else if (jsonSSM.type == "getServiceTicket") {
                if (jsonSSM.serviceTicket) {
                    component.set("v.serviceTicket", jsonSSM.serviceTicket);
                    
                    this.attendance(component);
                }

            } else if (jsonSSM.type == "closeManualServiceDialog") {
                this.notifySSMTickets({type: "fetchServiceTickets", value: true});

                component.set("v.isOpenManualServiceDialog", false);

            } else if (jsonSSM.type == "confirmManualAttendance") {
                // Manual attendance confirmed
                component.set("v.serviceTicket", jsonSSM.serviceTicket);

                this.posAttendance(component)
            }

		} else {
            let chronometerActionNotificationId = component.get("v.chronometerActionNotificationId");

            if (event.getParam("type") == chronometerActionNotificationId) {
                event.stopPropagation();
                
                this.preAttendance(component, this.AttendanceType.Auto);
            }
        }
    },

    notitySSMChronometer : function(jsonSSM) {
        this.notitySSM("SSMChronometer", jsonSSM);
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

    notifySSMTickets : function(jsonSSM) {
        this.notitySSM("SSMTickets", jsonSSM);
    },

    notitySSM : function(typeSSM, jsonSSM) {
        let eventSSM = $A.get('e.c:BroadcastNotification');

        eventSSM.setParam("type", typeSSM);
        eventSSM.setParam("sobject", null);
        eventSSM.setParam("json", jsonSSM);

        eventSSM.fire();
    },

})