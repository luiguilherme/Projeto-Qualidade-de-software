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
    @api mode= '';
    get mode() {
        return this._mode;
    };
    set mode(value) {
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
        pubsub.register('omniscript_action', {
            data: this.handleToast.bind(this),
        });

        // this.handleToast(this);

        pubsub.register("valToast",{["showToast"]: this.handleToast.bind(this)});
    }

    handleToast(data) {
        console.log('handle toast: '+ JSON.stringify(data));

        if (Array.isArray(data.variant)) {
            console.log('É ARRAY: ');
            // Se `variant` for um array, itera sobre os elementos e executa `showToast` para cada um
            if(data.isNotPushEvent){
                console.log('NÃO É PUSH: ');
                data.variant.forEach((variant, index) => {
                    const message = data.Message[index];
                    this.showToast("", message.message, variant.variant, mode.mode);
                });
            }else{
                console.log('É PUSH: ');
                data.variant.forEach((variant, index) => {
                    const message = data.message[index];
                    this.showToast("", message.message, variant.variant, mode.mode);
                });
            }
        } else {
            this.showToast("", data.message, data.variant, data.mode);
        }

    }

    showMultipleToast(messageArray, variant) {

        messageArray.forEach(item => {
            const toastParams ={
                title: "",
                message: item.message,
                variant: variant
            };
            const event =  new ShowToastEvent(toastParams);
            this.dispatchEvent(event); 
        });
    }

    showToast(title, message, variant, mode) {
        console.log('showToast ' + message + variant + mode);
        const toastParams ={
            title: title,
            message: message,
            variant: variant,
            mode: mode
        };

        const event =  new ShowToastEvent(toastParams);
        this.dispatchEvent(event);        
    }
}