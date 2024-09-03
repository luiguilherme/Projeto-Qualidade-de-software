import { LightningElement, track, api } from 'lwc';
import { OmniscriptBaseMixin } from 'vlocity_cmt/omniscriptBaseMixin'; 
import { getNamespaceDotNotation } from "vlocity_cmt/omniscriptInternalUtils";
import { OmniscriptActionCommonUtil } from "vlocity_cmt/omniscriptActionUtils";

const chargeCodes = ['RCMBASICFUNCMP','RCOBASICFUNCMP','RMBASICFUNCMP'];

const columns1 = [
    { label: 'Número', fieldName: 'invoiceNumber', type: 'text' },
    { label: 'Conta pós paga', fieldName: 'billingAccountId', type: 'text' }, //Exibe o valor de billingAccountId
    { label: 'Período de apuração', fieldName: 'Entrega2_Periodo', type: 'text' },
    { label: 'Data de vencimento', fieldName: 'paymentDueDate', type: 'text' },
    { label: 'Baixa', fieldName: 'Entrega2_Baixa', type: 'text' },
    { label: 'Valor', fieldName: 'amount', type: 'currency' },
    { label: 'Ajustes', fieldName: 'Entrega2_Ajustes', type: 'text' },
    { label: 'Pagamento', fieldName: 'Entrega2_Pagamento', type: 'text' },
    { label: 'Saldo', fieldName: 'balance', type: 'currency' },
];

const columns2 = [
    { label: 'Instância/Produto', fieldName: 'Instance' },
    { label: 'Descrição', fieldName: 'codeDescription' },
    { label: 'Valor', fieldName: 'totalAmount', type: 'currency' },
    { label: 'Ajustes', fieldName: 'adjustments', type: 'currency' },
    { label: 'Descontos', fieldName: 'discount', type: 'currency' },
    { label: 'Valor Atual', fieldName: 'availableAmount', type: 'currency' },
];

export default class disputeFixedInvoicesDataTable extends OmniscriptBaseMixin(LightningElement) {
    //Só será recebido o ServiceIdentifier como parametro
    @api serviceIdentifier;
    @api allSelections;
    @api isColab = false;
    @api haveDiscount = false;
    //Variáveis que eram recebidas agora vão ser recuperadas
    // dentro do LWC em uma chamada para IP IPInvoiceDisputeIntegration
    @track invoicesApi = [];
    @track generalSetting = [];
    @track accountId = '';

    @track filteredInvoices = [];
    @track pagedInvoices = [];
    @track searchTerm = '';
    @track selectedYear = '';
    @track selectedMonth = '';
    @track currentPage = 1;
    @track displayAmount = 3;
    @track isPageChanging = false;
    @track selectedRow = [];
    @track selectedRows = [];
    @track _invoices = [];
    @track copy = [];
    @track sortedInvoices = [];
    @track divVisible = false;
    @track tableVisible = false;
    @track productList = [];
    @track productListByType = {};
    @track selectedType = '';

    @track selectionsByType = {};
    @track fullSelectionsByType = {};

    @track responseIP;
    @track isSuccess;
    @track invoiceError = false;
    @track invoiceErrorMessage;
    @track invoiceSpinner = true;
    @track _actionUtil;

    //Variavel de saida com dados da fatura selecionada
    @api disputedInvoice = [];
    

    @api accountHref; 

    columns1 = columns1;
    columns2 = columns2;
    
    _ns = getNamespaceDotNotation();


    yearOptions = Array.from({ length: 3 }, (_, i) => {
        const year = new Date().getFullYear() - i;
        return { label: `${year}`, value: `${year}` };
    });

    monthNames = ["Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho", "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro"];

    monthOptions = this.monthNames.map((month, index) => {
        return { label: month, value: `${index + 1}` };
    });

    get isFirstPage() {
        return this.currentPage === 1;
    }

    get isLastPage() {
        if(!this.filteredInvoices.length) {
            return true;
        }
        return this.currentPage === Math.ceil(this.filteredInvoices.length / this.displayAmount);
    }

    get totalPages() {
        return Math.ceil(this.filteredInvoices.length / this.displayAmount);
    }

    get invoiceError() {
        return this.invoiceError;
    }

    get invoiceSpinner() {
        return this.invoiceSpinner;
    }

    get invoiceTable() {
        return !this.invoiceError && !this.invoiceSpinner;
    }

    connectedCallback() {
        console.log('ConnectedCallback DisputeFixedInvoiceDataTable:',this.serviceIdentifier);


        this._actionUtil = new OmniscriptActionCommonUtil();

        const options = {};
        const params = {
            input: {ServiceIdentifier : this.serviceIdentifier,
                isFixed : true},
            sClassName: `${this._ns}IntegrationProcedureService`,
            sMethodName: "IP_InvoiceDisputeScript",
            options: JSON.stringify(options)
        };

        this._actionUtil
            .executeAction(params, null, this, null, null)
            .then((response) => {
                console.log('Result',JSON.stringify(response));
                this.tableVisible = true;
                this.responseIP = response.result.IPResult;

                if(this.responseIP.InvoicesApi.searchLastOpenInvoice && this.responseIP.InvoicesApi.searchLastOpenInvoice.error){
                    this.invoiceError = true;
                    this.invoiceErrorMessage = 'Ocorreu um erro ao consultar as últimas faturas do cliente.';
                    console.log(this.responseIP.InvoicesApi.searchLastOpenInvoice.errorMessage);
                    return;
                }else if(this.responseIP.InvoicesApi.searchCustomerKeys && this.responseIP.InvoicesApi.searchCustomerKeys.error){
                    this.invoiceError = true;
                    this.invoiceErrorMessage = 'Ocorreu um erro ao consultar as informações do cliente.';
                    console.log(this.responseIP.InvoicesApi.searchCustomerKeys.errorMessage);
                    return;
                }else if(this.responseIP.InvoicesApi.RAServiceIdentifierError && this.responseIP.InvoicesApi.RAServiceIdentifierError.error){
                    this.invoiceError = true;
                    this.invoiceErrorMessage = this.responseIP.InvoicesApi.RAServiceIdentifierError.errorMessage;
                    return;
                }

                this.generalSetting = this.responseIP.GeneralSetting 
                && this.responseIP.GeneralSetting.generalSetting 
                && Array.isArray(this.responseIP.GeneralSetting.generalSetting) ? this.responseIP.GeneralSetting.generalSetting : [ this.responseIP.GeneralSetting.generalSetting ];
                this.invoicesApi = Array.isArray(this.responseIP.InvoicesApi) ? this.responseIP.InvoicesApi : [this.responseIP.InvoicesApi];
                this.customerIds = this.responseIP.CustomerIds;
                this.accountId = this.responseIP.CustomerIds.customerAccountId;
                this.accountHref = this.responseIP.CustomerIds.accountHref;

                console.log('Retorno IP - General Settings', JSON.stringify(this.generalSetting));

                this.copy = [...this.invoicesApi];
                for(let i = 0; i < this.copy.length; i++) {
                    let objCopy = { ...this.copy[i] };
                    objCopy.paymentDueDate = this.formatDate(objCopy.paymentDueDate);
                    this.copy[i] = objCopy;
                }

                this.sortedInvoices = [...this.copy].sort((a, b)=> {
                    const dateA = new Date(a.paymentDueDate.split('/').reverse().join('-'));
                    const dateB = new Date(b.paymentDueDate.split('/').reverse().join('-'));
                    return dateB - dateA;
                });

                this._invoices = this.sortedInvoices.slice(0, 36);
                this.filterInvoices();
            
            })
            .catch((error) => {
                console.log('Error Invoices Table: ' + error);
                this.invoiceError = true;
                this.invoiceErrorMessage = 'Ocorreu um erro ao consultar as faturas do cliente.';
                this.responseIP = null;
                this.isSuccess = null;
            })
            .finally(() => {
                this.invoiceSpinner = false;
            });
    }

    formatDate(dateString) {
        const date = !dateString || new Date(dateString) == 'Invalid Date' ? new Date("1970-01-01T00:00:00.000-03:00") : new Date(dateString);
        const day = ("0" + date.getDate()).slice(-2);
        const month = ("0" + (date.getMonth() + 1)).slice(-2);
        const year = date.getFullYear();
        return `${day}/${month}/${year}`;
    }

    handleClearFilters() {
        this.searchTerm = '';
        this.selectedYear = '';
        this.selectedMonth = '';
        this.filterInvoices();
    }
    
    handleSearchTermChange(event) {
        this.searchTerm = event.target.value;
        this.filterInvoices();
    }

    handleYearChange(event) {
        this.selectedYear = event.detail.value;
        this.filterInvoices();
    }

    handleMonthChange(event) {
        this.selectedMonth = event.detail.value;
        this.filterInvoices();
    }

    filterInvoices() {
        this.divVisible = false;

        if (!this._invoices) {
            return [];
        }

        let filtered = this._invoices;

        if (this.searchTerm !== null && this.searchTerm !== undefined) {
            filtered = filtered.filter(invoice =>
                String(invoice.invoiceNumber).toLowerCase().includes(this.searchTerm.toLowerCase()) || // Filtro de busca da tabela
                String(invoice.billingAccountId).toLowerCase().includes(this.searchTerm.toLowerCase()) // Para filtrar pelo valor da coluna billingAccountId
            );
        }

        if (this.selectedYear) {
            filtered = filtered.filter(invoice => 
                new Date(invoice.paymentDueDate.split('/').reverse().join('-')).getFullYear() == this.selectedYear
            );
        }

        if (this.selectedMonth) {
            filtered = filtered.filter(invoice => 
                new Date(invoice.paymentDueDate.split('/').reverse().join('-')).getMonth() + 1 == this.selectedMonth
            );
        }

        this.filteredInvoices = filtered;
        this.currentPage = 1;
        this.updatePagedInvoices();
    }

    updatePagedInvoices() {
        const start = (this.currentPage - 1) * this.displayAmount;
        const end = this.currentPage * this.displayAmount;
        this.pagedInvoices = JSON.parse(JSON.stringify(this.filteredInvoices.slice(start, end)));
    }

    handlePrevious() {
        if (this.currentPage > 1) {
            this.isPageChanging = true;
            this.divVisible = false;
            this.currentPage -= 1;
            this.selectedRow = [];
            this.updatePagedInvoices();
            this.isPageChanging = false;
        }
    }
    
    handleNext() {
        if (this.currentPage < Math.ceil(this.filteredInvoices.length / this.displayAmount)) {
            this.isPageChanging = true;
            this.divVisible = false;
            this.currentPage += 1;
            this.selectedRow = [];
            this.updatePagedInvoices();
            this.isPageChanging = false;
        }
    }

    //ChargeCategory
    getTabByFrontEndCode(frontEndCode) {
        let item = this.generalSetting.find(entry => entry.Name == frontEndCode);
        return item ? item.ChargeCategory : null;
    }

    handleSelection(event) {

        if (!event || !event.detail || !event.detail.selectedRows[0]) { 
            return; 
        }

        this.selectedRow = [JSON.parse(JSON.stringify(event.detail.selectedRows[0]))];
        this.divVisible = true;
        this.tableVisible = false;
        this.selectionsByType = {}; 
        this.fullSelectionsByType = {};
        this.isColab = false;       
        
        let index = this.filteredInvoices.findIndex(i => i.billNo === this.selectedRow[0]?.billNo); 
        let indexAnterior = index - 1;
       
        let obj = {
            billNo: this.selectedRow[0]?.billNo || '',
            invoiceNumber: this.selectedRow[0]?.invoiceNumber || '',
            imageNo: this.selectedRow[0]?.imageNo || '',
            financialAccountId: this.selectedRow[0]?.financialAccountId || '', //billingAccountId:MS precisa dessa Chave, mas o valor está em financialAccountId
            billingSystem: 'AMDOCS',
            accountId: this.accountId
        };

        const options = {};
        const params = {
            input: JSON.stringify(obj),
            sClassName: `${this._ns}IntegrationProcedureService`,
            sMethodName: "IP_DisputeSearchInvoiceCharges",
            options: JSON.stringify(options)
        };

        console.log('Chamando a IP_DisputeSearchInvoiceCharges', JSON.stringify(params));

        this._actionUtil
            .executeAction(params, null, this, null, null)
            .then((response) => {
				console.log('Resultado da IP_DisputeSearchInvoiceCharges',JSON.stringify(response));

                this.tableVisible = true;
                this.responseIP = response.result.IPResult;
                this.isSuccess = response.result.IPResult.isSuccess;

                const charges = Array.isArray(this.responseIP.invoiceCharges) ? this.responseIP.invoiceCharges : [this.responseIP.invoiceCharges]; 
                console.log('charges', JSON.stringify(charges)); //<------ Subir isso
                let credits;
                if(this.responseIP.invoiceCredits && this.responseIP.invoiceCredits.invoiceCredits && this.responseIP.invoiceCredits.invoiceCredits.credits){
                    credits = Array.isArray(this.responseIP.invoiceCredits.invoiceCredits.credits) ? this.responseIP.invoiceCredits.invoiceCredits.credits : [this.responseIP.invoiceCredits.invoiceCredits.credits];
                }
                console.log('credits', JSON.stringify(credits)); //<------ Subir isso
                console.log('Charges antes de transformar', JSON.stringify(charges));
                this.productList = this.normalizeCharges(charges ?? []);
                console.log('Charges depois de transformar', JSON.stringify(this.productList));

                let types = [];
                this.productListByType= [];
                console.log('ProductList', JSON.stringify(this.productList)); //<------ Subir isso
                if(credits) this.haveDiscount = credits.some((credit) => credit.reason == 'INOPTC');
                
                for (let i = 0; i < this.productList.length; i++) {
                    let product = this.productList[i];

                    try {
                        console.log('product',JSON.stringify(product)); //<------ Subir isso
                        let type;
                        let generalSettingItem = this.generalSetting.find(item => item && item.Name && item.Name == product.frontEndCode); //<------ Subir isso
                        if(chargeCodes.includes(product.code)){
                            this.isColab = true;
                        }
                        if(generalSettingItem){
                            type = generalSettingItem.TabValue;
                        }
                        if(type != undefined){
                            if (!this.productListByType[type]) {
                                this.productListByType[type] = []; 
                            }
                            this.productListByType[type].push(product)
                            if (!types.includes(type)) {
                                types.push(type);
                            };
                        }    
                    } catch (e) {
                        console.log('Erro ao tentar exibir o produto: ' + e);
                        console.log('product', JSON.stringify(this.product));
                    }
                }       
                console.log('productList', JSON.stringify(this.productList));
                console.log('Types', JSON.stringify(types));
                this.selectedType = types[0];
            })
            .catch((error) => {
                console.log('Error Items Grid: ' + error);
                this.tableVisible = false;
                this.responseIP = null;
                this.isSuccess = null;
                this.productList = [];
                this.productListByType = [];
            }).finally(()=>{
                console.log('Não entrou no evento');
                console.log(JSON.stringify(this.selectedRow));
                this.disputedInvoice = this.selectedRow;
                if(this.selectedRow && this.selectedRow[0] && this.selectedRow[0].financialAccountId){
                    console.log('Entrou no evento');
                    const selectedEvent = new CustomEvent('selected', {
                        detail: this.selectedRow[0].financialAccountId,
                        bubbles: true,
                        composed: true,
                    });
                    this.dispatchEvent(selectedEvent);
                }
            });      

    }     

    normalizeCharges(charges = []){
        let chargesNormalized = [];
		if (charges && Array.isArray(charges) && charges.length > 0) {
			charges.forEach(charge => {
				let chargeNormalized = Object.assign({}, charge);
				chargeNormalized.uniqueId = charge.id + charge.codeDescription;
				chargesNormalized.push(chargeNormalized);
			});
		}
		return chargesNormalized;
    }
    
    handleTabChange(event) {
        if (this.selectedType) {
            this.selectionsByType[this.selectedType] = this.selectedRows;
        }
        this.selectedType = event.currentTarget.dataset.id;
        this.selectedRows = this.selectionsByType[this.selectedType] || [];
    }
    

    get productTypes() {
        return Object.keys(this.productListByType);
    }

    get selectedTypeProducts() {    
        return this.productListByType[this.selectedType] || [];
    }    

    get currentSelections() {
        return [...(this.selectionsByType[this.selectedType] || [])];
    }

    handleRowSelection(event) {
        console.log('EventRowSelection',JSON.stringify(event)); 
        if (!this.selectionsByType[this.selectedType]) {
            this.selectionsByType[this.selectedType] = [];
        }
    
        if (!this.fullSelectionsByType[this.selectedType]) {
            this.fullSelectionsByType[this.selectedType] = [];
        }
    
        this.selectionsByType[this.selectedType] = [];
        this.fullSelectionsByType[this.selectedType] = [];
    
                this.selectedTypeProducts.forEach((product) => {
            if (event.detail.selectedRows.some((row) => row.uniqueId === product.uniqueId)) {
                this.selectionsByType[this.selectedType].push(product.uniqueId);
                this.fullSelectionsByType[this.selectedType].push(product);
            }
        });
    
        this.selectedRows = this.selectionsByType[this.selectedType];
    
        let allSelections = [];
    
        for (let type in this.fullSelectionsByType) {
            allSelections = [...allSelections, ...this.fullSelectionsByType[type]];
        }

        if (allSelections.length === 0) {
            this.allSelections = null;
        } else {
            allSelections = Array.isArray(allSelections) ? allSelections : [allSelections];
            allSelections = allSelections.map(item => {
                if(!item.chargeCategory){
                    item.ChargeCategory = this.getTabByFrontEndCode(item.frontEndCode);
                }
                item.haveDiscount = this.haveDiscount;
                item.customerAccountId = this.accountId;
                return item;
            });
            this.allSelections = { charges: allSelections };
            console.log('AllSelections: '+JSON.stringify(this.allSelections)); 
        }
      }
    
    @api
    validate() {
        if (this.allSelections) {
            return {
                isValid :true
            };
        } else {
            return {
                isValid: false,
                errorMessage: 'Selecione ao menos um item de fatura antes de continuar.'
            };
        }
    }
    
}