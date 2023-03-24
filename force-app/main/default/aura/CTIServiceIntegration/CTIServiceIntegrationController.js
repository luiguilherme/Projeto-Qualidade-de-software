({
    doInit: function(component, event, helper) {
        helper.getParamsVisualforcePage(component, helper);
    },

    onTabClosed: function(component, event, helper) {
        helper.onRemoveEventListener(component);
    },

    handleAplicationEvent: function(component, event, helper){
        var typeEvent = event.getParam('type');
        var accId = event.getParam('json');
        var eventPayload;
        if(event.getParam('sobject')){
            eventPayload = JSON.parse(JSON.stringify(event.getParam('sobject')));
        }

        console.log('RecordId: ' + component.get('v.recordId'));

        if (accId == component.get('v.recordId')) {
            if(typeEvent == 'GPSCanvasIntegration_GetCaseWDE'){

                event.stopPropagation();

                let evt = $A.get('e.c:BroadcastNotification');
                evt.setParam('type', 'GPSCanvasIntegration_SetCaseWDE');
                evt.setParam('json', component.get('v.recordId'));
                evt.setParam('sobject', component.get('v.caseRecord'));
                evt.fire();

            } else if(typeEvent == 'DirectTransfer'){

                event.stopPropagation();
                helper.directTransfer(component, eventPayload);

            } else if(typeEvent == 'PerformConsult'){

                event.stopPropagation();
                helper.performConsult(component, eventPayload);

            } else if(typeEvent == 'TalkToTheCustomer'){

                event.stopPropagation();
                helper.talkToTheCustomer(component, eventPayload);

            } else if(typeEvent == 'FinalizeConsult'){

                event.stopPropagation();
                helper.finalizeConsult(component, eventPayload);

            }else if(typeEvent == 'AssistedTransfer'){

                event.stopPropagation();
                helper.assistedTransfer(component, eventPayload);

            }else if(typeEvent == 'FinishAssistedTransfer'){

                event.stopPropagation();
                helper.finishTransfer(component, eventPayload);

            }else if(typeEvent == 'CancelAssistedTransfer'){

                event.stopPropagation();
                helper.cancelTransfer(component, eventPayload);
                
            }else if(typeEvent == 'NewService'){

                event.stopPropagation();
                helper.newService(component, eventPayload);
                
            }else if (typeEvent == 'GPSCanvasIntegration_CallDropped') {
                
                event.stopPropagation();
                console.log(JSON.stringify(eventPayload));
                helper.callDropped(component, eventPayload);
                
            }else if (typeEvent == 'GPSCanvasIntegration_IsCallActive') {
                
                event.stopPropagation();
                if(component.get('v.vfHost') != ''){
                    helper.isCallActive(component, eventPayload);
                }else{
                    let evt = $A.get('e.c:BroadcastNotification');
                    evt.setParam('type', 'CTIServiceIntegration_IsCallActive');
                    evt.setParam('json', component.get('v.recordId'));
                    evt.setParam('sobject', false);
                    evt.fire();
                }
                
            }
            // Receber evento para testar if isCallActive
        }
    },

    handleComponentEvent: function(component, event, helper) {
        var typeEvent = event.getParam('type');

        if (typeEvent == 'CTIServiceIntegration_CloseSummary') {
            event.stopPropagation();

            helper.closeSummary(component);

        } 
    },

    handleRecordUpdated: function(component, event, helper) {
        var eventParams = event.getParams();
        if(eventParams.changeType === "LOADED") {
            var caseRecord = component.get("v.caseRecord");

            if (caseRecord && 
                caseRecord.Origin == 'GPS' && 
                (caseRecord.Status == 'Em Atendimento' || caseRecord.Status == 'Consulting') && 
                !component.get('v.summaryOpened')) {

                component.set('v.isModalOpenTransferSummary', true);
                component.set('v.summaryOpened', true);
            }
        }
    }
})