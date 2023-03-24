import { LightningElement, wire } from 'lwc';
import {CurrentPageReference} from 'lightning/navigation';
import pubsub from 'vlocity_cmt/pubsub';
import { registerListener, unregisterAllListeners, fireEvent } from 'c/pubsub';
import { OmniscriptBaseMixin } from 'vlocity_cmt/omniscriptBaseMixin';
import {interpolateWithRegex, interpolateKeyValue, fetchCustomLabels, loadCssFromStaticResource } from "vlocity_cmt/flexCardUtility";


export default class ServiceFlowGPSCanvasNotification extends OmniscriptBaseMixin(LightningElement) {
    @wire(CurrentPageReference) pageRef;

	_regexPattern = /\{([a-zA-Z.0-9_]+)\}/g; //for {} fields by default

	pubsubEvent = [];
    pubsubFlex = pubsub;


    connectedCallback() {
		this.pubsubEvent[0] = {[interpolateWithRegex(`opencanvas`, this._allMergeFields, this._regexPattern, "noparse")]: this.sendNotification.bind(this)};
		this.pubsubEvent[1] = {[interpolateWithRegex(`closecanvas`, this._allMergeFields, this._regexPattern, "noparse")]: this.closeCanvasHandler.bind(this)};
		this.pubsubChannel0 = interpolateWithRegex(`canvasGPS`, this._allMergeFields, this._regexPattern, "noparse");
		pubsub.register(this.pubsubChannel0, this.pubsubEvent[0]);
		pubsub.register(this.pubsubChannel0, this.pubsubEvent[1]);

        registerListener('finishflowchild', this.finishFlowFire, this);
        registerListener('canvasOpened', this.canvasOpenedFire, this);
    }

    sendNotification(params) {
        fireEvent(this.pageRef, 'eventtoaura', params);
    }

    closeCanvasHandler(params) {
        fireEvent(this.pageRef, 'closecanvas', params);
    }

    finishFlowFire() {
        debugger;
        this.pubsubFlex.fire('canvasGPS', 'finishFlow', {});
    }

    canvasOpenedFire(){
        this.pubsubFlex.fire('canvasGPS', 'openedCanvas', {});
    }

    disconnectedCallback() {
        pubsub.unregister(this.pubsubChannel0,this.pubsubEvent[0]);
        pubsub.unregister(this.pubsubChannel0,this.pubsubEvent[1]);
        unregisterAllListeners(this);
    }

}