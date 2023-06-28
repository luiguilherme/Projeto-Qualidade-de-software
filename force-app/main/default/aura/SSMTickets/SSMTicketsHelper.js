({
    AutomaticUpdate : {
        secondsToUpdate: 0, 
        setTimeoutCallBack: null, 
        runUpdate: false
    },

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

        this.AutomaticUpdate.secondsToUpdate = component.get("v.timeAutomaticUpdate");

        this.setAutomaticUpdateTimeout(component, false);
        this.restart(component);
    },

    restart : function(component) {
        let restart = component.get("v.restart");

        if (restart) {
            this.fetchPointOfServiceTitckets(component, "SSMAttendant", false);
        }
    },

    fetchPointOfServiceTitckets : function(component, notify, selfUpdate) {       
        let tblWaitingCustomers = component.find("tblWaitingCustomers");
        
        tblWaitingCustomers.set("v.selectedRows", []);
        
        this.beforeCallAction();

        LightningUtil.callApex(
            component,
            "getPointOfServiceTitckets",
            {},
            (returnValue) => {
                const ltServiceTicketsOld = component.get("v.ltServiceTickets");

                let ltServiceTickets = [];
                let errorMessage = "";

                if (returnValue["success"]) {
                    ltServiceTickets = returnValue["success"];

                } else {
                    errorMessage = returnValue["error"];
                }

                component.set("v.ltServiceTickets", ltServiceTickets);

                if (this.AutomaticUpdate.secondsToUpdate > 0 && !this.AutomaticUpdate.runUpdate) {
                    this.setAutomaticUpdateTimeout(component, true);
                }
                
                if (selfUpdate) {
                    if ((ltServiceTickets.length === 0 && ltServiceTicketsOld.length !== 0) ||
                        (ltServiceTickets.length !== 0 && ltServiceTicketsOld.length === 0)
                    ) {
                        this.notifySSMHomeOperations(ltServiceTickets.length > 0);
                    }

                } else if (notify) {
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

    setAutomaticUpdateTimeout : function(component, activate) {
        if (this.AutomaticUpdate.setTimeoutCallBack != null) {
            window.clearTimeout(this.AutomaticUpdate.setTimeoutCallBack);
        }
        
        if (this.AutomaticUpdate.secondsToUpdate > 0) {      
            if (activate) {
                if (this.AutomaticUpdate.runUpdate) {
                    this.fetchPointOfServiceTitckets(component, "", true);
                }

                this.AutomaticUpdate.setTimeoutCallBack = setTimeout(
                    $A.getCallback(() => this.setAutomaticUpdateTimeout(component, true)), 
                    (this.AutomaticUpdate.secondsToUpdate * 1000)
                );

                this.AutomaticUpdate.runUpdate = true;

            } else {
                this.AutomaticUpdate.setTimeoutCallBack = null;
                this.AutomaticUpdate.runUpdate = false;
            }
        }
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
                    this.fetchPointOfServiceTitckets(component, jsonSSM.notify, false);
                    
                } else {
                    this.setAutomaticUpdateTimeout(component, false);
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
