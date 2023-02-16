({
	doInit : function(component) {
        let viewFieldService = component.get("v.viewFieldService");
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

        this.restart(component);
    },

    restart : function(component) {
        let restart = component.get("v.restart");

        if (restart) {
            this.fetchPointOfServiceTitckets(component, "SSMAttendant");
        }
    },

    fetchPointOfServiceTitckets : function(component, notify) {       
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
                
                if (notify) {
                    this.notifyAboutFetchServiceTickets(notify, ltServiceTickets.length > 0);
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
        if (event.getParam("type") == "SSMTickets") {
            event.stopPropagation();

            let jsonSSM = event.getParam("json");

			if  (jsonSSM.type == "fetchServiceTickets") {
                let tblWaitingCustomers = component.find("tblWaitingCustomers");
    
                tblWaitingCustomers.set("v.selectedRows", []);

                component.set("v.ltServiceTickets", []);
                    
                if (jsonSSM.value) {
                    this.fetchPointOfServiceTitckets(component, jsonSSM.notify);
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

    notifyAboutFetchServiceTickets : function(notify, thereAreTickets) {
        this.notitySSM(notify, {type: "fetchServiceTickets", thereAreTickets: thereAreTickets});
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
