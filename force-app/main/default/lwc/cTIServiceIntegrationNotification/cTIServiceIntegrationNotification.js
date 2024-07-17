import { LightningElement, wire } from 'lwc';
import {CurrentPageReference} from 'lightning/navigation';
import pubsub from 'vlocity_cmt/pubsub';
import { registerListener } from 'c/pubsub';
import { OmniscriptBaseMixin } from 'vlocity_cmt/omniscriptBaseMixin';

export default class CTIServiceIntegrationNotification extends OmniscriptBaseMixin(LightningElement) {
    @wire(CurrentPageReference) pageRef;

	_regexPattern = /\{([a-zA-Z.0-9_]+)\}/g; //for {} fields by default

	pubsubEvent = [];
    pubsubFlex = pubsub;


    connectedCallback() {
        registerListener('resumecanvaschild', this.handleResumeCanvasChild, this);
    }
    handleResumeCanvasChild() {
        debugger;
        this.pubsubFlex.fire('canvasGPS', 'resumeCanvas', {});
    }
}