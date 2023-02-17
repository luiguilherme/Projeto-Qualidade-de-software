({
	doInit: function(component) {
		this.beforeCallAction(component);

		LightningUtil.callApex(
			component,
			"hasPermissionSetToAccess",
			{},
			(returnValue) => {
				var errorMessage = "";

				if (returnValue) {
					this.loadStoreServiceManager(component);

				} else {
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
				var errorMessage = "";

				if (returnValue["attendant"]) {
					let attendant = returnValue["attendant"];
                    let ltWorkPosition = returnValue["workPositionsList"];
					let partnerCommunityLicense = returnValue["partnerCommunityLicense"];
					let params = returnValue["params"];
					
					component.set("v.attendant", attendant);
                    component.set("v.ltWorkPosition", ltWorkPosition);
					component.set("v.partnerCommunityLicense", partnerCommunityLicense);
					component.set("v.params", params);

					component.set("v.workPositionId", "");

					// Component auto-recovery after browser updates
					let lsSSMAttendantInfo = LightningUtil.getItemLocalStorage("SSMAttendantInfo", "ATTENDANT");

					if (lsSSMAttendantInfo) {
						let SSMAttendantInfo;

						try {
							SSMAttendantInfo = JSON.parse(lsSSMAttendantInfo);

						} catch (error) {

						}

						/* 
							Removed. Strategy for not performing self-recovery when duplicating tabs or, in the Communities 
							environment, when opening the tab for Account positioning. It works for sessionStorage, but it 
							doesn't work for localStorage.

							(window.name && SSMAttendantInfo.windowName === window.name) && 
						*/

						if (SSMAttendantInfo && 
							(SSMAttendantInfo.attendantId === attendant.Login__c) && 
							(SSMAttendantInfo.storeId === attendant.StoreCode__c) && 
							SSMAttendantInfo.workPositionId && 
							(SSMAttendantInfo.date && SSMAttendantInfo.date === (new Date().toLocaleDateString()))
						) {
							component.set("v.workPositionId", SSMAttendantInfo.workPositionId);

						} else {
							LightningUtil.removeItemLocalStorage("SSMTicketInfo;SSMPauseInfo;SSMAttendantInfo");
						}
					}

					this.gotoPageOnInit(component);

				} else {
					errorMessage = returnValue["error"];
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

	gotoPageOnInit : function(component) {
		let gotoPage = "homePage";
		let SSMTicketInfo = {};
		let lsSSMTicketInfo = LightningUtil.getItemLocalStorage("SSMTicketInfo", "TICKET");
		
		if (lsSSMTicketInfo) {
			try {
				SSMTicketInfo = JSON.parse(lsSSMTicketInfo);

			} catch (error) {
				
			}

			if (SSMTicketInfo) {
				gotoPage = "servicePage";
			}
		}

		if (gotoPage === "homePage") {
			this.gotoHomePage(component);

		} else {
			this.gotoServicePage(component, SSMTicketInfo);
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

	showErrorMessage : function(component, errorMessage) {
		if (typeof errorMessage == "number") {
			errorMessage = this.getErrorMessage(errorMessage);
		}
		
		component.set("v.errorMessage", errorMessage);
	},

	beforeCallAction : function(component) {
		component.set("v.isLoading", true);

		this.showErrorMessage(component, "");
	},

	afterCallAction: function(component, errorMessage) {
		component.set("v.isLoading", false);

		this.showErrorMessage(component, errorMessage);
	},

	BroadcastNotificationHandler : function(component, event) {       
		if (event.getParam("type") == "StoreServiceManager") {
			event.stopPropagation();
			
			let jsonSSM = event.getParam("json");

			if  (jsonSSM.type == "showErrorMessage") {
				this.showErrorMessage(component, jsonSSM.errorMessage);

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
			}
		}
	},

})
