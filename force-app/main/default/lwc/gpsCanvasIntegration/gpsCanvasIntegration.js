import { LightningElement, track, wire, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

import closeCase from '@salesforce/apex/ServiceFlowGPSController.closeCase';
import { getRecord, getRecordNotifyChange  } from 'lightning/uiRecordApi';
import PAYLOAD from "@salesforce/schema/Case.Payload__c";
import timeForRefresh from '@salesforce/label/c.TimeForRefreshCaseRecord';

const fields = [PAYLOAD];
export default class GpsCanvasIntegration extends LightningElement {
    libInitialized = false;
    @track sessionId;
    @track error;
    @api caseId;
    record;

    @wire(getRecord, { recordId: '$caseId', fields})
    wiredRecordCase({data,error}) {
        if(data) {
            if(this.record) {
                if(this.record.fields.Payload__c.value != data.fields.Payload__c.value){
                    let objectParsed = JSON.parse(data.fields.Payload__c.value);
                    this.handlePlatformEvent(objectParsed);
                }
            }
            this.record = data;
        }
        if(error) {
            const evt = new ShowToastEvent({
                title: 'Erro ao carregar o Caso',
                message: 'Por favor abrir um incidente no Remedy. /n $error',
                variant: 'error'
            });
            this.dispatchEvent(evt);
        }

        
        this.timeHandler();
    }

    timeHandler(){
        clearTimeout(this.timeoutId); 
        this.timeoutId = setTimeout(this.doExpensiveThing.bind(this), parseInt(timeForRefresh));
        
    }

    doExpensiveThing() {
        getRecordNotifyChange([{recordId: this.caseId}]);
        this.timeHandler();
    }

    handlePlatformEvent(payload){
        switch (payload.OperationType__c) {
            case 'Finish': {
                this.executeFinish(payload);
                break;
            }

            case 'CloseCanvas': {
                this.dispatchEvent(new CustomEvent('closecanvas'));
                break;
            }

            case 'NewServiceSameClient': {
                this.dispatchEvent(new CustomEvent('newservicesameclient'));
                break;
            }

            default: {
                if (payload.OperationType__c) {
                    const canvasEvent = new CustomEvent('canvasevent', { detail : { payload : payload }});
                    this.dispatchEvent(canvasEvent);
                }
                break;
            }
        }
    }

    executeFinish(payload){
        delete payload.attributes;
        closeCase({
            payload :  payload
        })
            .catch((error) => {
                console.log(error);
                this.showToastMessage('Erro', 'Erro ao encerrar o caso, entre em contato com o administrador.', 'error');
            });
    }

    showToastMessage(title, message, variant) {
        const evt = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant
        });
        this.dispatchEvent(evt);
    }
}