import { LightningElement,track, api } from 'lwc';
export default class AssetMigrationModal extends LightningElement {
    @api haveTokenAccess;
    @api haveUserAccess;
    headerText = 'Atenção!';
    bodyText;

    renderedCallback() {
        if(!this.haveTokenAccess){
            this.bodyText = 'É necessário realizar a validação de segurança (token) antes de iniciar o fluxo.';
        } else if(!this.haveUserAccess){
            this.bodyText = 'No momento você está sem acesso à funcionalidade de Troca de Oferta, verifique com o seu CSL/SAL.';
        }
    }

    closeModal() {
        let ev = new CustomEvent('closemodal', {
            detail : {
                isModalOpen: false
            }
        });

        this.dispatchEvent(ev);
    }
}