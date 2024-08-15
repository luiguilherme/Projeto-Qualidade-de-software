import { LightningElement, api, wire } from 'lwc';
import { registerListener, fireEvent } from 'c/pubsub';
import {CurrentPageReference} from 'lightning/navigation';
import { OmniscriptBaseMixin } from 'vlocity_cmt/omniscriptBaseMixin';
import { getNamespaceDotNotation } from "vlocity_cmt/omniscriptInternalUtils";
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { EnclosingTabId, getTabInfo, IsConsoleNavigation, getFocusedTabInfo, closeTab } from 'lightning/platformWorkspaceApi';
import { NavigationMixin } from "lightning/navigation";


export default class DisputeCalloutHandler extends OmniscriptBaseMixin(NavigationMixin(LightningElement)) {

    _ns = getNamespaceDotNotation();
    @wire(CurrentPageReference) pageRef;
    @api recordId;
    @wire(EnclosingTabId) tabId;
    @wire(IsConsoleNavigation) isConsoleNavigation;



    connectedCallback() {
        console.log("DisputeCalloutHandler connectedCallback", this.recordId);
        window.addEventListener('createdmobilenextdisputecaseonwde', this.handleApexResponse);
        window.addEventListener('updateddmobilenextdisputecaseonwde', this.updatedMobileNextCase);
    }

    getVivoNetProtocol(payload) {

        console.log("getVivoNetProtocol");
        const params = {
            input: JSON.stringify({"ServiceIdentifier": payload.ServiceIdentifier, "AssetId": payload.Line}),
            sClassName: `${this._ns}IntegrationProcedureService`,
            sMethodName: 'Dispute_CallDroppedCalloutPerformIntegration',
            options: {},
        };

        this.omniRemoteCall(params, true).then(response => {
            console.log("res", JSON.stringify(response));
            console.log("payloadresponse", JSON.stringify(response.result.IPResult));
            let incrementedPayload = payload;
            incrementedPayload.protocolNumber = response.result.IPResult.protocolNumber;
            console.log("incrementedPayload", incrementedPayload);
            fireEvent(this.pageRef, 'fireeventtocalldroppednotification', incrementedPayload);
        }).catch(error => {
            console.log("error", JSON.stringify(error));
        })
    }

    //no leaky listeners
    //https://github.com/salesforce/eslint-plugin-lwc/blob/master/docs/rules/no-leaky-event-listeners.md
    handleApexResponse = (event) => {
        console.log("handleApexResponse > ESCUTADOR NÃO FILTRADO");
        if (this.isConsoleNavigation) {
            getTabInfo(this.tabId).then((tabInfo) => {
                console.log('tabInfo.focused', tabInfo.focused);
                console.log('tabInfo.tabId', tabInfo.tabId);
                console.log('event.detail.focusedTabInfo.tabId', event.detail.focusedTabInfo.tabId);
                if(tabInfo.focused && (tabInfo.tabId == event.detail.focusedTabInfo.tabId)){
                    console.log("handleApexResponse > ESCUTADOR FILTRADO");
                    console.log(JSON.stringify(event));
                    console.log("on handleApexResponse");
                    console.log(JSON.stringify(event.detail));
                    let userFeedback;
            
                    if(!event.detail.createMobileNextDisputeCase.error){
                        this.updateCaseUsingProtocols(event.detail)
                        userFeedback = this.handleApexResponseFeedback(event.detail.createMobileNextDisputeCase.createdCase);
                    } else {
                        userFeedback = {            
                            title: "Erro!",
                            msg: "Erro inesperado ocorreu.",
                            variant: "error"
                        }
                    }
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: userFeedback.title,
                            message: userFeedback.msg,
                            variant: userFeedback.variant
                        })
                    );
                } else {
                    console.log("evento ignorado");
                }
            });
        } else { //experiences enviroment event filter
                if(this.recordId == event.detail.CustomerInteractionId__c) {
                    let userFeedback;
                
                    if(!event.detail.createMobileNextDisputeCase.error){
                        this.updateCaseUsingProtocols(event.detail)
                        userFeedback = this.handleApexResponseFeedback(event.detail.createMobileNextDisputeCase.createdCase);
                    } else {
                        userFeedback = {            
                            title: "Erro!",
                            msg: "Erro inesperado ocorreu.",
                            variant: "error"
                        }
                    }
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: userFeedback.title,
                            message: userFeedback.msg,
                            variant: userFeedback.variant
                        })
                    );
                } else {
                    console.log("evento ignorado");
            }
        }
    }

    updatedMobileNextCase = (event) => {
        if (this.isConsoleNavigation) {
            getTabInfo(this.tabId).then((tabInfo) => {
                if(tabInfo.focused && (tabInfo.tabId == event.detail.focusedTabInfo.tabId)){
                    let payload = event.detail;
                    this.createAmdocsInteraction(payload);
                    console.log("updatedMobileNextCase");
                } else {
                    console.log("evento ignorado");
                }
            })
        } else {
            if(this.recordId == event.detail.CustomerInteractionId__c) {
                let payload = event.detail;
                this.createAmdocsInteraction(payload);
                console.log("updatedMobileNextCase");
            } else {
                console.log("evento ignorado");
            }
        }
    }

    handleApexResponseFeedback(isCallDroppedCaseCreated) {
        console.log("handleApexResponseFeedback");
        if(isCallDroppedCaseCreated) {
            return {            
                title: "Sucesso!",
                msg: "Caso de Ligação Caiu registrado com sucesso!",
                variant: "success"
            }

        } else {
            return {
                title: "Aviso!",
                msg: "Caso de Ligação Caiu não foi registrado. Informar à gestão.",
                variant: "warning"
            }
        }
    }
    //**********
    handleIntegrationsFeedback(IntegrationProcedureResponse) {
        console.log("handleIntegrationsFeedback");
        if(IntegrationProcedureResponse.error) {
            return {
                error: true,
                errorFeedback : {
                    title: "Erro!",
                    msg: "Erro inesperado ocorreu.",
                    variant: "error"
                }
            }
        }

        let vivonetProtocolFeedback;
        if(IntegrationProcedureResponse.result?.IPResult?.FeedbackVivoNetProtocol?.Success){
            vivonetProtocolFeedback = {            
                title: "Sucesso!",
                msg: "Caso de Ligação Caiu registrado com sucesso!",
                variant: "success"
            }
        } else {
            vivonetProtocolFeedback = {            
                title: "Aviso!",
                msg: "Erro na API Dispute_PrepareVivoNetProtocol! Falha ao criar o Protocolo VivoNet, Interação Next não foi criado e Caso Salesforce finalizado como Ligação Caiu.",
                variant: "warning"
            }
        }
        
        let amdocsProtocolFeedback;
        if(IntegrationProcedureResponse.result?.IPResult?.FeedbackVivoNetProtocol?.Success){
            amdocsProtocolFeedback = {            
                title: "Sucesso!",
                msg: "Caso de Ligação Caiu registrado com sucesso!",
                variant: "success"
            }
        } else {
            amdocsProtocolFeedback = {            
                title: "Aviso!",
                msg: "Erro na API CreateCustomerInteraction! Falha ao criar a Interação Next de Ligação Caiu. Caso Salesforce finalizado como Ligação Caiu.",
                variant: "warning"
            }
        }

        return {"error": false,"vivonetProtocolFeedback": vivonetProtocolFeedback, "amdocsProtocolFeedback": amdocsProtocolFeedback}
    }
    updateCaseUsingProtocols(payload) {
        // console.log("updateCaseUsingProtocols");
        // console.log(JSON.stringify(payload));
        const params = {
            input: JSON.stringify(
                {
                    "CaseId__c": payload.createMobileNextDisputeCase.caseId,
                    "AssetId": payload.Line,
                    "ServiceIdentifier": payload.ServiceIdentifier,
                    "CustomerInteractionId__c": payload.CustomerInteractionId__c,
                    "CustomerInteractionTopicId__c": payload.createMobileNextDisputeCase.customerInteractionTopicId,
                }
                ),
            sClassName: `${this._ns}IntegrationProcedureService`,
            sMethodName: 'Dispute_CallDroppedPerformVivoNetAndInteractionIntegrations',
            options: {},
        };
            console.log("params", JSON.stringify(params));
            this.omniRemoteCall(params, true).then(response => {
                
                let cEvent1;
                if(response.result?.IPResult?.FeedbackVivoNetProtocol?.Success){
                    cEvent1 = new ShowToastEvent({
                        title: "Sucesso!",
                        message: response.result.IPResult.FeedbackVivoNetProtocol.Message,
                        variant: "success"
                    })
                } else {
                    cEvent1 = new ShowToastEvent({
                        title: "Atenção!",
                        message: "Erro na API Dispute_PrepareVivoNetProtocol! Falha ao criar o Protocolo VivoNet, Interação Next não foi criado e Caso Salesforce finalizado como Ligação Caiu.",
                        variant: "warning"
                    })
                }
                this.dispatchEvent(cEvent1);
                
                let cEvent2;
                if(response.result?.IPResult?.FeedbackAmdocsInteraction?.Success){
                    cEvent2 = new ShowToastEvent({
                        title: "Sucesso!",
                        message: response.result.IPResult.FeedbackAmdocsInteraction.Message,
                        variant: "success"
                    })
                } else {
                    cEvent2 = new ShowToastEvent({
                        title: "Atenção!",
                        message: "Erro na API CreateCustomerInteraction! Falha ao criar a Interação Next de Ligação Caiu. Caso Salesforce finalizado como Ligação Caiu.",
                        variant: "warning"
                    })
                }
                this.dispatchEvent(cEvent2);
                this.navigateToHomePage();
            })
    }

    updateCaseAmdocsInteraction(payload) {
        let modifiedPayload = payload;
        modifiedPayload.CaseId__c = payload.createMobileNextDisputeCase.caseId;
        modifiedPayload.CustomerInteractionTopicId__c = payload.createMobileNextDisputeCase.customerInteractionTopicId;
        this.createAmdocsInteraction(modifiedPayload)
    }

    createAmdocsInteraction(payload) {
        const params = {
            input: JSON.stringify(
                {
                    "CaseId__c": payload.CaseId__c,
                    "ServiceIdentifier": payload.ServiceIdentifier,
                    "CustomerInteractionId__c": payload.CustomerInteractionId__c,
                    "CustomerInteractionTopicId__c": payload.CustomerInteractionTopicId__c,
                }
                ),
            sClassName: `${this._ns}IntegrationProcedureService`,
            sMethodName: 'Dispute_CallDroppedHandleCaseAfterRegister',
            options: {},
        };
            this.omniRemoteCall(params, true).then(response => {
                console.log("Dispute_CallDroppedHandleCaseAfterRegister");
                console.log("res", JSON.stringify(response));
                
                if(response.result?.IPResult?.Success) {
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: "Sucesso!",
                            message: "Interação AMDOCS atrelada ao caso com sucesso! Itens contestados atualizados para Improcedente (se houverem).",
                            variant: "success"
                        })
                    );
                } else {
                    let userFeedbackMsg = response.result?.IPResult?.Message?.includes("SearchCustomerKeys") ? response.result?.IPResult?.Message : "Erro na API CreateCustomerInteraction! Falha ao criar a Interação Next de Ligação Caiu. Caso Salesforce finalizado como Ligação Caiu.";
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: "Atenção!",
                            message: userFeedbackMsg,
                            variant: "warning"
                        })
                    );
                }

                this.navigateToHomePage();
            }
        )
    }

    async navigateToHomePage() {
        if (this.isConsoleNavigation) {
            const { tabId } = await getFocusedTabInfo();
            await closeTab(tabId);
        } else {
            this[NavigationMixin.Navigate]({
                type: 'standard__namedPage',
                attributes: {
                    pageName: 'home'
                }
            });
        }
    }
}