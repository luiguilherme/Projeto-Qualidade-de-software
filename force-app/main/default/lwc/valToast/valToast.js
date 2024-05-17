import { LightningElement, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { OmniscriptBaseMixin } from 'vlocity_cmt/omniscriptBaseMixin';
import pubsub from "vlocity_cmt/pubsub";

export default class ValToast extends OmniscriptBaseMixin(LightningElement) {

    @api message= '';
    get message() {
        return this._message;
    };     
    set message(value) {
        this._message = value;
        console.log('value..'+ value);
    }    
    @api variant='';
    get variant() {
        return this._variant;
    };     
    set variant(value) {
        this._variant = value;
        console.log('value..'+ value);
    }    

    connectedCallback() {
        console.log('valToast ConnectedCallback');
        console.log('data toast: ' + JSON.stringify(this));

        pubsub.register("valToast",{["showToast"]: this.handleToast.bind(this)});     
    }

    handleToast(data) {
        console.log('handle toast: '+ JSON.stringify(data));
        this.showToast("", data.message, data.variant);
    }     

    showToast(title, message, variant) {
        console.log('showToast ' + message + variant);
        const toastParams ={
            title: title,
            message: message,
            variant: variant
        };

        const event =  new ShowToastEvent(toastParams);
        this.dispatchEvent(event);        
    }
}