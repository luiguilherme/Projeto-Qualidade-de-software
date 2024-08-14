import { LightningElement, track, api } from 'lwc';
import findCustomerInteractions from "@salesforce/apex/CustomerInteractionControl.findCustomerInteractions";
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import Type from '@salesforce/schema/Account.Type';

export default class CustomerInteractionDataTable extends LightningElement {
    columns = [
        { label: 'Instância', fieldName: 'instanceProduct' },
        { label: 'Protocolo', fieldName: 'protocolNumber'},
        { label: 'Palito', fieldName: 'palito', wrapText:true},
        { label: 'Criado em', fieldName: 'creationDate',type: 'date'},
        { label: 'Notas', fieldName: 'notas'}
    ];
           
    @api customerAccountId ;
    @api instanceProduct;
    @track inputStartDate;
    @track inputEndDate;
    @track inputsVazios = true;
    @track data = [];
    @track pagedData = [];
    @track currentPage = 1;
    @track displayAmount = 10;
    displayTable;
    displayError;
    errorMessageDisplay;

    get isFirstPage() {
        return this.currentPage === 1;
    }

    get isLastPage() {
        if(!this.data.length) {
            return true;
        }
        return this.currentPage === Math.ceil(this.data.length / this.displayAmount);
    }

    get totalPages() {
        return Math.ceil(this.data.length / this.displayAmount);
    }

    connectedCallback() {
        this.inputsVazios = true;
    }

    handleCustomerInteractions() {
        this.data = [];
        this.displayError = false;
        this.displayTable = false;
        let response = '';
        const startDate = this.template.querySelector('.start-date').value;
        const endDate = this.template.querySelector('.end-date').value;

        this.inputStartDate = startDate || null;
        this.inputEndDate = endDate || null;
       
        const isValidStartDate = this.isEndDateGreaterThanStartDate(startDate, endDate);
        const isValidPeriod = this.isDifference90Days(startDate, endDate);
        
        if (!startDate || !endDate) {
            this.errorMessageDisplay='Atenção ! É necessário ao menos informar um período para consulta';
            this.displayError = true;
            return;
        } else if(isValidStartDate){
            this.errorMessageDisplay='Atenção ! A data final não pode ser menor do que a data inicial';
            this.displayError = true;
            return;   
        } else if(isValidPeriod){
            this.errorMessageDisplay='Selecione um período máximo de 90 dias corridos';
            this.displayError = true;
            return;

        }

        if(this.customerAccountId && this.instanceProduct && this.inputStartDate && this.inputEndDate){

            findCustomerInteractions({idCustomer: this.customerAccountId, startOpeningDate:this.inputStartDate, endOpeningDate:this.inputEndDate}).then((result)=>{
                   
                if(result == ''){
                    this.errorMessageDisplay='Não foram encontradas Interações para a data selecionada!';
                    this.displayError = true;
                    this.displayTable = false;
                    this.inputsVazios = true;
                } else {
                    result.forEach(customerInteraction => {
                        console.log('Customer Interacation');
                        console.log(customerInteraction);
                        let returnedData ={};
                        returnedData.instanceProduct = this.instanceProduct || '';
                        returnedData.protocolNumber = customerInteraction.protocol?.protocolNumber || '';
                        returnedData.palito = '';
						
						if (customerInteraction.items 
							&& Array.isArray(customerInteraction.items) 
							&& customerInteraction.items.length > 0) {
								
							customerInteraction.items.forEach(item => {
								returnedData.palito = returnedData.palito + item.reasonLevel1 + ' > ' + item.reasonLevel2 + ' > ' + item.reasonLevel1 + '\n';
							});
						}
						
                        returnedData.creationDate = customerInteraction.creationDate || '';
                        console.log(returnedData.creationDate)
                        returnedData.notas = customerInteraction.notesX9 || '';
                        
                        this.data.push(returnedData);
                    });
                
                    this.currentPage = 1;
                    this.pagedData = this.data.slice(0, 10);
                    this.updatePagedData();
                    this.displayTable = true;
                    this.inputsVazios = false;
                }
            }).catch(()=>{
                    this.errorMessageDisplay='Não foram encontradas Interações para a data selecionada!';
                    this.displayError = true;
                    this.displayTable = false;
                    this.inputsVazios = true;                
            });           
        } else{
            this.errorMessageDisplay='Não foram encontradas Interações para a data selecionada!';
            this.displayError = true;
            this.displayTable = false;
        }


    }

    updatePagedData() {
        const start = (this.currentPage - 1) * this.displayAmount;
        const end = this.currentPage * this.displayAmount;
        this.pagedData = JSON.parse(JSON.stringify(this.data.slice(start, end)));
    }

    isDifference90Days(startDate, endDate) {
        const start = new Date(startDate);
        const end = new Date(endDate);
        const differenceInTime = Math.abs(end - start);
        const differenceInDays = differenceInTime / (1000 * 3600 * 24);
        return differenceInDays > 90;
    }

    isEndDateGreaterThanStartDate(startDate, endDate) {
        const start = new Date(startDate);
        const end = new Date(endDate);
        return start > end;
    }

    showToast(title, message, variant) {
        const event = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant,
        });
        this.dispatchEvent(event);
    }

   
}