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
    disputeType;

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

    handleFlowStatusChange(event) {
        console.log('Event Flow',event.detail);
        console.log('Event Flow Active Stages',JSON.stringify(event.detail.activeStages));
        console.log('Event Flow Current Stages',event.detail.currentStage);
        console.log('Event Flow OutputVariables',event.detail.outputVariables);
        console.log('Event Flow OutputVariables Type',typeof(event.detail.outputVariables));
        console.log('Event Flow Status',JSON.stringify(event.detail.status));
        if (event.detail.status === "FINISHED") {
            this.visivel = false;
            if(this.disputeType == 'Móvel'){
                console.log({
                    "OpenDispute":true,
                    "LegacySystemTopicTree":this.eventParams.LegacySystemTopicTree? this.eventParams.LegacySystemTopicTree: "",
                    "AssetId":this.eventParams.AssetId? this.eventParams.AssetId: "",
                    "ServiceIdentifier":this.eventParams.ServiceIdentifier? this.eventParams.ServiceIdentifier: "",
                    "CaseId":this.caseId,
                    "AccountId":this.eventParams.AccountId? this.eventParams.AccountId: "",
                    "InteractionId":this.eventParams.InteractionId? this.eventParams.InteractionId: "",
                    "InteractionTopicId":this.eventParams.InteractionTopicId? this.eventParams.InteractionTopicId: "",
                    "ContactId":this.eventParams.ContactId? this.eventParams.ContactId: ""
                })
                pubsub.fire('Dispute', 'Open', {
                    "OpenDispute":true,
                    "LegacySystemTopicTree":this.eventParams.LegacySystemTopicTree? this.eventParams.LegacySystemTopicTree: "",
                    "AssetId":this.eventParams.AssetId? this.eventParams.AssetId: "",
                    "ServiceIdentifier":this.eventParams.ServiceIdentifier? this.eventParams.ServiceIdentifier: "",
                    "CaseId":this.caseId,
                    "AccountId":this.eventParams.AccountId? this.eventParams.AccountId: "",
                    "InteractionId":this.eventParams.InteractionId? this.eventParams.InteractionId: "",
                    "InteractionTopicId":this.eventParams.InteractionTopicId? this.eventParams.InteractionTopicId: "",
                    "ContactId":this.eventParams.ContactId? this.eventParams.ContactId: ""
                });
            }else{
                pubsub.fire('FixedDispute','finishFlow',{});
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: "Success",
                        message: "O fluxo foi executado com sucesso!",
                        variant: "success",
                    })
                );
            }
			
		}else if(event.detail.status === "STARTED" && event.detail.locationName === 'scAutomaticAction' && event.detail.outputVariables[2].value == 'PREVER001.2'){
            this.disputeType = event.detail.outputVariables[0].value;
        }
    }
}