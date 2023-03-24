({
    createCellList : function(component){ 
        component.set("v.isLoading", true);      
        let originCells = component.get("v.originCells");
        let destinyCells = component.get("v.destinyCells");
        let ltOrigin;
        let ltDestiny;

        try { 
            let ltOrigin; 
            if(originCells.length > 0){
                ltOrigin = originCells.map(item => {
                    let container = {};

                    container.value = item.value;
                    container.label = item.value;

                    return container;
                });
            }else{
                ltOrigin = [{"value" : $A.get("$Label.c.CellUnavailable"), "label" : $A.get("$Label.c.CellUnavailable")}];
            }
        
        
            ltDestiny = destinyCells.map(item => {
                let container = {};

                container.value = item.value;
                container.label = item.value+'['+item.id+']';

                return container;
            });
        

            component.set("v.ltOrigin", ltOrigin);
            component.set("v.ltDestiny", ltDestiny);
            component.set("v.origin", ltOrigin[0].value);

            if (ltDestiny.length == 1) {
                component.set("v.destiny", ltDestiny[0].value);
            }else if(ltDestiny.length == 0){
                this.showAlertMessage($A.get("$Label.c.CTIServiceIntegrationAlertNoCellReturnedFromGPS"));
            }

            component.set("v.isLoading", false);
        }catch(e){
            this.showAlertMessage($A.get("$Label.c.CTIServiceIntegrationAlertNoCellReturnedFromGPS"));
        }
    },

    getSelectedRow : function(list, selected){
        return list.filter(item => item.value == selected)[0];
    },

    PerformConsult : function(component, event) {
        if(this.validateFields(component)){ 
            let destinyRow = this.getSelectedRow(component.get("v.destinyCells"),component.get("v.destiny"));

            this.fireCTIEvent(component, 'CTIServiceIntegration_PerformConsult',destinyRow.id, null);
        }
    },

    FinalizeConsult : function(component, event) {
        this.fireCTIEvent(component, 'CTIServiceIntegration_FinalizeConsult', null, null);
    },
    
    ContinueService : function(component, event) {
        if(component.get('v.ConsultPerformed')){
            this.fireCTIEvent(component, 'CTIServiceIntegration_ContinueService',null, null);
        }else{
            this.showAlertMessage($A.get("$Label.c.CTIServiceIntegrationPerformConsultToContinue"));
        }
    },

    talkToTheCustomer : function(component, event) {
        this.fireCTIEvent(component, 'CTIServiceIntegration_TalkToTheCustomer',null, null);
    },

    validateFields : function(component) {
        let result = (component.get("v.origin") && component.get("v.destiny"));

        if (!result) {
            this.showAlertMessage($A.get("$Label.c.CTIServiceIntegrationErrorRequiredGroup"));
        }

        return result;
    },

    fireCTIEvent : function(component, type, json, sobject){

        var evt = component.getEvent("CTIServiceIntegration");;
        if(type != null && type != undefined){
            evt.setParam('type', type);
        }
        if(json != null && json != undefined){
            evt.setParam('json', json);
        }
        if(sobject != null && sobject != undefined){
            evt.setParam('sobject', sobject);
        }
        evt.fire();

    },

    showAlertMessage : function(alertMessage) {
        LightningUtil.fireNotification(
            'Atenção',
            alertMessage,
            'warning',
            5000
        );
    },

})