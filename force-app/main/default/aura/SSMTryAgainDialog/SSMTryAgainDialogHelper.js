({
    doInit : function(component, event, helper) {
        let pageOperation = component.get("v.pageOperation");
        let errorMessage = component.get("v.errorMessage");

        if (pageOperation === "home") {
            this.notifySSMTickets(false);
            this.notifySSMHomeOperations(false);
        }

        component.set("v.displayErrorMessage", errorMessage);

        this.getInformationStatus(component);
    },

	getInformationStatus : function(component) {
        this.beforeCallAction();

        LightningUtil.callApex(
            component,
            "fetchInformationStatus",
            {},
            (returnValue) => {
                let positionInformationStatus = returnValue["success"];

                if (positionInformationStatus && positionInformationStatus.statusPosition === "A") {
                    component.set("v.newWorkPositionId", positionInformationStatus.workPositionId);
                
                    this.getInformationAttendance(component);

                } else {
                    this.updateDialog(component, true);
                }

                this.afterCallAction();
            },
            (exceptions) => {
                this.updateDialog(component, true);
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
                let inService = (attendanceInformationStatus && attendanceInformationStatus.statusAttendance === "2");
                let forceInitialPageService = false;

                if  (inService) {
                    let workPositionId = component.get("v.workPositionId"); 
                    let newWorkPositionId = component.get("v.newWorkPositionId"); 
                    let serviceTicket = component.get("v.serviceTicket");

                    forceInitialPageService = (
                        (newWorkPositionId != workPositionId) || 
                        (attendanceInformationStatus.ticketId !== serviceTicket.ticketId)
                    );
                }

                component.set("v.attendanceInformationStatus", attendanceInformationStatus);
                component.set("v.forceInitialPageService", forceInitialPageService);

                this.updateDialog(component, !inService);
                
				this.afterCallAction();
			},
			(exceptions) => {
                this.updateDialog(component, true);
			}
		);
	},

    updateDialog : function(component, enableButtonBackHome) {
        let displayErrorMessage = ((enableButtonBackHome)
            ? $A.get("$Label.c.StoreServiceManagerErrorEndService")
            : $A.get("$Label.c.StoreServiceManagerErrorTryAgainService")
        );

        component.set("v.displayErrorMessage", displayErrorMessage);
        component.set("v.disableButtonTryAgain", enableButtonBackHome);
        component.set("v.disableButtonBackHome", !enableButtonBackHome);
    },

    tryAgain : function(component, event, helper) {
        let errorMessage = component.get("v.errorMessage");
        let forceInitialPageService = component.get("v.forceInitialPageService");

        LightningUtil.setItemLocalStorage("SSMErrorMessage", errorMessage, "ERROR");

        if (forceInitialPageService) {
            let newWorkPositionId = component.get("v.newWorkPositionId"); 
            let attendanceInformationStatus = component.get("v.attendanceInformationStatus");

            let serviceTicket = {
                Id: attendanceInformationStatus.Id,
                createdDateTime: attendanceInformationStatus.createdDateTime,
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

            component.set("v.workPositionId", newWorkPositionId);
            component.set("v.serviceTicket", serviceTicket);

            this.notifySSMAttendance();
        }

        this.notifyStoreServiceManager({type: "closeTryAgainDialog"});
    },

    backHome : function(component, event, helper) {
        let newWorkPositionId = component.get("v.newWorkPositionId"); 

        component.set("v.workPositionId", newWorkPositionId);

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

    notifySSMTickets : function(fetch) {
		this.notitySSM("SSMTickets", {type: "fetchServiceTickets", value: fetch, notify: ((fetch) ? 'SSMHomeOperations' : '')});
    },

    notitySSM : function(typeSSM, jsonSSM) {      
        let eventSSM = $A.get('e.c:BroadcastNotification');

        eventSSM.setParam("type", typeSSM);
        eventSSM.setParam("sobject", null);
        eventSSM.setParam("json", jsonSSM);

        eventSSM.fire();
    },
    
})