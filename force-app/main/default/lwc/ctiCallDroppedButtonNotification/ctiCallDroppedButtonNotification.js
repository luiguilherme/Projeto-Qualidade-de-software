import { api, track, LightningElement, wire } from 'lwc';
import {CurrentPageReference} from 'lightning/navigation';
import pubsub from 'vlocity_cmt/pubsub';
import { fireEvent } from 'c/pubsub';
import { OmniscriptBaseMixin } from 'vlocity_cmt/omniscriptBaseMixin';
import { interpolateWithRegex } from "vlocity_cmt/flexCardUtility";

export default class CtiCallDroppedButtonNotification extends  OmniscriptBaseMixin(LightningElement) {
    isCallActive = false;
    @wire(CurrentPageReference) pageRef;
    @track isNotWDE = window.external && Object.keys(window.external).length === 0 && this.isCallActive;

	_regexPattern = /\{([a-zA-Z.0-9_]+)\}/g; //for {} fields by default

	pubsubEvent = [];

    recoveryIds;
    
    @api customerinteractionid;    

    connectedCallback() {        
        this.recoveryIds = { "CustomerInteractionId__c" : this.customerinteractionid };                
        
        registerListener('iscallactivedreturn', this.handleIsCallActive, this);                
        fireEvent(this.pageRef, 'iscallactived');

        this.pubsubEvent[0] = {[interpolateWithRegex(`recoveryids`, this._allMergeFields, this._regexPattern, "noparse")]: this.getRecoveryIds.bind(this)};        
        this.pubsubChannel0 = interpolateWithRegex(`ctiCallDroppedButtonChild`, this._allMergeFields, this._regexPattern, "noparse");
        pubsub.register(this.pubsubChannel0, this.pubsubEvent[0]);
    }

    handleIsCallActive(params){
        this.isCallActive = params;
    }

    getRecoveryIds(params) {
        this.recoveryIds = params;
    }

    sendNotification() {        
        fireEvent(this.pageRef, 'aplicationevent', this.recoveryIds);
    }

    disconnectedCallback() {
        pubsub.unregister(this.pubsubChannel0,this.pubsubEvent[0]);        
    }    
}