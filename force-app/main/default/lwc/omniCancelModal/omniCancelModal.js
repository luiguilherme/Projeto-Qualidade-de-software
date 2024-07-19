import { LightningElement, api, track, } from 'lwc';
import { OmniscriptBaseMixin } from 'vlocity_cmt/omniscriptBaseMixin';
import pubsub from "vlocity_cmt/pubsub";

export default class OmniCancelModal extends OmniscriptBaseMixin(LightningElement) {

    @api title;
    @api message;
    @api labelButtonLeft;
    @api labelButtonRight;
    @api baseUrl; // URL base para a navegação
    @api contextId;
    @api orderId;
    @api accountId;
    @api functionality;
    @api lineNumber;
    @api assetId;
    showModal = false;

    connectedCallback(){
        pubsub.register("OmniCancelGenericButton", {["OpenCancelModal"]: this.openModal.bind(this)}); 
    }  

    closeModal() {
        this.showModal = false;
    }

    handleButtonLeft() {
        this.closeModal();
    }

    handleButtonRight() {
        const url = `${this.baseUrl}?c__target=c:valAddRelationShipTopicEnglish&c__tabLabel=Palitar Cancelamento&c__tabIcon=standard:cancel_checkout&c__CustomerInteractionId=${this.contextId}&c__OrderId=${this.orderId}&c__AccountId=${this.accountId}&c__SourceCalled=${this.functionality}&c__LineNumber=${this.lineNumber}&c__AssetId=${this.assetId}`;
        window.location.href = url;
        console.log("URL: " + url)
        this.closeModal();
    }
    
    openModal(){
        this.showModal = true;
        console.log("showModal" + this.showModal);
    }
}