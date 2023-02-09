import { LightningElement, track, wire, api } from 'lwc';
import { loadScript } from 'lightning/platformResourceLoader';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

import userId from '@salesforce/user/Id';
import cometd from '@salesforce/resourceUrl/cometd';
import closeCase from '@salesforce/apex/ServiceFlowGPSController.closeCase';
import getSessionId from '@salesforce/apex/GpsCanvasIntegrationController.getSessionId';

export default class GpsCanvasIntegration extends LightningElement {
    libInitialized = false;
    @track sessionId;
    @track error;
    @api recordId;

    @wire(getSessionId)
    wiredSessionId({ error, data }) {
        if (data) {
            this.sessionId = data;
            this.error = undefined;
            loadScript(this, cometd).then(() => {
                this.initializecometd();
            });
        } else if (error) {
            this.error = error;
            this.sessionId = undefined;
        }
    }

    initializecometd() {
        if (this.libInitialized) {
            return;
        }
        this.libInitialized = true;
        var lwcThisContext = this;
        var cometdlib = new window.org.cometd.CometD();
        cometdlib.configure({
            url:
                window.location.protocol +
                '//' +
                window.location.hostname +
                '/cometd/51.0/',
            requestHeaders: { Authorization: 'OAuth ' + this.sessionId },
            appendMessageTypeToURL: false,
            logLevel: 'debug',
        });
        cometdlib.websocketEnabled = false;
        cometdlib.handshake(function (status) {
            if (status.successful) {
                cometdlib.subscribe(
                    '/event/GPSCanvasInterface__e',
                    function (message) {
                        debugger;
                        if (
                            lwcThisContext.recordId ==
                                message.data.payload.CustomerInteractionId__c &&
                            userId == message.data.payload.UserId__c
                        ) {
                            lwcThisContext.handlePlatformEvent(message.data.payload);
                        }
                    }
                );
            } else {
                console.error(
                    'Error in handshaking: ' + JSON.stringify(status)
                );
            }
        });
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