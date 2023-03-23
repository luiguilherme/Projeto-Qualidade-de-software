({
    createList : function(component, event, helper) {
        let transferCase = component.get("v.transferCase");

        if(!transferCase) return;

        component.set('v.columns', [
            {label: $A.get("$Label.c.OriginService"), fieldName: 'originService', type: 'text'},
            {label: $A.get("$Label.c.TransferTo"), fieldName: 'transferTo', type: 'text'},
            {label: $A.get("$Label.c.Note"), fieldName: 'note', type: 'text', wrapText: true },
            {label: $A.get("$Label.c.hour"), fieldName: 'hour', type: 'date', typeAttributes: {  
                                                                                        day: 'numeric',  
                                                                                        month: 'numeric',  
                                                                                        year: 'numeric',  
                                                                                        hour: '2-digit',  
                                                                                        minute: '2-digit',  
                                                                                        second: '2-digit',  
                                                                                        hour12: false}}
        ]);

        

        let data = [
            {
                originService : transferCase.OriginCell__c,
                transferTo : transferCase.DestinyCell__c,
                note : transferCase.TransferObservation__c,
                hour :transferCase.LastModifiedDate
            }
        ]
        
        component.set('v.data', data);
        component.set('v.isLoading', false);
    },

    btnExitClick : function(component, event, helper) {
        let ctiEvent = component.getEvent("CTIServiceIntegration");

        ctiEvent.setParam('type', 'CTIServiceIntegration_CloseSummary');

        ctiEvent.fire()
    },
})