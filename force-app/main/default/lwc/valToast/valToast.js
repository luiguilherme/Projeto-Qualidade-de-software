import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { OmniscriptBaseMixin } from 'vlocity_cmt/omniscriptBaseMixin';
import pubsub from "vlocity_cmt/pubsub";

export default class ValToast extends OmniscriptBaseMixin(LightningElement) {
    connectedCallback() {
        pubsub.register("valToast",{["showToast"]: this.handleToast.bind(this)});     
    }

    handleToast(data) {
        this.showToast("", data.message, data.variant);      
    }      

    showToast(title, message, variant) {
        const event = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant
        });

        this.dispatchEvent(event);        
    }   
}