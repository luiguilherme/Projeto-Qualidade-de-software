import { LightningElement, api, wire } from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import getEnpoint from '@salesforce/apex/TreatmentConsultationController.getEnpoint';

import SERVICE_REQUEST_ID_FIELD from '@salesforce/schema/Case.ServiceRequestId__c';

const fields = [SERVICE_REQUEST_ID_FIELD];

export default class ServiceRequestTreatmentConsultation extends LightningElement {
    @api recordId;

    @wire(getRecord, { recordId: '$recordId', fields })
    case;

    @wire(getEnpoint) endpoint;

    get serviceRequestId() {
        return getFieldValue(this.case.data, SERVICE_REQUEST_ID_FIELD);
    }

    handleTreatmentConsultation() {
        window.open(this.endpoint.data + 'idss=' + this.serviceRequestId);
    }
}