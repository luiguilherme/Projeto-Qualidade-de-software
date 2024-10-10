import { LightningElement, api, track } from "lwc";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import pubsub from 'vlocity_cmt/pubsub';
import restartFlow from "@salesforce/apex/DisputeFixedFlowController.restartFlow";

export default class LwcContainerFlow extends LightningElement {
    
    @api flowApiName;
    @api caseId;
    @api isCallActive;
    @track inputVariables = [];
    eventParams;

    @track visivel = false;
    _myPubSubHandlers;

    get flowInputVariables() {
        return this.inputVariables;
    }

    connectedCallback() {
        this._myPubSubHandlers = {
            'openFlow': this.openEventHandler.bind(this),
            'closeFlow': this.closeEventHandler.bind(this),
            'finishFlow': this.finishEventHandler.bind(this)
        };
        pubsub.register('FixedDispute', this._myPubSubHandlers);
        pubsub.register('omniscript_step', {
            data: this.handleOmniStepLoadData.bind(this),
        });
    }

    disconnectedCallback() {
        pubsub.unregister('FixedDispute', this._myPubSubHandlers);
    }

    handleOmniStepLoadData(event){
        console.log('Chegamos aqui no handleOmniStepLoadData', event);
        if(event.Name == 'OpenDisputeFlow'){
            pubsub.fire("Dispute", "CloseCard", {});

            this.openEventHandler({
                CaseId: event.CaseId
            })
        }
    }

    openEventHandler(event) {
        if(event.ServiceIdentifier){this.eventParams = event;}

        console.log('Evento para abrir o Flow',JSON.stringify(event));
        console.log(event.CaseId);
        this.caseId = event.CaseId;
        this.flowApiName = "DisputeFixedConvergentInitialValidations";
        this.isCallActive = true;
        this.inputVariables = [
            {
                "name": "caseId",
                "type": "String",
                "value": this.caseId
            },
            {
                "name": "callActive",
                "type": "Boolean",
                "value": this.isCallActive
            },
            {
                "name": "ServiceIdentifier",
                "type": "String",
                "value": event.ServiceIdentifier
            }
        ];
        this.visivel = true;
    }

    closeEventHandler(event) {
        restartFlow({ caseId: this.caseId });
        this.caseId = '';
        this.flowApiName = '';
        this.visivel = false;
    }

    finishEventHandler(event){
        this.visivel = false;
    }

    reloadHistorics(){
        // Recarregar Histórico de Passos
        this.template.querySelector("c-flow-step-history").recarregarHistorico();
        //Recarregar Carrinho de Itens Contesdados
        this.template.querySelector("c-disputed-itens-history").reloadDisputedItens();
    }

    handleFlowStatusChange(event) {
        this.reloadHistorics();

        console.log('Event Flow',event.detail);
        if (event.detail.status === "FINISHED") {
            this.visivel = false;
            pubsub.fire('FixedDispute','finishFlow',{});
            this.dispatchEvent(
                new ShowToastEvent({
                    title: "Success",
                    message: "O fluxo foi executado com sucesso!",
                    variant: "success",
                })
            );  
		}else if(event.detail.status === "STARTED" && event.detail.locationName === 'scFormSelectDisputeItens'){
            restartFlow({ caseId: this.caseId })
            .finally(() => {
                this.reloadHistorics();
            });
        }
    }
}