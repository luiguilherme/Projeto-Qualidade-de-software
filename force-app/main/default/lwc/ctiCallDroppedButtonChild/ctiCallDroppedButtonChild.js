import { LightningElement, wire, track, api } from 'lwc';
import { CurrentPageReference } from 'lightning/navigation';
import { registerListener, fireEvent } from 'c/pubsub';

export default class CTICallDroppedButtonChild extends LightningElement {
    @wire(CurrentPageReference) pageRef;
    @api isCallActive;

    connectedCallback() {
        console.log('CTI CallDropped registrado no child');        
        registerListener('aplicationevent', this.handleAplicationEvent, this);        
        registerListener('iscallactived', this.handleIsCallActived, this);        
    }

    handleAplicationEvent(params) {
        console.log('handleAplicationEvent: ' + JSON.stringify(params));
        const filterChangeEvent = new CustomEvent('aplicationeventaura', {
            detail: { params },            
        });
        // Fire the custom event
        this.dispatchEvent(filterChangeEvent);
    }

    handleIsCallActived(params) {
        fireEvent(this.pageRef, 'iscallactivedreturn', this.isCallActive)
    }
}
