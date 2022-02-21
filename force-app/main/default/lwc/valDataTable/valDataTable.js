import { LightningElement,api } from 'lwc';

import {
    OmniscriptBaseMixin
} from 'vlocity_cmt/omniscriptBaseMixin';

import pubsub from 'vlocity_cmt/pubsub';

let columns = [    
    { label: 'CEP', fieldName: 'CEP',hideDefaultActions: 'true'},
    { label: 'Estado', fieldName: 'Estado',hideDefaultActions: 'true'},
    { label: 'Cidade', fieldName: 'Cidade',hideDefaultActions: 'true'},
    { label: 'Bairro', fieldName: 'Bairro',hideDefaultActions: 'true'},
    { label: 'Logradouro', fieldName: 'Logradouro',hideDefaultActions: 'true'},
    { label: 'Numeração', fieldName: 'Numeracao',hideDefaultActions: 'true'},
    { label: 'Lado', fieldName: 'Lado',hideDefaultActions: 'true'},
    { label: 'Tipo de Logradouro', fieldName: 'TipoLogradouro',hideDefaultActions: 'true'},
];

export default class ValDataTable extends OmniscriptBaseMixin(LightningElement) {
    isLoaded = false;
    selectedRows = [];
    addresses = [];
    
    preSelectedRows = [];
    data = [];
    columns = columns;

    @api keyField;
    
    @api 
    get displayAmmount() {
        return this._displayAmmount
    };     
    set displayAmmount(value) {
        this._displayAmmount = value;
        this.gotoPage(1);
    }
    _displayAmmount;
 
    @api 
    get sourceData() { 
        return this._sourceData 
    };        
    set sourceData(value) { 
        this._sourceData = value;
        this.gotoPage(1);
    }
    _sourceData;        

    pagedData;          
    currentPage = 1;
    maxPages = 1;

    disabledPreviousButton = false;
    disabledNextButton = false;
    loading = false;

    @api 
    resetPaging() {

        this.gotoPage(1);
    }
   
    connectedCallback() {
        //this.sourceData = this.omniJsonData.addresses;
        this.displayAmmount = 7;   
        
        pubsub.register('omniscript_action', {
            data: this.handleOmniAction.bind(this),
        });        
    }

    handleOmniAction(data) {
        this.sourceData = data.addresses;
        this.addresses = data.addresses;
        this.displayAmmount = 7;  
        this.isLoaded = data.isLoaded; 
    }

    handleSelection(event) {
        this.selectedRows = event.detail.selectedRows; 
        this.omniUpdateDataJson(this.selectedRows[0]);
    }

    handleButtonNext() {

        var nextPage = this.currentPage + 1;
        var maxPages =  this.getMaxPages();

        if(nextPage > 0 && nextPage <= maxPages) {

            this.gotoPage(nextPage);
        }
    }

    handleButtonPrevious() {

        var nextPage = this.currentPage - 1;
        var maxPages =  this.getMaxPages();

        if(nextPage > 0 && nextPage <= maxPages) {

            this.gotoPage(nextPage);
        }
    }
    
    handleKeyChange( event ) {        
        this.searchKey = event.target.value;
        this.sourceData = this.addresses.filter(function (address) {


            return JSON.stringify(address.Logradouro).toLowerCase().includes(event.target.value.toLowerCase()) ||
            JSON.stringify(address.Bairro).toLowerCase().includes(event.target.value.toLowerCase());
          });                                   
    }    

    getMaxPages() {

        var result = 1;        
        var arrayLength;
        var divideValue;

        if(this._sourceData) {

            arrayLength = this._sourceData.length;
            divideValue = arrayLength / this.displayAmmount;
            result = Math.ceil(divideValue); 
            
        }
        
        if(result > 0){
            this.maxPages = result;
        }
        else{
            this.maxPages = 1;
            result = 1;
        }

        return result;
    }

    emptyData(){
        console.log("this.sourceData.length "+this.sourceData.length);
        if(this.getMaxPages() === 1)
        {
            return true;
        }
        else
        {
            return false;
        }
    }

    gotoPage(pageNumber) {
        var recordStartPosition, recordEndPosition;
        var i, arrayElement;
        var maximumPages = this.maxPages;
        this.loading = true;

        maximumPages = this.getMaxPages();

        /*if( pageNumber > maximumPages || pageNumber < 0 ) {
            this.loading = false;
            return;
        }*/

        this.disabledPreviousButton = false;
        this.disabledNextButton = false;
        
        //console.log("this._sourceData.length "+this.sourceData.length);
        if(this._sourceData) {
            this.pagedData = [];
            
            recordStartPosition = this.displayAmmount * (pageNumber - 1);
            recordEndPosition = recordStartPosition + parseInt(this.displayAmmount, 10);

            for ( i = recordStartPosition; i < recordEndPosition; i++ ) {

                arrayElement = this._sourceData[i];

                if(arrayElement) {

                    this.pagedData.push(arrayElement);
                }
            }            
            this.currentPage = pageNumber;
            if(maximumPages === this.currentPage) {
                
                this.disabledNextButton = true;
            }

            if(this.currentPage === 1) {

                this.disabledPreviousButton = true;
            }
                        
            if(this.selectedRows.length > 0){                
                this.preSelectedRows = [];
                this.preSelectedRows.push(this.selectedRows[0].Id);
            }
            
            if(this.preSelectedRows.length > 0){
                this.template.querySelector(
                    '[data-id="datarow"]'
                  ).selectedRows = this.preSelectedRows;
            }
            
            this.loading = false;
        }
    }
}