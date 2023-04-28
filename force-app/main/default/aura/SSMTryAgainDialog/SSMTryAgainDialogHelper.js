({
    doInit : function(component, event, helper) {
        let pageOperation = component.get("v.pageOperation");
        let errorMessage = component.get("v.errorMessage");
        let lastErrorMessage = LightningUtil.getItemLocalStorage("SSMErrorMessage", "ERROR");

        if (pageOperation === "home") {
            this.notifySSMHomeOperations(false);
        }

        if (lastErrorMessage && lastErrorMessage === errorMessage) {
            component.set("v.errorMessage", $A.get("$Label.c.StoreServiceManagerErrorEndService"));
        }

        this.beforeCallAction();

        LightningUtil.callApex(
            component,
            "fetchInformationStatus",
            {},
            (returnValue) => {
                let positionInformationStatus = returnValue["success"];
                let workPositionId = component.get("v.workPositionId"); 
                let newWorkPositionId = "";
                let disableButtonTryAgain = false;
                let disableButtonBackHome = false;

                if (positionInformationStatus && 
                    positionInformationStatus.statusPosition === "A"
                ) {
                    if (positionInformationStatus.workPositionId === workPositionId) {
                        let pageOperation = component.get("v.pageOperation");

                        if (pageOperation == "home") {
                            disableButtonBackHome = true;

                        } else {
                            this.getInformationAttendance(component);
                        }

                    } else {
                        newWorkPositionId = positionInformationStatus.workPositionId;
                        disableButtonTryAgain = true;
                    }

                } else {
                    disableButtonTryAgain = true;
                }

                component.set("v.newWorkPositionId", newWorkPositionId);
                component.set("v.disableButtonTryAgain", disableButtonTryAgain);
                component.set("v.disableButtonBackHome", disableButtonBackHome);

                this.afterCallAction();
            },
            (exceptions) => {
                component.set("v.disableButtonTryAgain", true);
            }
        );
    },

	getInformationAttendance : function(component) {
		this.beforeCallAction();

		LightningUtil.callApex(
			component,
			"fetchInformationAttendance",
			{},
			(returnValue) => {
                let attendanceInformationStatus = returnValue["success"];
                let disableButtonTryAgain = false;
                let disableButtonBackHome = false;
                let forceInitialPageService = false;

                if (attendanceInformationStatus && 
                    attendanceInformationStatus.statusAttendance === "2"
                ) {
                    let serviceTicket = component.get("v.serviceTicket");

                    disableButtonBackHome = true;
                    forceInitialPageService = (attendanceInformationStatus.ticketId !== serviceTicket.ticketId);

                } else {
                    disableButtonTryAgain = true;
                }

                component.set("v.attendanceInformationStatus", attendanceInformationStatus);
                component.set("v.disableButtonTryAgain", disableButtonTryAgain);
                component.set("v.disableButtonBackHome", disableButtonBackHome);
                component.set("v.forceInitialPageService", forceInitialPageService);
				
				this.afterCallAction();
			},
			(exceptions) => {
                component.set("v.disableButtonTryAgain", true);
			}
		);
	},
    
    tryAgain : function(component, event, helper) {
        let errorMessage = component.get("v.errorMessage");
        let pageOperation = component.get("v.pageOperation");

        LightningUtil.setItemLocalStorage("SSMErrorMessage", errorMessage, "ERROR");

        if (pageOperation === "home") {
            this.notifySSMHomeOperations(true);

        } else {
            let forceInitialPageService = component.get("v.forceInitialPageService");

            if (forceInitialPageService) {
                let attendanceInformationStatus = component.get("v.attendanceInformationStatus");

				let serviceTicket = {
                    type: '',
                    view: '',
                    workPositionId: attendanceInformationStatus.workPositionId,
                    displayAlert: true,
                    ticketId: attendanceInformationStatus.ticketId,
                    customerSpecialNeeds: false,
                    customerPriority: 2,
                    customerId: '',
                    customerName: attendanceInformationStatus.customerName,
                    customerAlias: attendanceInformationStatus.customerName,
                    customerDocument: attendanceInformationStatus.customerDocument,
                    customerCellPhone: attendanceInformationStatus.customerCellPhone,
                    segmentation: attendanceInformationStatus.segmentationId,
                    segmentationName: attendanceInformationStatus.segmentationName,
                    activity: '',
                    protocol: '',
                    waitTime: attendanceInformationStatus.waitTime,
                    startTime: attendanceInformationStatus.startTime,
                    finalTime: '',
                    duration: attendanceInformationStatus.duration,
                    service: '',
                    serviceName: attendanceInformationStatus.serviceName,
                    category: '',
                    categoryName: '',
                    mainDocumentType: '',
                    documentNumber: '',
                    giveUpReason: '',
                    activities: '',
                    notes: ''
				};

                component.set("v.serviceTicket", serviceTicket);

                this.notifySSMAttendance();
            }
        }

        this.notifyStoreServiceManager({type: "closeTryAgainDialog"});
    },

    backHome : function(component, event, helper) {
        let workPositionId = component.get("v.workPositionId"); 
        let newWorkPositionId = component.get("v.newWorkPositionId"); 

        if (newWorkPositionId && newWorkPositionId !== workPositionId) {
            component.set("v.workPositionId", newWorkPositionId);
        }

        LightningUtil.removeItemLocalStorage("SSMErrorMessage");

        this.notifyStoreServiceManager({type: "forceRestart"});
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

    notifySSMAttendance : function() {
        this.notitySSM("SSMAttendance", {type: "changeView", view: "ATTENDANCE"});
    },

    notitySSM : function(typeSSM, jsonSSM) {      
        let eventSSM = $A.get('e.c:BroadcastNotification');

        eventSSM.setParam("type", typeSSM);
        eventSSM.setParam("sobject", null);
        eventSSM.setParam("json", jsonSSM);

        eventSSM.fire();
    },
    
})