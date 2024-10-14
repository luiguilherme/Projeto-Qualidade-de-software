import { LightningElement, api, track } from 'lwc';
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import getByCaseId from "@salesforce/apex/DisputedItemController.getByCaseId";

export default class DisputedItensHistory extends LightningElement {
    @api caseId;
    @track disputedItens = [];
    intervalId;
    activeSections = ['A'];

    connectedCallback() {
        this.reloadDisputedItens();
    }

    @api
    reloadDisputedItens() {  
        if (this.caseId) {
            getByCaseId({ caseId: this.caseId })
            .then(result => {
                console.log("Resultado do recarregamento dos itens contestados: " + JSON.stringify(result));
                this.disputedItens = result;
            })
            .catch(error => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: "Ops! Ocorreu um erro ao recarregar os itens contestados.",
                        message: error,
                        variant: "error"
                    })
                );
            });
        }
    }
}