import { LightningElement, wire, api } from 'lwc';
import {CurrentPageReference} from 'lightning/navigation';
import { registerListener, unregisterAllListeners, fireEvent } from 'c/pubsub';

export default class ServiceFlowGPSCanvasChild extends LightningElement {
    @wire(CurrentPageReference) pageRef;

    connectedCallback() {
        console.log('eventtoaura registrado no child');
        registerListener('eventtoaura', this.handleEventToAura, this);
        registerListener('closecanvas', this.handleCloseCanvas, this);
    }

    handleEventToAura(params) {
        console.log('handleEventToAura: ' + JSON.stringify(params));
        const filterChangeEvent = new CustomEvent('eventtocanvasaura', {
            detail: { params },
        });
        // Fire the custom event
        this.dispatchEvent(filterChangeEvent);
    }

    handleCloseCanvas(params) {
        const filterChangeEvent = new CustomEvent('closecanvas', {
            detail: { params },
        });
        // Fire the custom event
        this.dispatchEvent(filterChangeEvent);
    }

    @api fireFinishFlow() {
        fireEvent(this.pageRef, 'finishflowchild', {});
    }

    @api canvasOpened() {
        fireEvent(this.pageRef, 'canvasOpened', {});
    }
}
