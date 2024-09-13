import { LightningElement, api, track } from 'lwc';
import { OmniscriptBaseMixin } from 'vlocity_cmt/omniscriptBaseMixin';
import pubsub from "vlocity_cmt/pubsub";

export default class OmniNextStepGenericButton extends OmniscriptBaseMixin(LightningElement) {
    
    @api openModalButtonLabel;
    @api title;
    @api message;
    @api messageToast;
    @api variant;
    @api labelButtonLeft;
    @api labelButtonRight;
    @api showModalContainer;

    connectedCallback(){
        console.log("showModalContainer: " + this.showModalContainer);
    } 
    handleNextStepOmni() {
        if (this.showModalContainer == "true") {
            this.openModal();
        } else {
            this.omniNextStep();
        }
    }

    openModal() {
        pubsub.fire("OmniNextStepGenericButton", "OpenModal", {});
        console.log("PubSub enviado");
    }
}