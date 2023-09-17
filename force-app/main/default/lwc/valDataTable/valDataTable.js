import { LightningElement, api } from 'lwc';
import { OmniscriptBaseMixin } from "vlocity_cmt/omniscriptBaseMixin";
import { getNamespaceDotNotation } from "vlocity_cmt/omniscriptInternalUtils";
import pubsub from "vlocity_cmt/pubsub";

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
    hasDataFilter = false;
    selectedRows = [];
    addresses = [];
    numberOfPages = 0;
    page = 0;
    cep = "";
    searchGroup = "";
    state = "";
    city = "";
    street = "";
    searchType = "";
    exactMatch = false;
    limit = 10;
    lastpage = 0;
    
    preSelectedRows = [];
    data = [];
    columns = columns;

    @api cName;
    @api isLoaded = false;
    @api 
    get displayAmmount() {
        return this._displayAmmount
    };     
    set displayAmmount(value) {
        this._displayAmmount = value;
        //this.gotoPage(1);
    }
    _displayAmmount;
 
    @api 
    get sourceData() { 
        return this._sourceData 
    };        
    set sourceData(value) { 
        
        this._sourceData = value;
        if(this.hasDataFilter){
           this.gotoPageFilter(1);
           this.hasDataFilter = false;
        }
    }
    _sourceData;     
    componentType;

    /**
     * @description Getter para atribuir o valor de _ns dependendo da variável componentType
     * @author carlosaraujo@deloitte.com
     * @date 27/12/2022
    */
    get _ns () {
        if (this.componentType == 'FlexCard') {
            return 'vlocity_cmt.';
        } 
        return getNamespaceDotNotation();
    }

    pagedData;
    currentPage = 1;
    maxPages = 1;

    disabledPreviousButton = true;
    disabledNextButton = true;
    loading = false;

    @api 
    resetPaging() {
        this.gotoPage(1);
    }

    connectedCallback() {
        this.displayAmmount = 10;   
        
        pubsub.register('omniscript_action', {
            data: this.handleOmniAction.bind(this),
        });        
        
        pubsub.register('valMonthlySchedule', {
            ["searchAddress"]: this.handleSearchAddress.bind(this)
        });

        pubsub.register('valMonthlySchedule', {
            ["selectAddress"]: this.handleBtnSelection.bind(this)
        });
    }

    /**
     * @description Método chamado pelo FlexCard
     * @author carlosaraujo@deloitte.com
     * @date 27/12/2022
    */
    handleSearchAddress(data) {
        console.log('handleSearchAddress');

        this.isLoaded = false;
        this.componentType  = 'FlexCard';
        this.cName          = 'main';
        this.hasDataFilter  = true;
        this.page           = Number(data.page);              
        this.cep            = data.cep;
        this.searchGroup    = data.searchGroup;
        this.state          = data.state;
        this.city           = data.city;
        this.street         = data.street;
        this.searchType     = data.searchType;
        this.exactMatch     = Boolean(data.exactMatch);
        this.limit          = Number(data.limit);
        this.displayAmmount = 10;

        this.omniJsonDataStr = {
            "isLoaded"      : true,
            "SearchType"    : this.searchType,
            "Street"        : this.street,
            "City"          : this.city,
            "State"         : this.state,
            "SearchGroup"   : this.searchGroup,
            "CEP"           : this.cep,
            "pagination"    : this.page,
            "exactMatch"    : Boolean(this.exactMatch),
            "limit"         : Number(this.limit),
            "ComponentType" : this.componentType
        };

        console.log(this.omniJsonDataStr);

        const params = {
            input           : this.omniJsonDataStr,
            sClassName      : `${this._ns}IntegrationProcedureService`,
            sMethodName     : 'val_GetAddressByCEP',
            options         : '{}',
        };

        this.omniRemoteCall(params, true)
            .then(result => {
                this.addresses     = result.result.IPResult.Main.Addresses;                    
                this.sourceData    = result.result.IPResult.Main.Addresses;  
                this.numberOfPages = result.result.IPResult.Main.paginationTotal;
                this.maxPages      = this.numberOfPages;

                if(this.maxPages  === this.page) {
                    this.disabledNextButton = true;
                }else {
                    this.disabledNextButton = false;
                }

                if(this.page === 1) {
                    this.disabledPreviousButton = true;
                }else{
                    this.disabledPreviousButton = false;
                }
            })
            .catch(erro => {
                console.error(erro);
            })
            .finally(() => {
                this.isLoaded = Boolean(data.isLoaded);
            });
    }

    handleOmniAction(data) {  
        
        if(this.cName == data.tableName)
        {
            /*
            console.log("--- Parameters     handleOmniAction ---");
            console.log("1. SearchType     : " + this.searchType);
            console.log("2. Street         : " + this.street);
            console.log("3. City           : " + this.city);
            console.log("4. State          : " + this.state);
            console.log("5. SearchGroup    : " + this.searchGroup);
            console.log("6. CEP            : " + this.cep);
            console.log("7. paginationPage : " + pageNumber);
            console.log("8. exactMatch     : " + this.exactMatch);
            console.log("9. limit          : " + this.limit);
            console.log("handleOmniAction-> data.numberOfPages:"+ data.numberOfPages);
            console.log("handleOmniAction-> page:"+ this.page);
            console.log("handleOmniAction-> data:"+ JSON.stringify(data.addresses));            
            console.log("----------------------------------------");  
            */
            this.hasDataFilter = true;

            
            this.isLoaded       = data.isLoaded; 
            this.numberOfPages  = data.numberOfPages;
            this.page           = data.page;              
            this.maxPages       = this.numberOfPages;
            this.cep            = data.cep;
            this.searchGroup    = data.searchGroup;
            this.state          = data.state;
            this.city           = data.city;
            this.street         = data.street;
            this.searchType     = data.searchType;
            this.exactMatch     = data.exactMatch;
            this.limit          = data.limit;
            this.displayAmmount = 10;

            this.addresses      = data.addresses;
            console.log("this.addresses fim"+this.addresses);  
            this.sourceData     = data.addresses;
            console.log(" this.sourceData fim"+ this.sourceData);  

            //this.gotoPage(1);
        }

        
    }

    handleSelection(event) {
        this.selectedRows = event.detail.selectedRows; 
        if (this.componentType != 'FlexCard') this.omniUpdateDataJson(this.selectedRows[0]);
    }

    handleBtnSelection(data) {
        if (this.componentType == 'FlexCard') {
            const params = {
                "MainIBGECode"     : this.selectedRows[0].IBGE,
                "MainCEP"          : this.selectedRows[0].CEP,
                "MainState"        : this.selectedRows[0].Estado,
                "MainCity"         : this.selectedRows[0].Cidade,
                "MainNeighborhood" : this.selectedRows[0].Bairro,
                "MainAddressType"  : this.selectedRows[0].TipoLogradouro,
                "MainAddress"      : this.selectedRows[0].Logradouro,
                "MainCountry"      : "Brasil"
            }

            pubsub.fire("valCreateMontlySchedule", "getMainAddress", params);
        }
    }

    handleButtonNext() {
        var nextPage = this.currentPage + 1;
        var maxPages =  this.getMaxPages();

        if(nextPage > 0 && nextPage <= maxPages) {
            this.disabledPreviousButton = true;
            this.disabledNextButton = true;               
            this.gotoPage(nextPage);
        }
    }

    handleButtonPrevious() {

        var nextPage = this.currentPage - 1;
        var maxPages =  this.getMaxPages();

        if(nextPage > 0 && nextPage <= maxPages) {
            this.disabledPreviousButton = true;
            this.disabledNextButton = true;
            this.gotoPageFilter(nextPage);
        }
    }
    
    getMaxPages() {
        return this.numberOfPages;
    }

    emptyData(){        
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

        console.log('GoToPage -> this.lastpage :' + this.lastpage);
        console.log('GoToPage -> pageNumber :'+ pageNumber);

        this.isLoaded = false;
        maximumPages = this.getMaxPages();    

        this.omniJsonDataStr = {
            "isLoaded": true,
            "SearchType": this.searchType,
            "Street": this.street,
            "City": this.city,
            "State": this.state,
            "SearchGroup": this.searchGroup,
            "CEP": this.cep,
            "pagination": pageNumber,
            "exactMatch": this.exactMatch,
            "limit": this.limit
        };

        const params = {
            input: this.omniJsonDataStr,
            sClassName: `${this._ns}IntegrationProcedureService`,
            sMethodName: 'val_GetAddressByCEP',
            options: '{}',
        };

        var self = this;   
        this.omniRemoteCall(params, true).then(result => {
            if(this.cName == "main"){
                this.lstReturn = result.result.IPResult.Main.Addresses;                    
            }else{
                this.lstReturn = result.result.IPResult.Shipping.Addresses;                    
            }        
                
            this.pagedData = [];        

            var totElements = 0;
            if(this._sourceData!=undefined){
                totElements = this._sourceData.length;            
            }else{
                this._sourceData = [];
                this.addresses = [];
            }
            // usado para carregar elementos que foram carregados no array
            recordStartPosition = this.displayAmmount * (pageNumber - 1);            
            recordEndPosition = recordStartPosition + this.displayAmmount;                    

            let ir=0;
            for ( i = recordStartPosition; i < recordEndPosition ; i++ ) {

                this._sourceData[i] = this.lstReturn[ir];
                this.addresses[i] = this.lstReturn[ir];
                let arrayElement = this._sourceData[i];
                ir++;

                if(arrayElement) {
                    this.pagedData.push(arrayElement);
                }
            }             

            this.currentPage = pageNumber;
            if(maximumPages === this.currentPage) {
                this.disabledNextButton = true;
            }else {
                this.disabledNextButton = false;
            }

            if(this.currentPage === 1) {
                this.disabledPreviousButton = true;
            }else{
                this.disabledPreviousButton = false;
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
            this.lastpage = pageNumber;
            this.isLoaded = true;

            }).catch(error => {
                //console.log('error: ' + error);
                this.isLoaded = true;                
            })
            .finally(()=>{
            });            
    }

    handleKeyChange(event) {
        this.searchKey = event.target.value;
        let tam = 0;
        tam = event.target.value.length;
        this.hasDataFilter = true;

        this.sourceData = this.addresses.filter(function (address) {
            return JSON.stringify(address.Logradouro).toLowerCase().includes(event.target.value.toLowerCase()) ||
            JSON.stringify(address.Bairro).toLowerCase().includes(event.target.value.toLowerCase());
          });                                   
    }    

    gotoPageFilter(pageNumber) {
        var recordStartPosition, recordEndPosition;
        var i, arrayElement;
        var maximumPages = this.maxPages;
        this.isLoaded = false;

        maximumPages = this.getMaxPages();

        /*if( pageNumber > maximumPages || pageNumber < 0 ) {
            this.loading = false;
            return;
        }*/

        this.disabledPreviousButton = false;
        this.disabledNextButton = false;
        
        if(this._sourceData) {
            this.pagedData = [];
            
            recordStartPosition = this.displayAmmount * (pageNumber - 1);            
            recordEndPosition = recordStartPosition + this.displayAmmount;

            for ( i = recordStartPosition; i < recordEndPosition; i++ ) {

                arrayElement = this._sourceData[i];

                if(arrayElement) {

                    this.pagedData.push(arrayElement);
                }
            }            
            this.currentPage = pageNumber;

            if(maximumPages === this.currentPage) {
                this.disabledNextButton = true;
            }else {
                this.disabledNextButton = false;
            }

            if(this.currentPage === 1) {
                this.disabledPreviousButton = true;
            }else{
                this.disabledPreviousButton = false;
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
        }
        this.isLoaded = true;        

    }    
}