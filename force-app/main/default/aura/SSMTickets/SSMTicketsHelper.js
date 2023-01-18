({
	doInit : function(component) {
        let attendant = component.get("v.attendant");

        if (!attendant || !attendant.StoreSegment__c) {
            return;
        }

        let workPositionId = component.get("v.workPositionId");
        let viewFieldService = component.get("v.viewFieldService");

        if (workPositionId) {
            if (!viewFieldService) {
                this.getViewFieldService(component);
            }

        } else {
            this.initDatatable(component, false, false);
        }
    },

    getViewFieldService : function(component) {
        this.beforeCallAction();

        LightningUtil.callApex(
            component,
            "getViewFieldServiceParam",
            {},
            (returnValue) => {
                let viewFieldService = false;
                let errorMessage = "";

                if (returnValue["success"]) {
                    viewFieldService = returnValue["success"];

                } else {
                    errorMessage = returnValue["error"];
                }

                component.set("v.viewFieldService", 1);

                this.initDatatable(component, viewFieldService, true);

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

    initDatatable : function(component, viewFieldService, doFetch) {
		let ltServiceTicketsColumns = [];
        
        if (viewFieldService) {
            ltServiceTicketsColumns = [
                {label: $A.get("$Label.c.Ticket"), fieldName: "ticketId", type: "text"},
                {label: $A.get("$Label.c.Name"), fieldName: "customerName", type: "text"},
                {label: $A.get("$Label.c.Segmentation"), fieldName: "segmentationName", type: "text"},
                {label: $A.get("$Label.c.Wait"), fieldName: "waitTime", type: "text"},
                {label: $A.get("$Label.c.Service"), fieldName: "serviceName", type: "text"}
            ];

        } else {
            ltServiceTicketsColumns = [
                {label: $A.get("$Label.c.Ticket"), fieldName: "ticketId", type: "text"},
                {label: $A.get("$Label.c.Name"), fieldName: "customerName", type: "text"},
                {label: $A.get("$Label.c.Segmentation"), fieldName: "segmentationName", type: "text"},
                {label: $A.get("$Label.c.Wait"), fieldName: "waitTime", type: "text"}
            ];
        }

		component.set("v.ltServiceTicketsColumns", ltServiceTicketsColumns);

        if (doFetch) {
            let workPositionId = component.get("v.workPositionId");

            if (workPositionId) {
                this.fetchPointOfServiceTitckets(component);
            }
        }
    },

    preFetchPointOfServiceTitckets : function(component) {
        let viewFieldService = component.get("v.viewFieldService");

        if (!viewFieldService) {
            this.getViewFieldService(component, true);

        } else {
            this.fetchPointOfServiceTitckets(component);
        }
    },

    fetchPointOfServiceTitckets : function(component) {       
        let tblWaitingCustomers = component.find("tblWaitingCustomers");
        
        tblWaitingCustomers.set("v.selectedRows", []);
        
        this.beforeCallAction();

        LightningUtil.callApex(
            component,
            "getPointOfServiceTitckets",
            {},
            (returnValue) => {
                let ltServiceTickets = [];
                let errorMessage = "";

                if (returnValue["success"]) {
                    ltServiceTickets = returnValue["success"];

                } else {
                    errorMessage = returnValue["error"];
                }

                component.set("v.ltServiceTickets", ltServiceTickets);
                
                this.notifySSMAttendant(ltServiceTickets.length > 0);

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
        if (event.getParam("type") == "SSMTickets") {
            event.stopPropagation();

            let jsonSSM = event.getParam("json");

			if  (jsonSSM.type == "fetchServiceTickets") {
                if (jsonSSM.value) {
                    this.preFetchPointOfServiceTitckets(component);

                } else {
                    component.set("v.ltServiceTickets", []);
                }

            } else if (jsonSSM.type == "getServiceTicket") {
                if (jsonSSM.notify) {
                    this.notifyAboutGetServiceTicket(component, jsonSSM.notify, jsonSSM.attendanceType, jsonSSM.index);
                }
            }
		}
    },

    showErrorMessage: function(errorMessage) {
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

    notifySSMAttendant : function(thereAreTickets) {
        this.notitySSM("SSMAttendant", {type: "fetchServiceTickets", thereAreTickets: thereAreTickets});
    },

    notifyAboutGetServiceTicket : function(component, notify, attendanceType, index) {
        let ltServiceTickets = component.get("v.ltServiceTickets");
        let serviceTicket;

        if (attendanceType === "FORCED") {
            let tblWaitingCustomers = component.find("tblWaitingCustomers");
            let ltTicketIds = tblWaitingCustomers.get("v.selectedRows");

            if (ltTicketIds.length > 0) {
                let ticketId = ltTicketIds[0];

                let ltSelectedTickets = ltServiceTickets.filter(function(checkTicket) {
                    return checkTicket.ticketId === ticketId;
                });

                if (ltSelectedTickets.length > 0) {
                    serviceTicket = ltSelectedTickets[0];
                }
            }
        }

        if (!serviceTicket) {
            if (ltServiceTickets.length > 0) {
                let serviceTicketIndex = ((index) ? index : 0);

                serviceTicket = ltServiceTickets[serviceTicketIndex];
            }
        }

        this.notitySSM(notify, {type: "getServiceTicket", serviceTicket: serviceTicket});
    },

    notitySSM : function(typeSSM, jsonSSM) {
        let eventSSM = $A.get('e.c:BroadcastNotification');

        eventSSM.setParam("type", typeSSM);
        eventSSM.setParam("sobject", null);
        eventSSM.setParam("json", jsonSSM);

        eventSSM.fire();
    },

})