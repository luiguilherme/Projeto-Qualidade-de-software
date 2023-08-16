import { LightningElement, api, wire, track } from 'lwc';
import getCustomerIntAPX from '@salesforce/apex/PIDTokenValidateController.getCustomerIntAPX';
import updateTokenStatus from '@salesforce/apex/PIDTokenValidateController.updateTokenStatus';
import sendToken from '@salesforce/apex/PIDTokenValidateController.sendToken';
import { refreshApex } from "@salesforce/apex";

export default class PidTokenValidate extends LightningElement {
    @api recordId;
    phone;    
    @track returnValue;
    status;
    showTokenScreen = false;
    showComponent = false;
    hasError = false;
    showPath = false;
    currentStep = 1;
    screenStatus;

    // Buttons
    isEnviar = false;
    isCancelarToken = false;
    isCarregando = false;

    // Progress Indicator
    piStep1 = 'Enviando Token...';
    piStep2 = 'Token enviado';
    piStep3 = 'Aguardado validação...';
    piStep4 = 'Token validado';

    // Timer
    isTimerOn = false;
    @track timer = '00:00';
    timeMiliseconds;
    systemTimeMs;
    timeIntervalInstance;

    // Counter
    countAttempt;
    maxCountAttempts;

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
                    this.phone = 'Não possui linha válida'; 
                    this.disableAllScene();
                } else {
                    this.phone = result.data.phone;
                    this.maxCountAttempts = result.data.attempts;
                    this.countAttempt = result.data.tokenSendAttempts;
    
                    if (result.data.tokenStatus != 'Cancelado' 
                            && result.data.tokenStatus != 'Validado' 
                            && result.data.tokenStatus != 'Não validado' 
                            && this.countAttempt <= this.maxCountAttempts
                            && this.isCarregando == false ) {
                        this.isEnviar = true;
                    } else {
                        this.disableAllScene();
    
                        if(result.data.tokenStatus === 'Cancelado') {
                            this.screenStatus = 'Fluxo cancelado'; 
                            this.showPath = true;
                            this.currentStep = '1';
                            this.hasError = true;
                        } else if(result.data.tokenStatus === 'Validado') {
                            this.screenStatus = 'Token validado com sucesso!'; 
                            this.showPath = true;
                            this.currentStep = '4';
                            this.resetTimer();
                        } else if(this.countAttempt >= this.maxCountAttempts && result.data.tokenStatus != 'Aguardando validação'  ) {
                            this.screenStatus = 'Token não validado e o máximo de tentativas foi excedido.'; 
                            this.showPath = true;
                            this.currentStep = '1';
                            this.hasError = true;
                        } else if(result.data.tokenStatus === 'Não validado' && this.countAttempt < this.maxCountAttempts) {
                            this.screenStatus = 'Token não validado. Envie novamente.'; 
                            this.isEnviar = true;
                            this.showPath = true;
                            this.currentStep = '1';
                            this.hasError = true;
                        } else if(result.data.tokenStatus === 'Aguardando validação'){
                            this.screenStatus = 'Aguardando validação do cliente.';
                            this.isEnviar = false;
                            this.showPath = true;
                            this.currentStep = '3';
                            this.hasError = false;
                            this.isCancelarToken = true;
                            this.isCarregando = true;
                            this.isTimerOn = true;
                            this.countAttempt = result.data.tokenSendAttempts;
                        } else if(result.data.tokenStatus === 'Falha na comunicação API'){
                            this.screenStatus = 'Erro na validação do Token, tente novamente.'; 
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
                    parentThis.screenStatus = 'Token não validado e o máximo de tentativas foi excedido.'; 
                    parentThis.showPath = true;
                    parentThis.currentStep = '1';
                    parentThis.hasError = true;
                } else {
                    parentThis.isEnviar = true;
                    parentThis.isCarregando = false;
                    parentThis.screenStatus = 'Token não validado. Envie novamente.';
                    parentThis.hasError = true;
                }
                parentThis.handleUpdateTokenStatus('Não validado');
            }

            parentThis.refreshData();
            parentThis.timeMiliseconds -= 1000;
            this.resetTimer();
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
        this.screenStatus = 'Enviando Token...';

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
            this.screenStatus = 'Token não validado e o máximo de tentativas foi excedido.';
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
                this.currentStep = '3';
                this.screenStatus = 'Aguardando validação do cliente.';
                
            } else{
                this.isEnviar = true;
                this.isCarregando = false;
                this.currentStep = '2';
                this.hasError = true;
                this.isTimerOn = false;
                this.screenStatus = 'Não foi possível realizar o envio, tente novamente.';
            }
		})
		.catch(error => {
            this.handleUpdateTokenStatus('Falha no envio');      
		})
	}

    handleCancelarToken(Event) {
        this.isTimerOn = false; 
        this.currentStep = '1';
        this.hasError = true;
        this.screenStatus = 'Fluxo cancelado. Para realizar a validação realize um novo atendimento.';
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
}