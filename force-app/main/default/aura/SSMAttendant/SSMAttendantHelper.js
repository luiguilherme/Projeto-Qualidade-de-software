({
    Mode : {
        Wait: "WAIT",
        Ready: "READY",
        Started: "STARTED",
        Paused: "PAUSED",
    },

	doInit : function(component) {
        let attendant = component.get("v.attendant");

        if (!attendant) {
            return;
        }
            
        if (!attendant.StoreSegment__c) {
            this.showErrorMessage(54);

            return;
        }
        
        let segmentLabel = $A.get("$Label.c.StoreServiceManagerOwnStore").toUpperCase().replace("Ó", "O");
        let segmentStore = attendant.StoreSegment__c.toUpperCase().replace("Ó", "O");

        component.set("v.isOwnerStore", segmentStore === segmentLabel);

        let workPositionId = component.get("v.workPositionId");
        
        if (workPositionId) {
            this.restart(component);

        } else {
            this.getPickListWorkPositions(component, true);
        }
    },

    getPickListWorkPositions : function(component, doReady) {
        let ltWorkPosition = component.get("v.ltWorkPosition");
        
        if (ltWorkPosition.length == 0) {
            this.beforeCallAction();

            LightningUtil.callApex(
                component,
                "getPositionPicklistValues",
                {},
                (returnValue) => {
                    let errorMessage = "";

                    if (returnValue["success"]) {
                        component.set("v.ltWorkPosition", returnValue["success"]);

                        if (doReady) {
                            this.ready(component);
                        }

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
        }
    },

	ready : function(component) {
        this.fetchOperationalInformations(component);
        
        this.updateControls(component, this.Mode.Ready);
    },

    preStart : function(component) {
        var workPositionId = component.get("v.workPositionId");
        var method = "resumeService";

        let params = {};
        let mode = component.get("v.mode");

        if (mode != this.Mode.Paused) {
            // Start only
            if (workPositionId) {
                method = "startService";
                params = {workPositionId: workPositionId};

            } else {
                // Select available position
                this.showErrorMessage(613);

                return;
            }
        }

        this.beforeCallAction();

        LightningUtil.callApex(
            component,
            method,
            params,
            (returnValue) => {
                let errorMessage = "";

                if (returnValue["success"]) {
                    if (method === "startService") {
                        let attendant = component.get("v.attendant");
                        let windowName = window.name;
                        
                        if (!windowName) {
                            windowName = (
                                $A.get("$Label.c.StoreServiceManagerTicketService") + " | " + 
                                $A.get("$Label.c.Attendant") + ": " + attendant.Login__c + " - " +
                                attendant.Name
                            );

                            window.name = windowName;
                        }

                        /* 
                            Context for future improvements
							Add openManualServiceDialog to the SSMAttendantInfo structure to use to open 
                            the Manual Service dialog.

							openedManualServiceDialog: ""
						*/

                        LightningUtil.setItemLocalStorage(
                            "SSMAttendantInfo", 
                            JSON.stringify({
                                windowName: windowName, 
                                attendantId: attendant.Login__c, 
                                storeId: attendant.StoreCode__c, 
                                workPositionId: workPositionId,
                                date: (new Date().toLocaleDateString()),
                                time: (new Date().toLocaleTimeString())
                            }), 
                            "ATTENDANT"
                        );
                    }

                    this.notifyStoreServiceManager({type: "InService", value: true});
                    this.notifySSMTickets(true);

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

    start : function(component, thereAreTickets) {
        component.set("v.pauseReasonId", "");

        LightningUtil.removeItemLocalStorage("SSMPauseInfo");
        
        this.notifySSMHomeOperations(thereAreTickets);

        this.updateControls(component, this.Mode.Started);
    },

    restart : function(component) {
        let workPositionId = component.get("v.workPositionId");
        let isPaused = false;
        
        let lsSSMPauseInfo = LightningUtil.getItemLocalStorage("SSMPauseInfo", "PAUSE");

        if (lsSSMPauseInfo) {
            let SSMPauseInfo;

            try {
                SSMPauseInfo = JSON.parse(lsSSMPauseInfo);

            } catch (error) {

            }

            if (SSMPauseInfo && (SSMPauseInfo.date && SSMPauseInfo.date === (new Date().toLocaleDateString()))) {
                isPaused = true;

                if (SSMPauseInfo.pauseReason && SSMPauseInfo.pauseReason.value) {
                    component.set("v.pauseReasonId", SSMPauseInfo.pauseReason.value);
                }
            }
        }

        component.set("v.ltWorkPosition", [{label: workPositionId, value: workPositionId}]);

        this.updateControls(component, ((isPaused) ? this.Mode.Paused : this.Mode.Started));
        this.getPickListAttendantPauseOptions(component);

        component.set("v.restart", !isPaused);
    },

    cancelPause : function(component) {
        component.set("v.pauseReasonId", '');
        component.set("v.doLogout", false);
        component.set("v.isOpenPauseWithLogoutDialog", false);
        
        this.notifySSMHomeOperations(true);
    },

    confirmPause : function(component) {
        component.set("v.doLogout", true);
        component.set("v.isOpenPauseWithLogoutDialog", false);

        this.pause(component);
    },

    prePause : function(component) {
        let mode = component.get("v.mode")

        if (mode == this.Mode.Started) {
            var pauseReasonId = component.get("v.pauseReasonId");

            let disablePauseReason = component.get("v.disablePauseReason");

            if (disablePauseReason || pauseReasonId) {
                let showLogoutDialog = false;

                this.notifySSMHomeOperations(false);

                if (!disablePauseReason) {
                    let ltPauseReason = component.get("v.ltPauseReason");

                    let pauseReason = ltPauseReason.filter(function(checkItemReasonPause) {
                        return checkItemReasonPause.value === pauseReasonId;
                    });

                    showLogoutDialog = (pauseReason[0].instruction == "1");
                }

                if (showLogoutDialog) {
                    component.set("v.isOpenPauseWithLogoutDialog", true);

                } else {
                    this.pause(component);
                }

            } else {
                this.showErrorMessage(623);
            }
        }
    },

    pause : function(component) {
        var selectedPauseReason;

        let disablePauseReason = component.get("v.disablePauseReason");
        let pauseServiceParams = {"pauseReason": null};

        if (!disablePauseReason) {
            let ltPauseReason = component.get("v.ltPauseReason");
            var pauseReasonId = component.get("v.pauseReasonId");

            let pauseReason = ltPauseReason.filter(function(checkItemReasonPause) {
                return checkItemReasonPause.value === pauseReasonId;
            });

            selectedPauseReason = pauseReason[0];

            pauseServiceParams = {"pauseReason": selectedPauseReason};
        }

        this.beforeCallAction();

        LightningUtil.callApex(
            component,
            "pauseService",
            pauseServiceParams,
            (returnValue) => {
                let errorMessage = "";

                if (returnValue["success"]) {
                    let logout = component.get("v.doLogout");
                    
                    if (logout) {
                        this.finish(component);

                    } else {
                        this.updateControls(component, this.Mode.Paused);
                            
                        this.notifySSMTickets(false);

                        LightningUtil.setItemLocalStorage(
                            "SSMPauseInfo", 
                            JSON.stringify({
                                pauseReason: selectedPauseReason, 
                                date: (new Date().toLocaleDateString()),
                                time: (new Date().toLocaleTimeString())
                            }),
                            "PAUSE"
                        );
                    }

                } else {
                    this.notifySSMHomeOperations(true);

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

    update : function(component) {
        let mode = component.get("v.mode")

        if (mode == this.Mode.Started || mode == this.Mode.Paused) {
            this.notifySSMTickets(true);
        }
    },

	preFinish : function(component) {
        let mode = component.get("v.mode")

        if (mode == this.Mode.Started || mode == this.Mode.Paused) {
            let workPositionId = component.get("v.workPositionId");

            this.notifySSMHomeOperations(false);

            this.beforeCallAction();

            LightningUtil.callApex(
                component,
                "endService",
                {"workPositionId": workPositionId},
                (returnValue) => {
                    let errorMessage = "";
    
                    if (returnValue["success"] ) {
                        this.finish(component);
    
                    } else {
                        this.notifySSMHomeOperations(true);

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
        }
    },

    finish : function(component) {
        LightningUtil.removeItemLocalStorage("SSMTicketInfo;SSMPauseInfo;SSMAttendantInfo");
        
        component.set("v.ltWorkPosition", []);
        component.set("v.workPositionId", "");
        component.set("v.pauseReasonId", "");
        component.set("v.doLogout", false);
        
        this.notifySSMTickets(false);
        this.notifySSMHomeOperations(false);
        this.notifyStoreServiceManager({type: "InService", value: false});

        this.updateControls(component, this.Mode.Ready);

        this.getPickListWorkPositions(component, false);
    }, 

    updateControls : function(component, mode) {
        let isOwnerStore = component.get("v.isOwnerStore");
        let workPositionId = component.get("v.workPositionId");

        component.set("v.mode", mode);

        component.set("v.disablePosition", (mode != this.Mode.Ready || workPositionId != ""));
        component.set("v.disablePauseReason", (!isOwnerStore || mode != this.Mode.Started));
        component.set("v.disablePause", (mode != this.Mode.Started));
        component.set("v.disableUpdate", (mode == this.Mode.Wait || mode == this.Mode.Ready || mode == this.Mode.Paused));
        component.set("v.disableStart", (mode != this.Mode.Ready && mode != this.Mode.Paused));
        component.set("v.disableFnish", (mode != this.Mode.Started && mode != this.Mode.Paused));
    },

    fetchOperationalInformations : function(component) {
        let ltPauseReason = component.get("v.ltPauseReason");
        
        if (ltPauseReason.length == 0) {
            this.beforeCallAction();

            LightningUtil.callApex(
                component,
                "fetchOperationalInformations",
                {},
                (returnValue) => {
                    let errorMessage = "";

                    if (returnValue["success"] || returnValue["uptodate"]) {
                        this.getPickListAttendantPauseOptions(component);

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
        }
    },

	getPickListAttendantPauseOptions : function(component) {
        this.beforeCallAction();

        LightningUtil.callApex(
            component,
            "getPickListAttendantPauseOptions",
            {},
            (returnValue) => {
                let errorMessage = "";

                if (returnValue["success"]) {
                    component.set("v.ltPauseReason", returnValue["success"]);

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

    BroadcastNotificationHandler : function(component, event) {       
        if (event.getParam("type") == "SSMAttendant") {
            event.stopPropagation();

            let jsonSSM = event.getParam("json");

			if  (jsonSSM.type == "fetchServiceTickets") {
                this.start(component, jsonSSM.thereAreTickets);
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

    notifySSMTickets : function(fetch) {
        this.notitySSM("SSMTickets", {type: "fetchServiceTickets", value: fetch, notify: "SSMAttendant"});
    },

    notifySSMHomeOperations : function(toggle) {
        this.notitySSM("SSMHomeOperations", {type: "activate", value: toggle});
    },
    
    notitySSMChronometer : function(jsonSSM) {
        this.notitySSM("SSMChronometer", jsonSSM);
    },

    notitySSM : function(typeSSM, jsonSSM) {      
        let eventSSM = $A.get('e.c:BroadcastNotification');

        eventSSM.setParam("type", typeSSM);
        eventSSM.setParam("sobject", null);
        eventSSM.setParam("json", jsonSSM);

        eventSSM.fire();
    },

})
