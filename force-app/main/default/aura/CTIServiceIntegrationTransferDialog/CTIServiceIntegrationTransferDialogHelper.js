({
    createCellList : function(component){ 
        component.set("v.isLoading", true);      
        let originCells = component.get("v.originCells");
        let destinyCells = component.get("v.destinyCells");
        
        try {
            let ltOrigin; 
            if(originCells.length > 0){
                ltOrigin = originCells.map(item => {
                    let container = {};

                    container.value = item.nomeCelula;
                    container.label = item.nomeCelula;

                    return container;
                });
            }else{
                ltOrigin = [{"value" : $A.get("$Label.c.CellUnavailable"), "label" : $A.get("$Label.c.CellUnavailable")}];
            }


            let ltDestiny = destinyCells.map(item => {
                let container = {};

                container.value = item.nomeCelula;
                container.label = item.nomeCelula+'('+item.idCelulaGenesys+')';

                return container;
            });

            component.set("v.ltOrigin", ltOrigin);
            component.set("v.ltDestiny", ltDestiny);
            component.set("v.origin", ltOrigin[0].value);

            if (ltDestiny.length == 1) {
                component.set("v.destiny", ltDestiny[0].value);
                this.updateButtons(component, ltDestiny[0].value);
            }
            component.set("v.isLoading", false);
        } catch (e) {
            this.showAlertMessage($A.get("$Label.c.CTIServiceIntegrationAlertNoCellReturnedFromGPS"));
        }
    },

    onDestinyChange : function(component, event) {
        let destinySelected = event.getParam("value");

        this.updateButtons(component, destinySelected);
    },

    getSelectedRow : function(list, selected){
        return list.filter(item => item.nomeCelula == selected)[0];
    },

    updateButtons : function(component, destinySelected)  {
        let ltDestiny = component.get("v.destinyCells");
        let selected = this.getSelectedRow(ltDestiny, destinySelected);

        component.set("v.directTransfer", !selected.transferenciaDireta);
        component.set("v.assistedTransfer", !selected.transferenciaComEspera);
    },

    directTransfer : function(component, event) {
        if (this.validateFields(component)) {
            let destinyId = component.get("v.destiny");

            let originCell = component.get("v.origin");
            let destinyCell = this.getSelectedRow(component.get("v.destinyCells"),destinyId);

            let ctiEvent = component.getEvent("CTIServiceIntegration");

            ctiEvent.setParam('type', 'CTIServiceIntegration_DirectTransfer');
            ctiEvent.setParam('sobject',{
                    "originCell": originCell,
                    "destinyCell": destinyCell.nomeCelula+'('+destinyCell.idCelulaGenesys+')',
                    "destinyId" : destinyCell.idCelulaGenesys,
                    "note": component.get("v.note")
                });
    
            ctiEvent.fire();
        }
    },

    assistedTransfer : function(component, event) {
        if (this.validateFields(component)) {
            let destinyId = component.get("v.destiny");
            
            let originCell = component.get("v.origin");
            let destinyCell = this.getSelectedRow(component.get("v.destinyCells"),destinyId);

            let ctiEvent = component.getEvent("CTIServiceIntegration");

            ctiEvent.setParam('type', 'CTIServiceIntegration_AssistedTransfer');
            ctiEvent.setParam('sobject',{
                "originCell": originCell,
                "destinyCell": destinyCell.nomeCelula+'('+destinyCell.idCelulaGenesys+')',
                "destinyId" : destinyCell.idCelulaGenesys,
                "note": component.get("v.note")
                });
    
            ctiEvent.fire();

        } else {
            if (this.validateFields(component)) {
                component.set("v.inAssistedTransfer", true);
            }
        }
    },

    assistedTransferConfirm : function(component, event) {
        component.set("v.inAssistedTransfer", false);
        component.set('v.backToTransfer', false);

        let ctiEvent = component.getEvent("CTIServiceIntegration");

        ctiEvent.setParam('type', 'CTIServiceIntegration_FinishAssistedTransfer');

        ctiEvent.fire();
    },

    talkToTheCustomer : function(component, event) {
        let backToTransfer = component.get('v.backToTransfer');
        component.set('v.backToTransfer', !backToTransfer);

        let ctiEvent = component.getEvent("CTIServiceIntegration");

        ctiEvent.setParam('type', 'CTIServiceIntegration_TalkToTheCustomer');

        ctiEvent.fire();
    },

    cancelTransfer: function(component, event) {
        component.set("v.inAssistedTransfer", false);
        component.set('v.backToTransfer', false);

        let ctiEvent = component.getEvent("CTIServiceIntegration");

        ctiEvent.setParam('type', 'CTIServiceIntegration_CancelAssistedTransfer');

        ctiEvent.fire();
    },

    validateFields : function(component) {
        let result = (component.get("v.origin") && component.get("v.destiny"));

        if (!result) {
            this.showErrorMessage($A.get("$Label.c.CTIServiceIntegrationErrorRequiredGroup"));
        }

        return result;
    },

    showAlertMessage : function(alertMessage) {
        LightningUtil.fireNotification(
            'Atenção',
            alertMessage,
            'warning',
            5000
        );
    },

    showErrorMessage : function(errorMessage) {
        LightningUtil.fireNotification(
            'Atenção',
            errorMessage,
            'warning',
            5000
        );
    },

})