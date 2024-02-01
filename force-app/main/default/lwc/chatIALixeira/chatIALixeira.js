import { LightningElement, track, api } from 'lwc';
export default class ChatIAFeedback extends LightningElement {

    connectedCallback(){
        this.isModalOpen = true;
    }
    closeModal(event){
        this.isModalOpen = false;
        this.dispatchEvent(
            new CustomEvent('lixeira', { detail: 'cancelado' })
          );
    }
    handleConfirma(event){
        this.dispatchEvent(
            new CustomEvent('lixeira', { detail: 'sucesso' })
          );
    }
   
}