import { LightningElement, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { OmniscriptBaseMixin } from 'vlocity_cmt/omniscriptBaseMixin';
import pubsub from "vlocity_cmt/pubsub";

export default class ValToast extends OmniscriptBaseMixin(LightningElement) {

    @api robotFire= false;
    get robotFire() {
        return this._robotFire;
    };     
    set robotFire(value) {
        this._robotFire = value;
    }
    @api message= '';
    get message() {
        return this._message;
    };     
    set message(value) {
        this._message = value;
    }    
    @api variant='';
    get variant() {
        return this._variant;
    };     
    set variant(value) {
        this._variant = value;
    }    

    connectedCallback() {
        pubsub.register("valToast",{["showToast"]: this.handleToast.bind(this)});     
        pubsub.register("valToast",{["showModeToast"]: this.handleModeToast.bind(this)});   

        //console.log('robotFire: '+this._robotFire);
        //console.log('data toast: '+JSON.stringify(this));
        //if(this._robotFire==true){
        //   this.showToast("", _message, _variant);                  
        //}
        
    }

    handleToast(data) {
        console.log('handle toast: '+data);
        this.showToast("", data.message, data.variant);      
    }     
    handleModeToast(data) {
        this.showToast("", data.message, data.variant, data.mode);  
    }      

    showToast(title, message, variant) {
        const event = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant
        });

        this.dispatchEvent(event);        
    }

    showToast(title, message, variant, mode) {
        const event = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant, 
            mode: mode
        });

        this.dispatchEvent(event);        
    }   
}