import { LightningElement, wire } from 'lwc';
import {CurrentPageReference} from 'lightning/navigation';
import pubsub from 'vlocity_cmt/pubsub';
import { OmniscriptBaseMixin } from 'vlocity_cmt/omniscriptBaseMixin';
import {interpolateWithRegex, interpolateKeyValue, fetchCustomLabels, loadCssFromStaticResource } from "vlocity_cmt/flexCardUtility";

export default class ServiceFlowGPSCanvasNotification extends OmniscriptBaseMixin(LightningElement) {
    @wire(CurrentPageReference) pageRef;
    pubsubFlex = pubsub;

    _regexPattern = /\{([a-zA-Z.0-9_]+)\}/g; //for {} fields by default

    connectedCallback() {
        this.pubsubFlex.fire('updatedata', 'refreshdata', {});
    }

}