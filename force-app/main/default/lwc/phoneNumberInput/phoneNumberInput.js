import { LightningElement, api, track } from 'lwc';
import pubsub from "vlocity_cmt/pubsub";

export default class PhoneNumberInput extends LightningElement {
    @api telefone
    @api fieldLabel
    @api phone
    @api messageWhenMaskIncomplete
    @api eventName
    maxLength = 15;
    value = '';
    hasSetupDefaultNumber = false;

    renderedCallback() {
        if (this.phone != undefined && this.phone != null && this.hasSetupDefaultNumber != true) {
            this.value = this.phoneMask(this.phone.toString());
            this.hasSetupDefaultNumber = true;
            pubsub.fire("PhoneNumberInput", this.eventName, { number: this.getCleanedPhoneNumber(this.value)});
        }
    }
    handleblur() {
        pubsub.fire("PhoneNumberInput",this.eventName, { number: this.telefone });
    }

    handlePhone(event) 
	{
        let input = event.target;
        input.value = this.phoneMask(input.value);		
        this.value = input.value;
        this.telefone = this.getCleanedPhoneNumber(input.value);
    }

    phoneMask(value) {
        if (!value) return "";
        value = value.replace(/\D/g, '');
        value = value.replace(/(\d{2})(\d)/, "($1) $2");
        value = value.replace(/(\d)(\d{4})$/, "$1-$2");
        return value;
    }
    getCleanedPhoneNumber(phoneWithMask) 
	{
        let cleanedValue = phoneWithMask.replace(/\s/g, ''); // Remove espaços em branco
        cleanedValue = cleanedValue.replace(/\D/g, ''); // Remove caracteres não numéricos
        return cleanedValue;
    }
	
	handlePaste(event) 
	{
        //Evita o comportamento de colagem padrão
		event.preventDefault(); 

        const clipboardData = event.clipboardData || window.clipboardData;
        let pastedText = clipboardData.getData('text/plain');
		
        //Limita o texto colado a 15 caracteres
        pastedText = this.formatPhoneNumber(pastedText);

        //Insere o texto colado no campo de entrada
        this.insertTextIntoInput(pastedText);
    }
	
	insertTextIntoInput(text) 
	{
        const inputField = this.template.querySelector('lightning-input');
        inputField.value = text;
        inputField.dispatchEvent(new CustomEvent('change')); // Dispara o evento change para atualizar o valor
    }
	
	 formatPhoneNumber(phoneNumber) 
	 {
        //Remove todos os caracteres não numéricos
        phoneNumber = phoneNumber.replace(/\D/g, '');

        //Aplica o formato "(11) 97469-8310"
        phoneNumber = phoneNumber.replace(/^(\d{2})(\d{5})(\d{4}).*/, '($1) $2-$3');

        //Limita a 15 caracteres
        return phoneNumber.substring(0, 15);
    }	
}