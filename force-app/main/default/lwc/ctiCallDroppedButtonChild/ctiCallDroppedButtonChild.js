import { LightningElement, wire, track, api } from 'lwc';
import { CurrentPageReference } from 'lightning/navigation';
import { registerListener, fireEvent } from 'c/pubsub';

export default class CTICallDroppedButtonChild extends LightningElement {
    @wire(CurrentPageReference) pageRef;

    connectedCallback() {
        console.log('CTI CallDropped registrado no child');        
        registerListener('aplicationevent', this.handleAplicationEvent, this);       
        registerListener('calldroppedbuttonnotification', this.handleAplicationEventTest, this);       
    }

    handleAplicationEvent(params) {
        console.log('handleAplicationEvent');
        const filterChangeEvent = new CustomEvent('aplicationeventaura', {
            detail: { params },            
        });
        // Fire the custom event
        this.dispatchEvent(filterChangeEvent);
    }

    handleAplicationEventTest(params) {
        console.log('handleAplicationEventTest');
        const filterChangeEvent = new CustomEvent('calldroppedbuttonnotificationaura', {
            detail: { params },            
        });
        // Fire the custom event
        this.dispatchEvent(filterChangeEvent);
    }

}