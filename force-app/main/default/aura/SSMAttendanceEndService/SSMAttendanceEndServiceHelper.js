({
    loadSSMAttendanceEndService : function(component, event, helper) {
        let ltActivities = component.get("v.ltActivities");

        if (ltActivities && ltActivities.length > 0) {
            this.fetchSelectedAndFilteredActivities(component);

            return;
        }
        
        this.beforeCallAction();

        LightningUtil.callApex(
            component,
            "loadSSMAttendanceEndService",
            {},
            (returnValue) => {
                let errorMessage = "";

                if (returnValue["success"]) { 
                    component.set("v.ltActivities", returnValue["success"]);

                    this.fetchSelectedAndFilteredActivities(component);

                } else {
                    component.set("v.ltActivities", []);
                    component.set("v.ltFilteredActivities", []);

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

    onSelectActivity : function(component, event, helper) {
        let serviceTicket = component.get("v.serviceTicket");

        let ltActivities = component.get("v.ltActivities");
        let ltSelecteds = component.get("v.ltSelecteds");

        let ltInteractions = ltActivities.filter(activity => ltSelecteds.indexOf(activity.value) > -1);

        if (ltInteractions.length > 0) {
            serviceTicket.activities = JSON.stringify(ltInteractions);

        } else {
            serviceTicket.activities = "";
        }

        component.set("v.serviceTicket", serviceTicket);
    },

    fetchSelectedAndFilteredActivities : function (component) {
        let serviceTicket = component.get("v.serviceTicket");

        let ltCategories = component.get("v.ltCategories");
        let ltActivities = component.get("v.ltActivities");
        let ltFilteredActivities = [];

        if (serviceTicket.activities) {
            let ltSelecteds = JSON.parse(serviceTicket.activities);

            if (ltSelecteds.length > 0) {
                component.set("v.ltSelecteds", ltSelecteds);
            }
        }

        if (serviceTicket.category) {
            let category = ltCategories.filter(function(checkItemCategory) {
                return checkItemCategory.value.toUpperCase() === serviceTicket.category.toUpperCase();
            });

            if (category.length > 0) {
                ltFilteredActivities = ltActivities.filter(function(checkItemActivity) {
                    return checkItemActivity.instruction.toUpperCase() === category[0].instruction.toUpperCase();
                });
            }
        }

        component.set("v.ltFilteredActivities", ltFilteredActivities);
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