({
    doInit : function(component) {
        var serviceTicket = component.get("v.serviceTicket");

        if (serviceTicket.customerInteractionId) {
            this.navigateToObjetcPage(component, serviceTicket.customerInteractionId);

            return;
        }

        if (!serviceTicket.customerCellPhone && !serviceTicket.customerDocument) {
            return;
        }

        this.beforeCallAction();

        LightningUtil.callApex(
            component,
            "getAccount",
            {phoneNumber: serviceTicket.customerCellPhone, documentNumber: serviceTicket.customerDocument},
            (returnValue) => {
                if (returnValue && returnValue["success"]) {
                    let accountServicing = returnValue["success"];

                    if (accountServicing.AccountId != null) {
                        // By Asset
                        serviceTicket.customerId = accountServicing.Account.Id;
                        serviceTicket.customerName = accountServicing.Account.Name;
                        serviceTicket.customerAlias = accountServicing.Account.Name;
                        serviceTicket.customerDocument = accountServicing.Account.DocumentNumber__c;

                    } else {
                        // By Account
                        serviceTicket.customerId = accountServicing.Id;
                        serviceTicket.customerName = accountServicing.Name;
                        serviceTicket.customerAlias = accountServicing.Name;
                        serviceTicket.customerDocument = accountServicing.DocumentNumber__c;
                    }

                    serviceTicket.customerInteractionId = returnValue["CustomerInteractionId"];

                    // Resolves customer segment
                    if (!serviceTicket.segmentation) {
                        if (returnValue["segment"]) {
                            let segment = returnValue["segment"];
                            
                            serviceTicket.segmentation = segment.value;
                            serviceTicket.segmentationName = segment.label;
                        }
                    }

                    component.set("v.serviceTicket", serviceTicket);

                    this.navigateToObjetcPage(component, serviceTicket.customerInteractionId);
            
                } else {
                    // Error: Not found or FATAL_ERROR | Internal Salesforce.com Error
                    this.createLead(component);
                }

                this.afterCallAction();
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

    navigateToObjetcPage : function(component, objectId) {
        let navigateToObjectPageEvent = $A.get("e.force:navigateToSObject");

        navigateToObjectPageEvent.setParams({
            recordId: objectId
        });

        navigateToObjectPageEvent.fire();
    },

    createLead : function(component) {
        let createLeadRecordEvent = $A.get("e.force:createRecord");
        
        createLeadRecordEvent.setParams({
            "entityApiName": "Lead"
        });

        createLeadRecordEvent.fire();

        // Resolves customer segment
        var serviceTicket = component.get("v.serviceTicket");

        if (!serviceTicket.segmentation) {
            this.beforeCallAction();

            LightningUtil.callApex(
                component,
                "getAccountCustomerSegmentGSS",
                {accountCustomerSegment: null},
                (returnValue) => {
                    if (returnValue) {
                        serviceTicket.segmentation = returnValue.value;
                        serviceTicket.segmentationName = returnValue.label;

                        component.set("v.serviceTicket", serviceTicket);
                    }

                    this.afterCallAction();
                },
                (exceptions) => {
                    try {
                        this.afterCallAction(exceptions[0].message);

                    } catch (ex) {
                        this.afterCallAction(601);
                    }
                }
            );
        }
    },

    BroadcastNotificationHandler : function(component, event) {       
        if (event.getParam("type") == "SSMAttendance") {
            event.stopPropagation();

            let jsonSSM = event.getParam("json");

            if (jsonSSM.type == "changeView") {
                component.set("v.showView", jsonSSM.view);
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

    notitySSM : function(typeSSM, jsonSSM) {
        let eventSSM = $A.get('e.c:BroadcastNotification');

        eventSSM.setParam("type", typeSSM);
        eventSSM.setParam("sobject", null);
        eventSSM.setParam("json", jsonSSM);

        eventSSM.fire();
    },

})