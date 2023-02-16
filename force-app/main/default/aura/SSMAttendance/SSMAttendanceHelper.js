({
    doInit : function(component) {
        let ltCategories = component.get("v.ltCategories");
        let ltDocumentTypes = component.get("v.ltDocumentTypes");       
        let ltActivities = component.get("v.ltActivities");
        let ltGiveUpReasons = component.get("v.ltGiveUpReasons");

        if (ltCategories && ltCategories.length > 0 &&
            ltDocumentTypes && ltDocumentTypes.length > 0 &&
            ltActivities && ltActivities.length > 0 &&
            ltGiveUpReasons && ltGiveUpReasons.length > 0
        ) {
            this.loadSSMAttendance(component);

        } else {
            this.fetchAttendanceOperationalInformations(component);
        }
    },

    loadSSMAttendance : function(component) {
        let serviceTicket = component.get("v.serviceTicket");

        if (serviceTicket.view) {
            component.set("v.showView", serviceTicket.view);

            return;
        }

        this.setShowView(component, "ATTENDANCE");

        if (serviceTicket.customerInteractionId) {
            this.navigateToObjetcPage(component, serviceTicket.customerInteractionId);

            return;
        }

        if (serviceTicket.customerCellPhone || serviceTicket.customerDocument) {
            this.fetchAccountInfo(component);
        }
    },

    fetchAttendanceOperationalInformations : function(component) {
        this.beforeCallAction();

        LightningUtil.callApex(
            component,
            "fetchAttendanceOperationalInformations",
            {},
            (returnValue) => {
                let errorMessage = "";
                
                if (returnValue["error"]) {
                    errorMessage = returnValue["error"];

                } else {
                    component.set("v.ltCategories", returnValue["categories"]);
                    component.set("v.ltDocumentTypes", returnValue["documentTypes"]);
                    component.set("v.ltActivities", returnValue["activities"]);
                    component.set("v.ltGiveUpReasons", returnValue["quittingReasons"]);
                    
                    this.loadSSMAttendance(component);
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

    fetchAccountInfo : function(component) {
        var serviceTicket = component.get("v.serviceTicket");

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

                    if (returnValue["CustomerInteractionId"]) {
                        serviceTicket.customerInteractionId = returnValue["CustomerInteractionId"];
                    }

                    // Resolves customer segment
                    if (!serviceTicket.segmentation) {
                        if (returnValue["segment"]) {
                            let segment = returnValue["segment"];
                            
                            serviceTicket.segmentation = segment.value;
                            serviceTicket.segmentationName = segment.label;
                        }
                    }

                    component.set("v.serviceTicket", serviceTicket);

                    LightningUtil.setItemLocalStorage("SSMTicketInfo", JSON.stringify(serviceTicket), "TICKET");

                    this.navigateToObjetcPage(component, serviceTicket.customerInteractionId);
                    
                } else {
                    // Error: Not found or FATAL_ERROR | Internal Salesforce.com Error
                    this.resolvesCustomerSegment(component);
                    this.createLead();
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

    /* Aqui somente para ver como vai ficar Comunidades... Depois de resolver, remover este trecho de código
    navigateToAccountPage : function(component, accountId) {
        let partnerCommunityLicense = component.get("v.partnerCommunityLicense");
        
        if (partnerCommunityLicense) {
            let accountWindowOpenURL = ($A.get("$Label.c.StoreServiceManagerAccountWindowOpenURL")).replace("{accountId}", accountId);

            window.open(accountWindowOpenURL, "_blank");

        } else {
            let navigateToAccountPageEvent = $A.get("e.force:navigateToSObject");

            navigateToAccountPageEvent.setParams({
                recordId: accountId
            });

            navigateToAccountPageEvent.fire();
        }
    },
    */

    navigateToObjetcPage : function(component, objectId) {
        let navigateToObjectPageEvent = $A.get("e.force:navigateToSObject");

        navigateToObjectPageEvent.setParams({
            recordId: objectId
        });

        navigateToObjectPageEvent.fire();
    },
    
    createLead : function() {
        let createLeadRecordEvent = $A.get("e.force:createRecord");
        
        createLeadRecordEvent.setParams({
            "entityApiName": "Lead"
        });

        createLeadRecordEvent.fire();
    },

    resolvesCustomerSegment : function(component) {
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
                        
                        LightningUtil.setItemLocalStorage("SSMTicketInfo", JSON.stringify(serviceTicket), "TICKET");
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
                this.setShowView(component, jsonSSM.view);
            }
        }
    },

    setShowView : function(component, showView) {
        let serviceTicket = component.get("v.serviceTicket");

        serviceTicket.view = showView;
        
        component.set("v.showView", showView);
        component.set("v.serviceTicket", serviceTicket);

        LightningUtil.setItemLocalStorage("SSMTicketInfo", JSON.stringify(serviceTicket), "TICKET");
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
