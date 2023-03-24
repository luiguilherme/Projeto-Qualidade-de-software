import { LightningElement, wire, api } from 'lwc';
import {CurrentPageReference} from 'lightning/navigation';
import { fireEvent } from 'c/pubsub';

export default class CTIServiceIntegrationChild extends LightningElement {
    @wire(CurrentPageReference) pageRef;

    @api fireResumeCanvas() {
        fireEvent(this.pageRef, 'resumecanvaschild', {});
    }
}