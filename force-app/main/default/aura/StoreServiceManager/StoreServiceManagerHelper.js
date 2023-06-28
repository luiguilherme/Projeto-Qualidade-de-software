({
	doInit: function(component) {
		this.beforeCallAction(component);

		LightningUtil.callApex(
			component,
			"hasPermissionSetToAccess",
			{},
			(returnValue) => {
				let errorMessage = "";

				if (returnValue) {
					this.loadStoreServiceManager(component);

				} else {
					// Not Permission Set
					errorMessage = 624;
				}

				this.afterCallAction(component, errorMessage);
			},
			(exceptions) => {
				try {
					this.afterCallAction(component, exceptions[0].message);

				} catch (ex) {
					// Error loading component
					this.afterCallAction(component, 601);
				}
			}
		);
	},

	loadStoreServiceManager : function(component) {
		// Fetch attendant informations (store and work positions) 
		this.beforeCallAction(component);

		LightningUtil.callApex(
			component,
			"loadStoreServiceManager",
			{},
			(returnValue) => {
				let errorMessage = "";

				if (returnValue["attendant"]) {
					let attendant = returnValue["attendant"];
                    let ltWorkPosition = returnValue["workPositionsList"];
					let partnerCommunityLicense = returnValue["partnerCommunityLicense"];
					let params = returnValue["params"];

					component.set("v.attendant", attendant);
                    component.set("v.ltWorkPosition", ltWorkPosition);
					component.set("v.partnerCommunityLicense", partnerCommunityLicense);
					component.set("v.params", params);

					this.getInformationStatus(component);

				} else {
					errorMessage = returnValue["error"];

					this.gotoPageOnInit(component)
				}

				this.afterCallAction(component, errorMessage);
			},
			(exceptions) => {
				try {
					this.afterCallAction(component, exceptions[0].message);

				} catch (ex) {
					// Error loading component
					this.afterCallAction(component, 601);
				}
			}
		);
	},

	getInformationStatus : function(component) {
		this.beforeCallAction(component);

		LightningUtil.callApex(
			component,
			"fetchInformationStatus",
			{},
			(returnValue) => {
				let errorMessage = "";
				let gotoPageInit = true;

				if (returnValue["success"]) {
					let positionInformationStatus = returnValue["success"];

					if (positionInformationStatus) {
						if (positionInformationStatus.statusPosition === "A") {
							let workPositionId = "";

							if (positionInformationStatus.workPositionId) {
								workPositionId = positionInformationStatus.workPositionId;
							}

							component.set("v.workPositionId", workPositionId);
							component.set("v.attendanceInformationStatus", {});

							if (workPositionId) {
								let ltWorkPosition = component.get("v.ltWorkPosition");
								
								let workPosition = ltWorkPosition.filter(function(checkWorkPosition) {
									return checkWorkPosition.value === workPositionId;
								});

								if (!workPosition || workPosition.length === 0) {
									ltWorkPosition.push({"label": workPositionId, "value": workPositionId});
								}

								gotoPageInit = false;
								
								this.getInformationAttendance(component);
							}

						} else if (positionInformationStatus.statusPosition === "I") {
							errorMessage = $A.get("$Label.c.StoreServiceManagerErrorInactiveUserGSS");
							gotoPageInit = false;

							component.set("v.attendant", {});
							component.set("v.ltWorkPosition", []);
						}
					}
				}
				
				if (gotoPageInit) {
					this.gotoPageOnInit(component);
				}

				this.afterCallAction(component, errorMessage);
			},
			(exceptions) => {
				try {
					this.afterCallAction(component, exceptions[0].message);

				} catch (ex) {
					// Error loading component
					this.afterCallAction(component, 601);
				}
			}
		);
	},

	getInformationAttendance : function(component) {
		this.beforeCallAction(component);

		LightningUtil.callApex(
			component,
			"fetchInformationAttendance",
			{},
			(returnValue) => {
				let attendanceInformationStatus = {};

				if (returnValue["success"]) {
					attendanceInformationStatus = returnValue["success"];
				}
				
				component.set("v.attendanceInformationStatus", attendanceInformationStatus);

				this.gotoPageOnInit(component);

				this.afterCallAction(component, errorMessage);
			},
			(exceptions) => {
				try {
					this.afterCallAction(component, exceptions[0].message);

				} catch (ex) {
					// Error loading component
					this.afterCallAction(component, 601);
				}
			}
		);
	},

	gotoPageOnInit : function(component) {
		let workPositionId = component.get("v.workPositionId");
		let gotoPage = "homePage";
		let serviceTicket = {};

		let attendanceInformationStatus = component.get("v.attendanceInformationStatus");

		if (workPositionId && attendanceInformationStatus && attendanceInformationStatus.ticketId) {
			let lsSSMTicketInfo = LightningUtil.getItemLocalStorage("SSMTicketInfo", "TICKET");

			gotoPage = "servicePage";
			
			if (lsSSMTicketInfo) {
				let SSMTicketInfo = {};

				try {
					SSMTicketInfo = JSON.parse(lsSSMTicketInfo);

				} catch (error) {
					
				}

				if (SSMTicketInfo && SSMTicketInfo.ticketId && SSMTicketInfo.ticketId === attendanceInformationStatus.ticketId) {
					serviceTicket = SSMTicketInfo;

					serviceTicket.customerName = attendanceInformationStatus.customerName;
					serviceTicket.customerAlias = attendanceInformationStatus.customerName;
					serviceTicket.customerDocument = attendanceInformationStatus.customerDocument;
					serviceTicket.customerCellPhone = attendanceInformationStatus.customerCellPhone;
					serviceTicket.segmentation = attendanceInformationStatus.segmentationId;
					serviceTicket.segmentationName = attendanceInformationStatus.segmentationName;
					serviceTicket.waitTime = attendanceInformationStatus.waitTime;
					serviceTicket.startTime = attendanceInformationStatus.startTime;
					serviceTicket.duration = attendanceInformationStatus.duration;
					serviceTicket.serviceName = attendanceInformationStatus.serviceName;
				}
			}

			if (Object.keys(serviceTicket).length === 0) {
				serviceTicket = {
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
			}
		}

		if (gotoPage === "homePage") {
			this.gotoHomePage(component);

		} else {
			this.gotoServicePage(component, serviceTicket);
		}
	},

	gotoHomePage : function(component) {
		LightningUtil.removeItemLocalStorage("SSMTicketInfo");
		
		component.set("v.serviceTicket", {});

		component.set("v.homePage", true);
		component.set("v.servicePage", false);
	},

	gotoServicePage : function(component, serviceTicket) {
		component.set("v.serviceTicket", serviceTicket);

		component.set("v.homePage", false);
		component.set("v.servicePage", true);
	},

	getErrorMessage: function(status) {
		/*
			When status message code less than or equal to 599 generic error messages are returned
			When status message code greater than 599 specific error messages are returned
		*/
		var errorMessage = "";

		switch (status) {
			case 1:
				errorMessage = $A.get("$Label.c.StoreServiceManagerRequiredParameterIsMissing");
				break;

			case 15:
				errorMessage = $A.get("$Label.c.StoreServiceManagerTicketCannotBeCalled");
				break;	

			case 52:
				errorMessage = $A.get("$Label.c.StoreServiceManagerUserNotRegistered");
				break;

			case 53:
				errorMessage = $A.get("$Label.c.StoreServiceManagerUserNotRelatedToStore");
				break;

			case 54:
				errorMessage = $A.get("$Label.c.StoreServiceManagerStoreWithoutSegmentation");
				break;

			case 98:
				errorMessage = $A.get("$Label.c.StoreServiceManagerUserDoesNotHaveRegistration");
				break;

			case 99:
				errorMessage = $A.get("$Label.c.StoreServiceManagerErrorProcessingRequest");
				break;

			case 400:
				errorMessage = $A.get("$Label.c.StoreServiceManagerGenericFail");
				break;

			case 401:
				errorMessage = $A.get("$Label.c.StoreServiceManagerUnauthorized");
				break;
	
			case 403:
				errorMessage = $A.get("$Label.c.StoreServiceManagerUnauthorized");
				break;

			case 404:
				// Attention to PointOfServiceTicketCallOut that when 404 occurs it is reset to 625
				errorMessage = $A.get("$Label.c.StoreServiceManagerGenericFail");
				break;

			case 500:
				errorMessage = $A.get("$Label.c.StoreServiceManagerComponentFail");
				break;

			case 504:
				errorMessage = $A.get("$Label.c.StoreServiceManagerComponentFail");
				break;

			case 600:
				errorMessage = $A.get("$Label.c.StoreServiceManagerConfigurationNotFound");
				break;
	
			case 601:
				errorMessage = $A.get("$Label.c.ErrorLoadingComponent");
				break;

			case 602:
				errorMessage = $A.get("$Label.c.ErrorLoadingComponent");
				break;
	
			case 603:
				errorMessage = $A.get("$Label.c.NeedLoginOAM");
				break;

			case 604:
				errorMessage = $A.get("$Label.c.StoreServiceManagerConfigurationNotFound");
				break;

			case 610:
				errorMessage = $A.get("$Label.c.StoreServiceManagerDoesntHaveLinkedStore");
				break;

			case 611:
				errorMessage = $A.get("$Label.c.StoreServiceManagerPositionListIsEmpty");
				break;

			case 612:
				errorMessage = $A.get("$Label.c.ErrorLoadingComponent");
				break;

			case 613:
				errorMessage = $A.get("$Label.c.StoreServiceManagerSelectAvailablePosition");
				break;

			case 621:
				errorMessage = $A.get("$Label.c.StoreServiceManagerPauseReasonsListEmpty");
				break;

			case 622:
				errorMessage = $A.get("$Label.c.ErrorLoadingComponent");
				break;

			case 623:
				errorMessage = $A.get("$Label.c.StoreServiceManagerSelectReasonBreak");
				break;

			case 624:
				errorMessage = $A.get("$Label.c.StoreServiceManagerNotPermissionSet");
				break;

			case 625:
				errorMessage = $A.get("$Label.c.StoreServiceManagerTicketsListIsEmpty");
				break;

			default:
				errorMessage = $A.get("$Label.c.StoreServiceManagerGenericErrorMessage");
		}

		return errorMessage;
	},

	showErrorMessage : function(component, errorMessage, forceClearErrorMessage) {
		let errorTryAgainDialog = false;

		if (!errorMessage) {
			errorMessage = "";

			if (!forceClearErrorMessage) {
				LightningUtil.removeItemLocalStorage("SSMErrorMessage");
			}

		} else {
			if (typeof errorMessage == "number") {		
				errorTryAgainDialog = (errorMessage === 99 || (errorMessage >= 500 && errorMessage <= 599));
				errorMessage = this.getErrorMessage(errorMessage);
			}
		}
		
		if (errorTryAgainDialog && errorMessage) {
			component.set("v.errorMessageTryAgainDialog", errorMessage);

		} else {
			component.set("v.errorMessage", errorMessage);
		}
	},

	beforeCallAction : function(component) {
		component.set("v.isLoading", true);

		this.showErrorMessage(component, "", true);
	},

	afterCallAction: function(component, errorMessage) {
		component.set("v.isLoading", false);

		this.showErrorMessage(component, errorMessage, false);
	},

	BroadcastNotificationHandler : function(component, event) {       
		if (event.getParam("type") == "StoreServiceManager") {
			event.stopPropagation();
			
			let jsonSSM = event.getParam("json");

			if  (jsonSSM.type == "showErrorMessage") {
				this.showErrorMessage(component, jsonSSM.errorMessage, false);

			} else if  (jsonSSM.type == "beforeCallAction") {
				this.beforeCallAction(component);

			} else if (jsonSSM.type == "afterCallAction") {
				this.afterCallAction(component, jsonSSM.errorMessage);

			} else if (jsonSSM.type == "backToHome") {
				this.gotoHomePage(component);

			} else if (jsonSSM.type == "attendance") {
				this.gotoServicePage(component, jsonSSM.serviceTicket);

			} else if (jsonSSM.type == "InService") {
				component.set("v.InService", jsonSSM.value);

			} else if (jsonSSM.type == "closeTryAgainDialog") {
				component.set("v.errorMessageTryAgainDialog", "");

			} else if (jsonSSM.type == "forceRestart") {
				LightningUtil.removeItemLocalStorage("SSMErrorMessage");
				
				component.set("v.errorMessageTryAgainDialog", "");
				component.set("v.forceRestart", true);

				component.set("v.homePage", false);
				component.set("v.servicePage", false);

				this.gotoHomePage(component);
			}
		}
	},

})
