import { LightningElement, wire, api } from 'lwc';
import {CurrentPageReference} from 'lightning/navigation';
import { registerListener, unregisterAllListeners, fireEvent } from 'c/pubsub';

export default class InteractionLauncherListner extends LightningElement {
 @wire(CurrentPageReference) pageRef

    connectedCallback() {
        console.log('minimizeutilitybar registrado no interactionLauncherListner');
        registerListener('minimizeutilitybar', this.handleEventToAura, this);
    }

    handleEventToAura(params) {
        console.log('handleEventToAura: ' + JSON.stringify(params));
        const filterChangeEvent = new CustomEvent('minimizeutilitybar', {
            detail: { params },
        });
        // Fire the custom event
        this.dispatchEvent(filterChangeEvent);
    }

    // @api fireFinishFlow() {
    //     fireEvent(this.pageRef, 'finishflowchild', {});
    // }
}