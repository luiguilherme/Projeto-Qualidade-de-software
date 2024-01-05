import { LightningElement, api, wire, track } from 'lwc';
import getCustomerIntAPX from '@salesforce/apex/PIDTokenValidateController.getCustomerIntAPX';
import updateTokenStatus from '@salesforce/apex/PIDTokenValidateController.updateTokenStatus';
import sendToken from '@salesforce/apex/PIDTokenValidateController.sendToken';
import { refreshApex } from "@salesforce/apex";
import pubsub from 'vlocity_cmt/pubsub';

export default class PidTokenValidate extends LightningElement {
    @api recordId;
    phone;
    phoneFormatted;
    @track returnValue;
    showTokenScreen = false;
    showComponent = false;
    hasError = false;
    showPath = false;
    currentStep = 1;
    screenStatus;
    handleEventObj;
    showPhone = false;

    // Buttons
    isEnviar = false;
    isCancelarToken = false;
    isCarregando = false;

    // Progress Indicator
    piStep1 = 'Enviando Token';
    piStep2 = '';
    piStep3 = '';
    initialPiStep1Classname = 'slds-size_1-of-3  initialClassStep1';
    initialPiStep2Classname = 'slds-size_2-of-3 initialClassStep2';
    initialPiStep3Classname = 'slds-size_3-of-3 initialClassStep3';
    piStep1Classname = '';
    piStep2Classname = '';
    piStep3Classname = '';
    cssFinalStep = '';
    cssMedStep = '';

    // Timer
    isTimerOn = false;
    @track timer = '00:00';
    timeMiliseconds;
    systemTimeMs;
    timeIntervalInstance;
    timeIntervalInstanceNoAsset;
    hasNoAssetTimer = false;



    // Counter
    countAttempt;
    maxCountAttempts;

    connectedCallback() {
        this.registerPubSub();
    }

    beginPidToken(){
        this.showTokenScreen = true;
    }

    @wire(getCustomerIntAPX, {aRecordId: '$recordId'})
    wiredCustomerIntAPX( result ) {
        this.returnValue = result;

        if (result.data) {
            if(result.data.hasAccess){
                this.showTokenScreen = this.showTokenScreen == true || result.data.tokenStatus != undefined ? true : false
                this.showComponent = true;

                if(result.data.phone === 'Não possui linha válida') {
                    this.phoneFormatted = 'Não Possui Linha Válida';
                    this.disableAllScene();
                } else {
                    this.phone = this.isNotEndedStatus(result) ? result.data.phone : result.data.sendedPhone ? result.data.sendedPhone : '';
                    this.phoneFormatted = this.phone.toString().slice(0,2) + '-' + this.phone.toString().slice(2,11);
                    this.maxCountAttempts = result.data.attempts;
                    this.countAttempt = result.data.tokenSendAttempts;
                    if (this.isNotEndedStatus(result) && 
                        this.countAttempt <= this.maxCountAttempts &&
                        this.isCarregando == false ) {
                        this.isEnviar = true;
                    } else {
                        this.disableAllScene();

                        if(result.data.tokenStatus === 'Cancelado') {
                            this.piStep1 = 'Token Enviado';
                            this.piStep2 = '';
                            this.piStep3 = 'Fluxo Cancelado';
                            this.isTimerOn = false;
                            this.currentStep = '3';
                            this.hasError = true;
                            this.showPath = true;
                            this.cssTokenCancelled();
                            this.disableAllScene();
                        } else if(result.data.tokenStatus === 'Validado') {
                            this.piStep1 = 'Token Enviado';
                            this.piStep2 = '';
                            this.piStep3 = 'Token Validado!';
                            this.showPath = true;
                            this.currentStep = '3';
                            this.resetTimer();
                            this.cssValidatedToken();
                        } else if(this.countAttempt >= this.maxCountAttempts && result.data.tokenStatus != 'Aguardando validação'  ) {
                            this.piStep1 = 'Token Enviado';
                            this.piStep3 = 'Token Não Validado Por Nº De Tentativas Excedidas';
                            this.showPath = true;
                            this.currentStep = '3';
                            this.hasError = true;
                            this.cssLimitExceed();
                        } else if(result.data.tokenStatus === 'Não validado' && this.countAttempt < this.maxCountAttempts) {
                            this.piStep1 = 'Token Enviado';
                            this.piStep2 = 'Token Não Validado! Envie Novamente';
                            this.isEnviar = true;
                            this.showPath = true;
                            this.currentStep = '2';
                            this.hasError = true;
                            this.cssTokenNoValidated();
                        } else if(result.data.tokenStatus === 'Aguardando validação'){
                            this.piStep1 = 'Token Enviado';
                            this.piStep2 = 'Aguardando Validação';
                            this.isEnviar = false;
                            this.showPath = true;
                            this.currentStep = '2';
                            this.hasError = false;
                            this.isCancelarToken = true;
                            this.isCarregando = true;
                            this.isTimerOn = true;
                            this.countAttempt = result.data.tokenSendAttempts;
                        } else if(result.data.tokenStatus === 'Falha na comunicação API'){
                            this.piStep1 = 'Falha no envio';
                            this.showPath = true;
                            this.currentStep = '1';
                            this.hasError = true;
                            this.resetTimer();
                        }
                    }
                }
            }
        }
    }

    startTimer() {
        var parentThis = this;
        this.timeIntervalInstance = setInterval(function() {
            var minutes = Math.floor((parentThis.timeMiliseconds % (1000 * 60 * 60)) / (1000 * 60));
            var seconds = Math.floor((parentThis.timeMiliseconds % (1000 * 60)) / 1000);
            parentThis.timer = String(minutes).padStart(2,'0') + ':' + String(seconds).padStart(2,'0');

            if(parentThis.timeMiliseconds <= 0) {
                clearInterval(parentThis.timeIntervalInstance);
                if (parentThis.countAttempt === parentThis.maxCountAttempts) {
                    parentThis.disableAllScene();
                    parentThis.cssLimitExceed();
                    parentThis.piStep1 = 'Token Enviado';
                    parentThis.piStep2 = '';
                    parentThis.piStep3 = 'Token Não Validado Por Nº De Tentativas Excedidas';
                    parentThis.showPath = true;
                    parentThis.currentStep = '3';
                    parentThis.hasError = true;
                } else {
                    parentThis.isEnviar = true;
                    parentThis.isCarregando = false;
                    parentThis.piStep1 = 'Token Enviado';
                    parentThis.piStep2 = 'Token Não Validado! Envie novamente';
                    parentThis.hasError = true;
                    parentThis.cssTokenNoValidated();
                }
                parentThis.resetTimer();

                updateTokenStatus({customerIntId: parentThis.recordId, tokenStatus: 'Não validado'});
            }

            parentThis.refreshData();
            parentThis.timeMiliseconds -= 1000;
        }, 1000);
        
        
    }

    handleEnviar(Event) {
        this.hasError = false;
        this.isEnviar = false;
        this.isCancelarToken = true;
        this.isCarregando = true;
		this.showPath = true;
		this.currentStep = '1';
        this.resetTimer();
        this.piStep1 = 'Enviando Token';

        if(this.countAttempt < this.maxCountAttempts) {
            this.systemTimeMs = this.returnValue.data.interval * 60000;
            this.timeMiliseconds = this.returnValue.data.interval * 60000;
            this.handleSendToken();
        } else {
            this.isTimerOn = false;
            this.isCancelarToken = false;
            this.isCarregando = false;
            this.currentStep = '3';
            this.hasError = true;
            this.handleUpdateTokenStatus('Não validado');                            
            this.piStep1 = 'Token Enviado';
            this.piStep3 = 'Token Não Validado Por Nº De Tentativas Excedidas';
            this.cssLimitExceed();
            this.resetTimer();
        }
    }

    handleSendToken() {
		sendToken({customerIntId: this.recordId, phoneNumber : this.phone})
		.then(result => {
            if(result.TokenStatus__c === 'Aguardando validação'){
                this.isTimerOn = true;
                this.startTimer();
                this.countAttempt = result.TokenSendAttempts__c;
                this.hasError = false;
                this.currentStep = '2';
                this.piStep1 = 'Token Enviado';
                this.piStep2 = 'Aguardando validação';
                this.cssWaitingApproval();

            } else{
                this.isEnviar = true;
                this.isCarregando = false;
                this.currentStep = '1';
                this.hasError = true;
                this.isTimerOn = false;
                this.piStep1 = 'Falha no envio';
                this.cssFailedSend();
            }
		})
		.catch(error => {
            this.handleUpdateTokenStatus('Falha no envio');
		})
	}

    handleCancelarToken(Event) {
        this.piStep1 = 'Token Enviado';
        this.piStep2 = '';
        this.piStep3 = 'Fluxo Cancelado';
        this.isTimerOn = false;
        this.currentStep = '3';
        this.hasError = true;
        this.cssTokenCancelled();
        this.disableAllScene();
        this.handleUpdateTokenStatus('Cancelado');
        this.resetTimer();
    }

    handleUpdateTokenStatus(ciStatus) {
        updateTokenStatus({customerIntId: this.recordId, tokenStatus: ciStatus});
    }

    disableAllScene() {
        this.isEnviar = false;
        this.isCancelarToken = false;
        this.isCarregando = false;
        this.isTimerOn = false;
    }

    resetTimer() {
        this.timer = '00:00';
        this.timeMiliseconds = this.systemTimeMs;
        clearInterval(this.timeIntervalInstance);
    }

    refreshData() {
        return refreshApex(this.returnValue);
    }

    cssWaitingApproval(){
        this.piStep1Classname = ' aguardandoValidacaoStep1';
        this.piStep2Classname = ' aguardandoValidacaoStep2';
        this.piStep3Classname = ' aguardandoValidacaoStep3';
    }

    cssValidatedToken(){
        this.piStep1Classname = ' tokenValidadoStep1';
        this.piStep2Classname = ' tokenValidadoStep2';
        this.piStep3Classname = ' tokenValidadoStep3 ';
        this.cssFinalStep = ' slds-hide';
    }

    cssLimitExceed(){
        this.piStep1Classname = ' tokenLimitExceedStep1';
        this.piStep2Classname = ' tokenLimitExceedStep2';
        this.piStep3Classname = ' tokenLimitExceedStep3 ';
        this.cssMedStep = ' slds-hide ';
    }

    cssTokenNoValidated(){
        this.piStep1Classname = ' tokenNoValidatedStep1';
        this.piStep2Classname = ' tokenNoValidatedStep2';
        this.piStep3Classname = ' tokenNoValidatedStep3 ';
    }

    cssTokenCancelled(){
        this.piStep1Classname = ' tokenCanceledStep1';
        this.piStep2Classname = ' tokenCanceledStep2';
        this.piStep3Classname = ' tokenCanceledStep3 ';
        this.cssMedStep = ' slds-hide ';
    }

    cssFailedSend(){
        this.piStep1Classname = ' tokenFailedSendStep1';
    }
    
    get step1Classname(){
        return this.initialPiStep1Classname + this.piStep1Classname;
    }

    get step2Classname(){
        return this.initialPiStep2Classname + this.piStep2Classname;
    }

    get step3Classname(){
        return this.initialPiStep3Classname + this.piStep3Classname;
    }

    get cssFinalStep(){
        return this.cssFinalStep;
    }
    
    registerPubSub() {
        this.handleEventObj = {
            assetUpdateFinished : this.handleEventAction.bind(this)
        };

        pubsub.register("updatedata", this.handleEventObj);
    }

    handleEventAction(actionObj, index, event) {
        this.refreshData();
        this.showPhone = true;
    }

    isNotEndedStatus(result) {
        return result.data.tokenStatus != 'Cancelado' && 
        result.data.tokenStatus != 'Validado' && 
        result.data.tokenStatus != 'Não validado';
    }
}
