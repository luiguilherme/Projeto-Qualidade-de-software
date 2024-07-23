import { LightningElement, api } from 'lwc';
import { RefreshEvent } from "lightning/refresh";
import { OmniscriptBaseMixin } from 'vlocity_cmt/omniscriptBaseMixin';
import pubsub from "vlocity_cmt/pubsub";

export default class valRefresh extends OmniscriptBaseMixin(LightningElement) {


    @api message = '';
    get message() {
        return this._message;
    };
    set message(value) {
        this._message = value;
        console.log('value..' + value);
    }

    connectedCallback() {

        pubsub.register("valRefresh", { ["reload"]: this.handleToast.bind(this) });

    }

    handleToast(data) {
        if (data.message) {
            this.reload();
        }

    }

    promiseFunc() {
        return new Promise((resolve, reject) => {
            //setTimeout(() => {window.location.reload(true);}, 8000);
            setTimeout(() => {location.reload();}, 8000);
        });
    }

    reload() {
    console.log('entrei no reload location');
    (async () => {
        try {
            const value = await this.promiseFunc();
            console.log('await' + value);
        } catch (error) {
            this.error = error;
        } finally {
            this.isLoaded = true;
        }
    })();        
    }

}