import { LightningElement, api} from 'lwc';
import { OmniscriptBaseMixin } from 'vlocity_cmt/omniscriptBaseMixin';
import pubsub from 'vlocity_cmt/pubsub';
import { interpolateWithRegex } from 'vlocity_cmt/flexCardUtility';
import { OmniscriptActionCommonUtil } from 'vlocity_cmt/omniscriptActionUtils';

export default class DisputeShowCompleteService extends OmniscriptBaseMixin(LightningElement) {

    pubsubEvents = {};
    _actionUtil;
    _regexPattern = /\{([a-zA-Z.0-9_]+)\}/g;

    @api accountHref;
    @api barId;
    @api documentNumber;
    @api faId;
    @api serviceId;
    @api customerAccountId;

    connectedCallback(){
        this._actionUtil = new OmniscriptActionCommonUtil();
        const obj = {
            accountHref: this.accountHref,   
            barId: this.barId,   
            documentNumber: this.documentNumber,   
            faId: this.faId,   
            serviceId: this.serviceId,    
            customerAccountId: this.customerAccountId
        }
        pubsub.fire('DisputeFlexCardWrapper', 'GetCustomerIds', obj);
        pubsub.fire('valServiceFlow', 'ShowDisputeCompleteService', { ShowDisputeCompleteService: true});
    }

    disconnectedCallback(){
        this.unsubscribeFromAllEvents();
    }

    subscribeToEvent(channel, event, callback){
        const channelKey = interpolateWithRegex(channel, this._allMergeFields, this._regexPattern, 'noparse');
        if (!this.pubsubEvents[channelKey]) {
            this.pubsubEvents[channelKey] = {};
        }

        const eventKey = interpolateWithRegex(event, this._allMergeFields, this._regexPattern, 'noparse');
        this.pubsubEvents[channelKey][eventKey] = callback;
        pubsub.register(channelKey, this.pubsubEvents[channelKey]);
    }

    unsubscribeFromAllEvents(){
        Object.keys(this.pubsubEvents).forEach((channelKey) => {
            pubsub.unregister(channelKey, this.pubsubEvents[channelKey]);
        });
    }

}
