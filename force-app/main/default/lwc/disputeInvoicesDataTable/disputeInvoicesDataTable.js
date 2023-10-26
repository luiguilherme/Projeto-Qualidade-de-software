import { LightningElement, track, api } from 'lwc';
import {OmniscriptBaseMixin} from 'vlocity_cmt/omniscriptBaseMixin'; 
import { getNamespaceDotNotation } from "vlocity_cmt/omniscriptInternalUtils";
import { OmniscriptActionCommonUtil } from "vlocity_cmt/omniscriptActionUtils";

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

export default class DisputeInvoicesDataTable extends OmniscriptBaseMixin(LightningElement) {
    @api invoicesApi = [];
    @api generalSetting = [];

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
    @track _actionUtil;

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

    connectedCallback() {
        this.invoicesApi = Array.isArray(this.invoicesApi) ? this.invoicesApi : [this.invoicesApi];
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

        this.omniApplyCallResp({"selectedInvoice": null});
        this.omniApplyCallResp({"selectedItems": null});
        this._actionUtil = new OmniscriptActionCommonUtil();
        this._invoices = this.sortedInvoices.slice(0, 36);
        this.filterInvoices();
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
        this.omniApplyCallResp({"selectedInvoice": null});

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
            this.omniApplyCallResp({"selectedInvoice": null});
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
            this.omniApplyCallResp({"selectedInvoice": null});
            this.isPageChanging = false;
        }
    }

    //ChargeCategory
    getTabByFrontEndCode(frontEndCode) {
        let item = this.generalSetting.find(entry => entry.Name == frontEndCode);
        return item ? item.ChargeCategory : null;
    }

    handleSelection(event) {
        this.selectedRow = [JSON.parse(JSON.stringify(event.detail.selectedRows[0]))];
        this.divVisible = true;
        this.tableVisible = false;
        this.omniApplyCallResp({"selectedItems": null }); 
        this.omniApplyCallResp({"selectedInvoice": this.selectedRow});        
        
        let index = this.filteredInvoices.findIndex(i => i.billNo === this.selectedRow[0]?.billNo); 
        let indexAnterior = index - 1;

        let selectedInvoice = {
            billNo: this.selectedRow[0]?.billNo || '',
            invoiceNumber: this.selectedRow[0]?.invoiceNumber || '',
            imageNo: this.selectedRow[0]?.imageNo || '',
            financialAccountId: this.selectedRow[0]?.financialAccountId || '', //billingAccountId:MS precisa dessa Chave, mas o valor está em financialAccountId
            billingSystem: 'AMDOCS',
            cycleEndDate:  this.selectedRow[0]?.cycleEndDate || ''
        };
        this.omniApplyCallResp({"invoicesForAddSerVerification": {"selectedInvoice" : selectedInvoice}});
        this.omniApplyCallResp({"invoicesForAddSerVerification": {"previousInvoices" : null}});
        if (indexAnterior >= 0 ){
            let previousInvoices = {
                billNo: this.filteredInvoices[indexAnterior]?.billNo || '',
                invoiceNumber: this.filteredInvoices[indexAnterior]?.invoiceNumber || '',
                imageNo: this.filteredInvoices[indexAnterior]?.imageNo || '',
                financialAccountId: this.filteredInvoices[indexAnterior]?.financialAccountId || '', //billingAccountId:MS precisa dessa Chave, mas o valor está em financialAccountId
                billingSystem: 'AMDOCS'
            }
            this.omniApplyCallResp({"invoicesForAddSerVerification": {"previousInvoices" : previousInvoices}});
        };

        let obj = {
            billNo: this.selectedRow[0]?.billNo || '',
            invoiceNumber: this.selectedRow[0]?.invoiceNumber || '',
            imageNo: this.selectedRow[0]?.imageNo || '',
            financialAccountId: this.selectedRow[0]?.financialAccountId || '', //billingAccountId:MS precisa dessa Chave, mas o valor está em financialAccountId
            billingSystem: 'AMDOCS',
        };

        const options = {};
        const params = {
            input: JSON.stringify(obj),
            sClassName: `${this._ns}IntegrationProcedureService`,
            sMethodName: "IP_DisputeSearchInvoiceCharges",
            options: JSON.stringify(options)
        };

        this._actionUtil
            .executeAction(params, null, this, null, null)
            .then((response) => {
                this.tableVisible = true;
                this.responseIP = response.result.IPResult;
                this.isSuccess = response.result.IPResult.isSuccess;
                this.omniApplyCallResp({"responseIP": this.responseIP});
                const charges = Array.isArray(this.responseIP.invoiceCharges) ? this.responseIP.invoiceCharges : [this.responseIP.invoiceCharges];
                this.productList = this.normalizeCharges(charges ?? []);
                let types = [];
                this.productListByType= [];
                
                for (let i = 0; i < this.productList.length; i++) {
                    let product = this.productList[i];
                    let type;
                    this.generalSetting = Array.isArray(this.generalSetting) ? this.generalSetting : [this.generalSetting];
                    let generalSettingItem = this.generalSetting.find(item => item.Name == product.frontEndCode);
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
                }       
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
                if(this.selectedRow && this.selectedRow[0] && this.selectedRow[0].financialAccountId){
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
        const chargesMapper = {}
        let check = JSON.stringify(charges);
        if(check != '[null]') {
            charges.forEach(charge => {
                if(chargesMapper[charge.id]){
                    const mappedCharge = chargesMapper[charge.id];
                    if(mappedCharge.totalAmount < 0) {
                        charge.discount = charge.discount ? charge.discount : 0
                        charge.discount += parseFloat(mappedCharge.totalAmount);
                        chargesMapper[charge.id] = charge;
                    }
                    if (charge.totalAmount < 0) {
                        mappedCharge.discount += parseFloat(charge.totalAmount);
                    }
                }
                else{
                    chargesMapper[charge.id] = charge;
                    charge.discount = 0;
                }
            });
            Object.values(chargesMapper).map(invoice => {
                invoice.discount = invoice.discount.toString()
            });
        }
        return Object.values(chargesMapper);
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
        if (!this.selectionsByType[this.selectedType]) {
            this.selectionsByType[this.selectedType] = [];
        }
    
        if (!this.fullSelectionsByType[this.selectedType]) {
            this.fullSelectionsByType[this.selectedType] = [];
        }
    
        this.selectionsByType[this.selectedType] = [];
        this.fullSelectionsByType[this.selectedType] = [];
    
        this.selectedTypeProducts.forEach((product) => {
            if (event.detail.selectedRows.some((row) => row.id === product.id)) {
                this.selectionsByType[this.selectedType].push(product.id);
                this.fullSelectionsByType[this.selectedType].push(product);
            }
        });
    
        this.selectedRows = this.selectionsByType[this.selectedType];
    
        let allSelections = [];
    
        for (let type in this.fullSelectionsByType) {
            allSelections = [...allSelections, ...this.fullSelectionsByType[type]];
        }

        if (allSelections.length === 0) {
            this.omniApplyCallResp({"selectedItems": null });
        } else {
            allSelections = Array.isArray(allSelections) ? allSelections : [allSelections];
            allSelections = allSelections.map(item => {
                item.ChargeCategory = this.getTabByFrontEndCode(item.frontEndCode);
                return item;
            });
            this.omniApplyCallResp({"selectedItems": JSON.parse(JSON.stringify(allSelections)) });
        }
    }  
    
}