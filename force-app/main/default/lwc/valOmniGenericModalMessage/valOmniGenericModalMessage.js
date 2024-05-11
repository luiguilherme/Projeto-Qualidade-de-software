import { LightningElement, api, track, } from 'lwc';
import { OmniscriptBaseMixin } from 'vlocity_cmt/omniscriptBaseMixin';
import pubsub from "vlocity_cmt/pubsub";

export default class ValOmniGenericModalMessage extends OmniscriptBaseMixin(LightningElement) {
    
    next_step_omni() {
        this.omniNextStep();
    }

    @api title;
    @api message;
    @api labelButtonLeft;
    @api labelButtonRight;
    showModal = false;

    connectedCallback(){
        pubsub.register("OmniNextStepGenericButton", {["OpenModal"]: this.openModal.bind(this)}); 
    }  

    closeModal() {
        this.showModal = false;
    }

    handleButtonLeft() {
        this.closeModal();
    }

    handleButtonRight() {
        this.next_step_omni();
        this.closeModal();
    }
    
    openModal(){
        this.showModal = true;
        console.log("showModal" + this.showModal);
    }
}