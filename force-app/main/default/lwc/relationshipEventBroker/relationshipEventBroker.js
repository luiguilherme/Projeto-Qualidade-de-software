import { LightningElement, api, wire } from 'lwc';
import { OmniscriptBaseMixin } from 'vlocity_cmt/omniscriptBaseMixin'; 

import { registerListener, fireEvent } from 'c/pubsub';
import {CurrentPageReference} from 'lightning/navigation';


export default class RelationshipEventBroker extends OmniscriptBaseMixin(LightningElement) {

    @api recordId;
    @wire(CurrentPageReference) pageRef;
    
    connectedCallback() {
        registerListener('calldroppedbuttonnotification', this.handleCallDroppedEvent, this);
        console.log("[EVENTBROKERLOG] - event dispatched");
    }

    handleCallDroppedEvent(event) {
        console.log("RelationshipEventBroker.js handleCallDroppedEvent");
        const customEvent = new CustomEvent("calldroppedbuttonnotificationtobroadcast", {
            bubbles: true,
            detail: {
                        "sobject": event,
                        "json": event.CustomerInteractionId__c,
                        "type": 'GPSCanvasIntegration_CallDropped'
                    } //assure its an obj
        });
        //adjustPayload
        this.dispatchEvent(customEvent);
    }

}