import { LightningElement, api, track } from 'lwc';
import { OmniscriptBaseMixin } from 'vlocity_cmt/omniscriptBaseMixin';
import pubsub from "vlocity_cmt/pubsub";

export default class OmniCancelGenericButton extends OmniscriptBaseMixin(LightningElement) {
    @api openModalButtonLabel;
    @api title;
    @api message;
    @api labelButtonLeft;
    @api labelButtonRight;
    @api baseUrl; // URL base para a navegação
    @api contextId;
    @api orderId;
    @api accountId;
    @api lineNumber;
    @api assetId;
    @api showModalCancel;
    

    connectedCallback(){
        console.log("openModalButtonLabel: " + this.openModalButtonLabel);
        console.log("title: " + this.title);
        console.log("message: " + this.message);
        console.log("labelButtonLeft: " + this.labelButtonLeft);
        console.log("labelButtonRight: " + this.labelButtonRight);
        console.log("baseUrl: " + this.baseUrl);
        console.log("contextId: " + this.contextId);
        console.log("orderId: " + this.orderId);
        console.log("accountId: " + this.accountId);
        console.log("lineNumber: " + this.lineNumber);
        console.log("assetId: " + this.assetId);
        console.log("showModalCancel: " + this.showModalCancel);
    } 
    handleNextStepOmni() {
        this.openModal();
    }

    openModal() {
        pubsub.fire("OmniCancelGenericButton", "OpenCancelModal", {});
    }
}