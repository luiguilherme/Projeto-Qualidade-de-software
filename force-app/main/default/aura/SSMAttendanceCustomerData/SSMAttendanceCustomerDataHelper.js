({
    doInit : function(component, event, helper) {
        let serviceTicket = component.get("v.serviceTicket");
    
        if (serviceTicket.mainDocumentType) {
            this.setDocumentNumberFormat(component, serviceTicket.mainDocumentType);
        }
    },

    onCustomerNameChange : function(component, event, helper) {
        let serviceTicket = component.get("v.serviceTicket");

        LightningUtil.setItemLocalStorage("SSMTicketInfo", JSON.stringify(serviceTicket), "TICKET");
    },

    onCellPhoneChange : function(component, event, helper) {
        let serviceTicket = component.get("v.serviceTicket");

        let cellPhone = (
            event.getParam("value")
                .replace(/\D+/g, '')
                .match(/(\d{0,2})(\d{0,5})(\d{0,4})/)
        );

        cellPhone = (
            ((!cellPhone[2])
                ? cellPhone[1] 
                : `${cellPhone[1]} ${cellPhone[2]}` + ((cellPhone[3]) ? `-${cellPhone[3]}` : ``)
            )
        );

        serviceTicket.customerCellPhone = cellPhone;

        component.set("v.serviceTicket", serviceTicket);

        LightningUtil.setItemLocalStorage("SSMTicketInfo", JSON.stringify(serviceTicket), "TICKET");
    },

    onCategoryChange : function(component, event, helper) {
        let serviceTicket = component.get("v.serviceTicket");
        let categoryValue = event.getParam("value");
        let ltCategories = component.get("v.ltCategories");
                
        let category = ltCategories.filter(function(checkItemCategory) {
            return checkItemCategory.value === categoryValue;
        });

        serviceTicket.categoryName = category[0].label;
        serviceTicket.activities = "";

        component.set("v.serviceTicket", serviceTicket);

        LightningUtil.setItemLocalStorage("SSMTicketInfo", JSON.stringify(serviceTicket), "TICKET");
    },

    onMainDocumentTypeChange : function(component, event, helper) {
        let serviceTicket = component.get("v.serviceTicket");

        this.setDocumentNumberFormat(component, serviceTicket.mainDocumentType);

        serviceTicket.documentNumber = "";
        
        component.set("v.serviceTicket", serviceTicket);

        LightningUtil.setItemLocalStorage("SSMTicketInfo", JSON.stringify(serviceTicket), "TICKET");

        component.find("txtDocumentNumber").focus();
    },

    onDocumentNumberChange : function(component, event, helper) {
        let serviceTicket = component.get("v.serviceTicket");
        let documentNumber = event.getParam("value");

        if (serviceTicket.mainDocumentType === "CPF") {
            documentNumber = (
                documentNumber
                    .replace(/\D+/g, '')
                    .match(/(\d{0,3})(\d{0,3})(\d{0,3})(\d{0,2})/)
            );

            documentNumber = (
                ((!documentNumber[2])
                    ? documentNumber[1] 
                    : `${documentNumber[1]}.${documentNumber[2]}` + 
                        ((documentNumber[3]) ? `.${documentNumber[3]}` : ``) +
                        ((documentNumber[4]) ? `-${documentNumber[4]}` : ``)
                )
            );

        } else if (serviceTicket.mainDocumentType === "CNPJ") {
            documentNumber = (
                documentNumber
                    .replace(/\D+/g, '')
                    .match(/(\d{0,2})(\d{0,3})(\d{0,3})(\d{0,4})(\d{0,2})/)
            );

            documentNumber = (
                ((!documentNumber[2])
                    ? documentNumber[1] 
                    : `${documentNumber[1]}.${documentNumber[2]}` + 
                        ((documentNumber[3]) ? `.${documentNumber[3]}` : ``) +
                        ((documentNumber[4]) ? `/${documentNumber[4]}` : ``) +
                        ((documentNumber[5]) ? `-${documentNumber[5]}` : ``)
                )
            );

        } else {
            documentNumber = (
                documentNumber
                    .replace(/\D+/g, '')
                    .match(/(\d{0,20})/)
            );

            documentNumber = documentNumber[1];
        }

        serviceTicket.documentNumber = documentNumber;

        component.set("v.serviceTicket", serviceTicket);

        LightningUtil.setItemLocalStorage("SSMTicketInfo", JSON.stringify(serviceTicket), "TICKET");
    },

    setDocumentNumberFormat : function(component, documentType) {
        if (documentType === "CPF") {
            component.set("v.placeholderDocumentNumber", "000.000.000-00")

        } else if (documentType === "CNPJ") {
            component.set("v.placeholderDocumentNumber", "00.000.000/0000-00")

        } else {
            component.set("v.placeholderDocumentNumber", "00000000000000000000")
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
