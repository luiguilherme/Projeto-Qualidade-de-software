import { LightningElement, api } from 'lwc';
import { OmniscriptBaseMixin } from 'vlocity_cmt/omniscriptBaseMixin';
import pubsub from 'vlocity_cmt/pubsub';

export default class ValGenericEventDispatcher extends OmniscriptBaseMixin(LightningElement) {
    
    @api channelName
    @api eventName
    @api parameters
    
    connectedCallback() {
        console.log("parameters: " + this.parameters);    
        pubsub.fire(this.channelName, this.eventName, this.parameters);
    }
}