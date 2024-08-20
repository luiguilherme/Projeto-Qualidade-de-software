import { LightningElement, api, track, } from 'lwc';
import { OmniscriptBaseMixin } from 'vlocity_cmt/omniscriptBaseMixin';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import pubsub from "vlocity_cmt/pubsub";

export default class ValOmniGenericModalMessage extends OmniscriptBaseMixin(LightningElement) {
    
    next_step_omni() {
        this.omniNextStep();
    }

    @api title;
    @api message;
    @api messageToast;
    @api variant;
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
        this.showToast("", this.messageToast, this.variant);
        this.next_step_omni();
        this.closeModal();
    }
    
    openModal(){
        this.showModal = true;
        console.log("showModal" + this.showModal);
    }

    showToast(title, message, variant) {
        console.log('showToast ' + message + variant);
        if(message!=null){
            const toastParams ={
                title: title,
                message: message,
                variant: variant
            };
            console.log('JSONtoastParams ' + JSON.stringify(toastParams));
            const event =  new ShowToastEvent(toastParams);
            this.dispatchEvent(event);
        }
    }
}