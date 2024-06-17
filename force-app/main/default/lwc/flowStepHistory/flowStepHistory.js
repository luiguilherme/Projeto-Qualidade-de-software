import { LightningElement, api, track } from "lwc";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import getByCaseId from "@salesforce/apex/FlowExecutionStepHistoryController.getByCaseId";

export default class FlowStepHistory extends LightningElement {
    @api caseId;
    @track historico = [];
    intervalId;

    connectedCallback() {
        this.intervalId = setInterval(() => { this.recarregarHistorico(); }, 2000);
    }

    disconnectedCallback() {
        clearInterval(this.intervalId);
    }

    recarregarHistorico() {
        //console.log("Recarregando o histórico: " + this.caseId);
        if (this.caseId) {
            getByCaseId({ caseId: this.caseId })
            .then(result => {
                console.log("Resultado do recarregamento do histórico: " + JSON.stringify(result));
                this.historico = result;
            })
            .catch(error => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: "Ops! Ocorreu um erro ao recarregar o histórico de execução do fluxo.",
                        message: error,
                        variant: "error"
                    })
                );
            });
        }       
    }

    pararCarregamentoHistorico() {
        clearInterval(this.intervalId);
    }
}