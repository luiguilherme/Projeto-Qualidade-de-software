import { LightningElement, api, track, wire } from 'lwc';
import { FlexCardMixin } from "vlocity_cmt/flexCardMixin";
import pubsub from 'vlocity_cmt/pubsub';

const columns = [
    { label: 'Instância', fieldName: 'Instância', hideDefaultActions: true},
    { label: 'Protocolo', fieldName: 'Protocolo', hideDefaultActions: true },
    { label: 'Interação', fieldName: 'Palito', hideDefaultActions: true },
    { label: 'Data da Criação', fieldName: 'Data', hideDefaultActions: true},
    { label: 'Notas', fieldName: 'Notas', hideDefaultActions: true}
];

export default class DisputeShowCustomerInteractionDataTableLWC extends FlexCardMixin(LightningElement) {

    columns = columns;
    @api items = [];
    @api showRow;
    showSelectRow = true;
    @track selectedRow = [];

    connectedCallback(){
        console.log('showRow ', this.showRow)

        if(this.showRow == 'false' || this.showRow == false){
            this.showSelectRow = false;
            console.log('showRow ', this.showRow)
        }
    }

    handleSelection(event){
        this.selectedRow = event.detail.selectedRows[0];
        if(this.selectedRow.Palito){
         pubsub.fire("ParentFlexCard", "showresult", {rowvalue: 'yes'}); //Não alterar essa flag a mesma é base do step PLANO027(H157) do omniscript de Cancelamento de Assinatura.
        }
    }
}