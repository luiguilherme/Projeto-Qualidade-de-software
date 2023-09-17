import { LightningElement, track, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { OmniscriptBaseMixin } from "vlocity_cmt/omniscriptBaseMixin";
import { getNamespaceDotNotation } from "vlocity_cmt/omniscriptInternalUtils";
import pubsub from "vlocity_cmt/pubsub";

export default class RechargeVoucher extends OmniscriptBaseMixin(LightningElement) {

    @api spinner = false;  
    @track passNumber = '';
    @track reason = '';  
    @track comments = '';
    @track passLst = [];
    @track numberString = '';
    @track admNumber = '';
    @track brokenReason = '';      
    @track brokenValue = 1;
    @track isBroken = false;    
    @track result;

    messageError = '';

    reasonOptions = [
        { label: 'A Pedido do Cliente', value: 'Customer' },
        { label: 'Recarga Online Lojas Vivo', value: 'Store' }
    ];

    brokenOptions = [
        { label: 'Sim', value: 1, checked: false},
        { label: 'Não', value: 0, checked: true }
    ];

    _ns = getNamespaceDotNotation();

    get passLenght() {
        let count = 0;

        this.passLst.forEach(item => {
            if (item != '') count++;
        });

        return count;
    }

    connectedCallback() {
        pubsub.register('valRechargeVoucher', {
            ["closeSpinner"]: this.handleSpinner.bind(this)
        });
    }

    showToast(title, message, variant) {
        const event = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant
        });

        this.dispatchEvent(event);        
    }  

    handleSpinner() {
        this.spinner = !this.spinner;
    }

    handleChange(event) {
        const field = event.target.name;
        const value = event.target.value;
        
        switch(field) {
            case "passNumber":
                this.passNumber = value;
                break;
            case "reason":
                this.reason = value;
                break;
            case "comments":
                this.comments = value;
                break; 
            case "admNumber":
                this.admNumber = value;
                break;
            case "brokenReason":
                this.brokenReason = value;
                break;
            case "brokenComments":
                this.comments = value;
                break;                 
            case "broken":
                this.brokenValue = value;
                this.isBroken = value == 1 ? true : false;

                let brokenOptionsAux = this.brokenOptions;
                brokenOptionsAux.map((item)=>{
                    if (item.value == this.brokenValue) {                  
                        item.checked = true;                       
                    } else {
                        item.checked = false;
                    }
                    return item;
                });

                // Preencher campo Senha
                // if (this.isBroken && this.passLenght > 0) {
                //     let i = 1;
                //     this.passLst.forEach(item => {
                //         const input = this.template.querySelector(`[data-index="${i}",]`);
                //         input.value = item != '*' ? item : '';
                //         i++;
                //     });
                // }

                this.brokenOptions = brokenOptionsAux;
                this.handleFocus(event);
                break;                           
        }
        
    }   

    handleFocus(event) {

        const name = event.target.name;
        const elemCard = this.template.querySelector('.flip-card .flip-card-inner');
        const elemBoxLote = this.template.querySelector('.box-lote');
        const elemBoxAdmin = this.template.querySelector('.box-admin');

        if ((name == 'passNumber' || name == 'pass')) {
            
            const elemLoteNumber = this.template.querySelector('.lote-number');

            if (this.isBroken) {
                elemLoteNumber.innerHTML = this.numberString != '' ? this.numberString : '0000000000000';
            } else {
                elemLoteNumber.innerHTML = this.passNumber != '' ? this.passNumber : '0000000000000';
            }

            elemBoxAdmin.classList.remove('focus-border');
            elemBoxLote.classList.add('focus-border');

            if (!elemCard.classList.contains('flip')) elemCard.classList.add('flip');

        }
        
        if (name == 'admNumber') {

            const elemAdminNumber = this.template.querySelector('.admin-number');

            if (this.isBroken) {
                elemAdminNumber.innerHTML = this.admNumber != '' ? this.admNumber : '000000000000000'; 
            } else {
                elemAdminNumber.innerHTML = '000000000000000';
            }

            elemBoxLote.classList.remove('focus-border');
            elemBoxAdmin.classList.add('focus-border');

            if (!elemCard.classList.contains('flip')) elemCard.classList.add('flip');

        } 
        
        if (name != 'passNumber' 
            && name != 'pass' 
            && name != 'admNumber') {

            elemBoxAdmin.classList.remove('focus-border');
            elemBoxLote.classList.remove('focus-border');
            elemCard.classList.remove('flip');

        }
        
    }

    // responsável por não permitir digitar digitar teclas não numéricas.
    handleDigitKeyPress(event) {
        const allowedKeys = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
        if (!allowedKeys.includes(event.key)) {
            event.preventDefault();
        }
    }

    handlePass(event) {
        const digit = event.target.value;
        const maxLength = event.target.maxLength;
        const currentIndex = parseInt(event.target.dataset.index);
        
        if (digit.length >= maxLength) {
            const nextIndex = currentIndex + 1;
            const nextInput = this.template.querySelector(`[data-index="${nextIndex}"]`);
            
            if (nextInput) {
                nextInput.focus();
            }
        }
    
        this.handlePassLoteNumber(event);
    }

    // responsável por avançar e recuar com as setas e o espaço do teclado e utilizar o backspace para apagar os inputs
    handleDigitKeyDown(event) {
        const currentTarget = event.currentTarget;
        const currentIndex = parseInt(currentTarget.dataset.index, 10);
        const nextIndex = event.key === 'ArrowRight' || event.key === ' ' ? currentIndex + 1 : event.keyCode === 'ArrowLeft' ? currentIndex - 1 : null;

        if (nextIndex !== null) {
            event.preventDefault();
            const nextInput = this.template.querySelector(`lightning-input[data-index="${nextIndex}"]`);
            if (nextInput) {
                nextInput.focus();
            }
        } else if (event.key === 'Backspace' && currentTarget.value === '' && currentIndex > 0) {
            const previousIndex = currentIndex - 1;
            const previousInput = this.template.querySelector(`lightning-input[data-index="${previousIndex}"]`);
            if (previousInput) {
                previousInput.focus();
            }
        }

        this.handlePassLoteNumber(event);
    }    

    handlePassLoteNumber(event) {

        const index = event.target.dataset.index;
        const digit = event.target.value;
        const elemLoteNumber = this.template.querySelector('.lote-number');

        this.passLst[index] = digit;
        this.numberString = '';

        for (let i = 0; i < 13; i++) {
            const currentDigit = this.passLst[i] || '*';
            this.numberString += currentDigit;
        }

        this.numberString = this.numberString != '*************' ? this.numberString : '';
        elemLoteNumber.innerHTML = this.numberString != '' ?  this.numberString : '0000000000000';
        
        if (digit === '') this.passLst[index] = '';
    }

    handlePassNumber(event) {
        const value = event.target.value;
        const elemLoteNumber = this.template.querySelector('.lote-number');

        if (isNaN(value)) {
            event.preventDefault();
            this.passNumber = value.replace(/[^0-9]/g, '');
        }

        elemLoteNumber.innerHTML = this.passNumber;
    }

    handleAdminNumber(event) {
        const value = event.target.value;
        const elemAdminNumber = this.template.querySelector('.admin-number');

        if (isNaN(value)) {
            event.preventDefault();
            this.admNumber = value.replace(/[^0-9]/g, '');
        }

        elemAdminNumber.innerHTML = this.admNumber;
    }
    
    handleBtnRecharge() {

        this.spinner = true;
        if (this.isBroken) this.validateIsBroken();
        else this.validateIsNotBroken();

    }

    validateIsBroken() {
        if (this.passLenght > 2 && this.admNumber.length == 16 
            && this.brokenReason != '' && this.passLenght >= 3) {
                this.validateRecharge();
        } else this.handleValidation();
    }

    validateIsNotBroken() {
        if (this.passNumber.length == 13 && this.reason != '') {
            this.validateRecharge();
        } else this.handleValidation();
    }

    handleValidation() {

        const fields = this.template.querySelectorAll('lightning-input, lightning-combobox');
        if(fields) fields.forEach(field => field.reportValidity());

        if (this.isBroken && this.passLenght < 3) this.messageError = 'Pelo menos 3 dígitos devem ser preenchidos';
        else this.messageError = '';

        this.spinner = false;
    }

    validateRecharge() {

        this.messageError = '';
        
        if (this.isBroken) {
            this.omniJsonDataStr = {
                "IsBroken": this.isBroken,           
                "HashCode": String(this.numberString),     
                "SerialNumber": String(this.admNumber),
                "OrderNumber": String(this.numberString)
            };
        } else {
            this.omniJsonDataStr = {
                "IsBroken": this.isBroken,           
                "HashCode": String(this.passNumber),
                "Spinner": Boolean(this.spinner)
            };
        }

        pubsub.fire(
            "valRechargeVoucher", 
            "ValidateRecharge", 
            this.omniJsonDataStr
        );

    }

    handleBtnCancel() {
        pubsub.fire("valSelectOptionRecharge", "return", {});
    }
}