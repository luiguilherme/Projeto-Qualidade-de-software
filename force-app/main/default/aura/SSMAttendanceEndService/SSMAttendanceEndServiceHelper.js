({
    doInit : function(component, event, helper) {
        let ltActivities = component.get("v.ltActivities");

        if (ltActivities && ltActivities.length > 0) {
            this.fetchSelectedAndFilteredActivities(component);

        } else {
            component.set("v.ltFilteredActivities", []);
            component.set("v.ltSelectedsActivities", []);
        }
    },
    
    fetchSelectedAndFilteredActivities : function (component) {
        let serviceTicket = component.get("v.serviceTicket");

        let ltCategories = component.get("v.ltCategories");
        let ltActivities = component.get("v.ltActivities");
        let ltFilteredActivities = [];

        // What activities should be displayed
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
        
        // Selecteds activities
        if (serviceTicket.activities) {
            let ltInteractions = [];
            
            try {
                ltInteractions = JSON.parse(serviceTicket.activities);
            
            } catch (error) {

            }

            if (ltInteractions && ltInteractions.length > 0) {
                let ltSelectedsActivities = [];

                for (let activity in ltInteractions) {
                    ltSelectedsActivities.push(ltInteractions[activity].value);
                }

                component.set("v.ltSelectedsActivities", ltSelectedsActivities);
            }
        }
    },

    onSelectActivity : function(component, event, helper) {
        let serviceTicket = component.get("v.serviceTicket");

        let ltFilteredActivities = component.get("v.ltFilteredActivities");
        let ltSelectedsActivities = component.get("v.ltSelectedsActivities");

        let ltInteractions = ltFilteredActivities.filter(activity => ltSelectedsActivities.indexOf(activity.value) > -1);

        if (ltInteractions.length > 0) {
            serviceTicket.activities = JSON.stringify(ltInteractions);

        } else {
            serviceTicket.activities = "";
        }

        component.set("v.serviceTicket", serviceTicket);

        LightningUtil.setItemLocalStorage("SSMTicketInfo", JSON.stringify(serviceTicket), "TICKET");
    },

    onNotesChange : function(component, event, helper) {
        let serviceTicket = component.get("v.serviceTicket");

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
