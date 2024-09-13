import { LightningElement, api, wire } from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import getEnpoint from '@salesforce/apex/TreatmentConsultationPreController.getEnpoint';

import PROTOCOL_URA_FIELD from '@salesforce/schema/Case.ProtocolURA__c';

const fields = [PROTOCOL_URA_FIELD];

export default class ServiceRequestTreatmentPre extends LightningElement {
    @api recordId;

    @wire(getRecord, { recordId: '$recordId', fields })
    case;

    @wire(getEnpoint) endpoint;

    get protocolUra() {
        return getFieldValue(this.case.data, PROTOCOL_URA_FIELD);
    }

    handleTreatmentPre() {
        window.open(this.endpoint.data + 'protocolo=' + this.protocolUra);
    }
}