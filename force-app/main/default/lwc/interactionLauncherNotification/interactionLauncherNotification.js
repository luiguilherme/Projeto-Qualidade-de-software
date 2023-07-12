import { LightningElement, wire } from 'lwc';
import {CurrentPageReference} from 'lightning/navigation';
import pubsub from 'vlocity_cmt/pubsub';
import { fireEvent } from 'c/pubsub';
import { OmniscriptBaseMixin } from 'vlocity_cmt/omniscriptBaseMixin';
import {interpolateWithRegex, interpolateKeyValue, fetchCustomLabels, loadCssFromStaticResource } from "vlocity_cmt/flexCardUtility";


export default class InteractionLauncherNotification extends OmniscriptBaseMixin(LightningElement) {
    @wire(CurrentPageReference) pageRef;

	_regexPattern = /\{([a-zA-Z.0-9_]+)\}/g; //for {} fields by default

	pubsubEvent = [];

    connectedCallback() {
		this.pubsubEvent[0] = {[interpolateWithRegex(`minimize`, this._allMergeFields, this._regexPattern, "noparse")]: this.sendMinimizeUtilityBarToAura.bind(this)};
		this.pubsubChannel0 = interpolateWithRegex(`utilitybar`, this._allMergeFields, this._regexPattern, "noparse");
		pubsub.register(this.pubsubChannel0, this.pubsubEvent[0]);
		pubsub.register(this.pubsubChannel0, this.pubsubEvent[1]);
    }

    sendMinimizeUtilityBarToAura(params) {
        console.log('InteractionLauncherNotification sendMinimizeUtilityBarToAura');
        fireEvent(this.pageRef, 'minimizeutilitybar', params);
    }

    // closeCanvasHandler(params) {
    //     fireEvent(this.pageRef, 'closecanvas', params);
    // }

    // finishFlowFire() {
    //     pubsub.fireEvent(this.pageRef, 'finishflow', {});
    // }

    disconnectedCallback() {
        pubsub.unregister(this.pubsubChannel0,this.pubsubEvent[0]);
        //pubsub.unregister(this.pubsubChannel0,this.pubsubEvent[1]);
    }
 

}