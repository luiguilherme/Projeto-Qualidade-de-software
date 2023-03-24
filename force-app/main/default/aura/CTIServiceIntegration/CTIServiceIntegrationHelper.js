({
    getParamsVisualforcePage: function(component, helper) {
        let accountId = component.get('v.recordId');
        var eventId = Date.now();
    
        var callback = $A.getCallback(function(event) {
            if (event.data.service == 'WDE_InitialResponse') {
                // Set attributes with data sended in the message event
                component.set('v.vfHost', event.data.vfHost);
                component.set('v.caseId', event.data.caseId);

                // Validates if caseId is returned from Visualforce Page
                if (event.data.caseId && !component.get('v.caseRecord')) helper.validadeCase(component);

            }

            if(event.data.CustomerInteractionId__c && accountId == event.data.CustomerInteractionId__c){

                let eventType = event.data.service;

                if(eventType == 'WDE_RemoveListener'&& ((event.data.time && event.data.time != eventId) || !event.data.time)){
                    // Removes eventListener for prevent multiples listiners on current page
                    window.removeEventListener('message', callback);
                    return;
                } else if (eventType == 'WDE_DirectTransfer' || 
                           eventType == 'WDE_FinishAssistedTransfer' || 
                           eventType == 'WDE_NewService') {
                    event.stopPropagation();

                    if (event.data.wdeResponse) window.removeEventListener('message', callback);
                    helper.handleVisualforceEvent(component, event.data, eventType);

                } else if (eventType == 'WDE_AssistedTransfer' || 
                           eventType == 'WDE_CancelAssistedTransfer' || 
                           eventType == 'WDE_PerformConsult' || 
                           eventType == 'WDE_FinalizeConsult' ||
                           eventType == 'WDE_TalkToTheCustomer') {
                    event.stopPropagation();

                    helper.handleVisualforceEvent(component, event.data, eventType);

                } else if (eventType == 'WDE_CloseSummary') {
                    event.stopPropagation();

                    if (!event.data.wdeResponse){
                        helper.showAlertMessage($A.get("$Label.c.CTIServiceIntegrationGuideUserGoToHistContactTab"));
                        component.set('v.isModalOpenTransferSummary', false);
                    } else {
                        helper.showAlertMessage($A.get("$Label.c.CTIServiceIntegrationAlertTransferNotComplete"));
                    }

                } else if (eventType == 'WDE_CallDropped') {
                    event.stopPropagation();

                    if (event.data.wdeResponse) {
                        helper.showAlertMessage($A.get("$Label.c.CTIServiceIntegrationCallStillActive"));
                    } else {
                        let toHome;

                        if(event.data.updateWdeCase){
                            window.removeEventListener('message', callback);
                            helper.showSuccessMessage('Caso de Ligação Caiu registrado com sucesso!');
                            toHome = true;
                        }else{
                            helper.showAlertMessage('Erro ao registrar o atendimento, favor informar à gestão.');
                        }

                        if(!event.data.markDone){
                            helper.showAlertMessage('Não foi possível encerrar a chamada, favor encerrar manualmente.');
                        }else{
                            toHome = true;
                        }

                        if(toHome){
                            helper.navigationToHome(component);
                        }
                    }
                } else if (eventType == 'WDE_IsCallActive') {
                    event.stopPropagation();
                    component.set('v.isCallActive', event.data.wdeResponse);
                    
                    let evt = $A.get('e.c:BroadcastNotification');
                    evt.setParam('type', 'CTIServiceIntegration_IsCallActive');
                    evt.setParam('json', component.get('v.recordId'));
                    evt.setParam('sobject', event.data.wdeResponse);
                    evt.fire();
                }
                // Tratar response do isCallActive e mandar pro Service Container
            }
        });
        this.onRemoveEventListener(component,eventId);
        window.addEventListener('message', callback); 
    },

    handleVisualforceEvent: function(component, data, eventType) {
        let parsedData = JSON.parse(JSON.stringify(data));

        if(!parsedData.wdeResponse && eventType != 'WDE_NewService'){
            this.showErrorMessage('Ocorreu um problema na comunicação com o WDE, tente novamente.');
        }else if(!parsedData.wdeResponse && eventType == 'WDE_NewService'){
            this.showAlertMessage('Chamada ainda ativa, finalizar chamada manualmente!');
        }else if(parsedData.wdeResponse){
            if(eventType === 'WDE_DirectTransfer'){
                this.showSuccessMessage('Transferência Direta Realizada!');
                this.navigationToHome(component);
            } else if(eventType === 'WDE_FinishAssistedTransfer'){
                this.showSuccessMessage('Transferência Assistida Concluída!');
                this.navigationToHome(component);
            }else if(eventType === 'WDE_TransferToSurveyVoice'){
                this.showSuccessMessage('Transferência para Pesquisa Concluída!');
                this.navigationToHome(component);
            }else if(eventType === 'WDE_NewService'){
                this.navigationToHome(component);
            }
        }

        if(!parsedData.updateWdeCase){
            this.showErrorMessage('Ocorreu um problema atualizar os dados do Caso, tente novamente.');
        } else if(parsedData.updateWdeCase){
            if(eventType === 'WDE_PerformConsult' || 
               eventType === 'WDE_TalkToTheCustomer' || 
               eventType === 'WDE_FinalizeConsult' ||
               eventType === 'WDE_AssistedTransfer' ||
               eventType === 'WDE_CancelAssistedTransfer'){

                // Dispatch event to set case status on ServiceContainer component
                let evt = $A.get('e.c:BroadcastNotification');
                evt.setParam('type', 'CTIServiceIntegration_UpdateCaseStatus');
                evt.setParam('json', parsedData.AccountId__c);
                evt.setParam('sobject', parsedData);
                evt.fire(); 
            }
        }
    },

    onRemoveEventListener: function(component,eventId){
        let responseRemoveListener = {
            service: "WDE_RemoveListener",
            accountId: component.get('v.recordId'),
            time: eventId
        };

        window.postMessage(responseRemoveListener,window.location.origin);
        return;
    },

    validadeCase: function(component) {
        let recordLoader = component.find('recordLoader');

        if (recordLoader) recordLoader.reloadRecord();
    },

    setParamsVisualforcePage: function(component, message) {    
        let vfOrigin =  component.get('v.vfHost');
        let vfWindow = component.find('vfFrame').getElement().contentWindow;

        message.accountId = component.get('v.recordId');

        vfWindow.postMessage(message, vfOrigin);
    },

    directTransfer: function(component, payload) {
        if (!(component.get('v.isCallActive'))) {
            this.showAlertMessage($A.get("$Label.c.SalesforceNotExecutedByWDE"));
        } else {
            // Dispatch event to CTI VFPAGE to direct transfer the call
            let params = {
                service: 'CTIServiceIntegration_DirectTransfer',
                payload : payload
            };
            this.setParamsVisualforcePage(component, params);
        }
    },

    assistedTransfer: function(component, payload) {
        if (!(component.get('v.isCallActive'))) {
            this.showAlertMessage($A.get("$Label.c.SalesforceNotExecutedByWDE"));
        } else {
            let params = {
                service: 'CTIServiceIntegration_AssistedTransfer',
                payload : payload
            };
            this.setParamsVisualforcePage(component, params);
        }
    },

    talkToTheCustomer: function(component, payload) {
        let params = {
            service: 'CTIServiceIntegration_TalkToTheCustomer',
            payload: payload
        };
        this.setParamsVisualforcePage(component, params);
    },

    finishTransfer: function(component, payload) {
        let params = {
            service: 'CTIServiceIntegration_FinishAssistedTransfer',
            payload: payload
        };
        this.setParamsVisualforcePage(component, params);
    },
    
    newService: function(component, payload) {
        let params = {
            service: 'CTIServiceIntegration_NewService',
            payload: payload
        };
        this.setParamsVisualforcePage(component, params);
    },

    cancelTransfer: function(component, payload) {
        let params = {
            service: 'CTIServiceIntegration_CancelAssistedTransfer',
            payload: payload
        };
        this.setParamsVisualforcePage(component, params);
    },

    navigationToHome: function(component) {
        let navigationItemAPI = component.find("navigationItem");

        if (navigationItemAPI != null) {
            navigationItemAPI.setSelectedNavigationItem({
                "developerName": "standard-home"
            })
            .then(function(response) {
                let workspaceAPI = component.find("workspace");
                workspaceAPI.getFocusedTabInfo()
                    .then(function(response) {
                        let focusedTabId = response.tabId;
                        workspaceAPI.closeTab({tabId: focusedTabId});
                    })
                    .catch(function(error) {
                        this.showErrorMessage($A.get("$Label.c.GenericErrorMessage"));
                    });
                
            })
            .catch(function(error) {
                this.showErrorMessage($A.get("$Label.c.GenericErrorMessage"));
            });
        }
    },

    closeSummary: function(component) {
        let params = {
            service: 'CTIServiceIntegration_CloseSummary',
        };
        this.setParamsVisualforcePage(component, params);
    },

    isCallActive: function(component) {
        let params = {
            service: 'CTIServiceIntegration_isCallActive'
        };
        this.setParamsVisualforcePage(component, params);
    },

    //======================== Funções do ConsultCell =============================================
    performConsult: function(component, payload){

        let params = {
            service: 'CTIServiceIntegration_PerformConsult',
            payload : payload
        };

        this.setParamsVisualforcePage(component, params);
    },


    finalizeConsult: function(component, payload){
        let params = {
            service: 'CTIServiceIntegration_FinalizeConsult',
            payload: payload
        };
        this.setParamsVisualforcePage(component, params);
        
    },
    
    callDropped: function(component, payload) {
        let params = {
            service: 'CTIServiceIntegration_CallDropped',
            payload: payload
        };
        this.setParamsVisualforcePage(component, params);
        
    },

//======================== Funções de Notificação=====================================
    showSuccessMessage : function(successMessage) {
        LightningUtil.fireNotification(
            'Sucesso',
            successMessage,
            'success',
            7000
        );
    },

    showAlertMessage : function(alertMessage) {
        LightningUtil.fireNotification(
            'Atenção',
            alertMessage,
            'warning',
            7000
        );
    },

    showErrorMessage : function(errorMessage) {
        LightningUtil.fireNotification(
            'Erro',
            errorMessage,
            'error',
            7000
        );
    },
})