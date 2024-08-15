import { LightningElement, track, api } from 'lwc';
import { OmniscriptBaseMixin } from 'vlocity_cmt/omniscriptBaseMixin'; 
import { getNamespaceDotNotation } from "vlocity_cmt/omniscriptInternalUtils";
import { OmniscriptActionCommonUtil } from "vlocity_cmt/omniscriptActionUtils";

const columns1 = [
    { label: 'Número', fieldName: 'invoiceNumber', type: 'text', initialWidth: 130 },
    { label: 'Conta Cobrança', fieldName: 'billingAccountId', type: 'text', initialWidth: 150 }, //Exibe o valor de billingAccountId
    { label: 'Período Apuração', fieldName: 'period', type: 'text', initialWidth: 175 },
    { label: 'Data de Vencimento', fieldName: 'paymentDueDate', type: 'text', initialWidth: 175 },
    { label: 'Baixa', fieldName: 'l9InvoiceCloseDate', type: 'text', initialWidth: 130 },
    { label: 'Valor', fieldName: 'amount', type: 'currency', initialWidth: 130 },
    { label: 'Ajustes', fieldName: 'totalAmount', type: 'currency', initialWidth: 130 },
    { label: 'Pagamento', fieldName: 'paymentAmount', type: 'currency', initialWidth: 130 },
    { label: 'Saldo', fieldName: 'balance', type: 'currency', initialWidth: 130 }
    
];

const columns2 = [
    { label: 'Instância/Produto', fieldName: 'instance', initialWidth: 175 },
    { label: 'Descrição', fieldName: 'codeDescription', initialWidth: 200 },
    { label: 'Valor', fieldName: 'totalAmount', type: 'currency', initialWidth: 150 },
    { label: 'Ajustes', fieldName: 'amountCredits', type: 'currency', initialWidth: 150},
    { label: 'Descontos', fieldName: 'discount', type: 'currency', initialWidth: 150 },
    { label: 'Valor Atual', fieldName: 'availableAmount', type: 'currency', initialWidth: 150 },
    { label: 'Data/Hora', fieldName: 'startTime', initialWidth: 150 }
];

export default class DisputeInvoicesDataTable extends OmniscriptBaseMixin(LightningElement) {
    @api invoicesApi = [];
    @api accountId = '';
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


        console.log('invoicesApi:',JSON.stringify(this.invoicesApi));
        console.log('generalSetting:',JSON.stringify(this.generalSetting));
        console.log('accountId',JSON.stringify(this.accountId));
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
        
         
        filtered.filter(invoice => invoice.l9InvoiceCloseDate == '' || invoice.l9InvoiceCloseDate == 'null').forEach(invoice => invoice.l9InvoiceCloseDate = '---');
        filtered.filter(invoice => invoice.amount == '' || invoice.amount == 'null').forEach(invoice => invoice.amount = '0');
        filtered.filter(invoice => invoice.totalAmount == 'null' || invoice.totalAmount == '').forEach(invoice => invoice.totalAmount = '0');
        filtered.filter(invoice => invoice.paymentAmount == '' || invoice.paymentAmount == 'null').forEach(invoice => invoice.paymentAmount = '0');
        filtered.filter(invoice => invoice.balance == '' || invoice.balance == 'null').forEach(invoice => invoice.balance = '0');
                

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

    getTabByFrontEndCode(frontEndCode) {
        let item = this.generalSetting.find(entry => entry.Name == frontEndCode);
        return item ? item.ChargeCategory : null;
    }

    handleSelection(event) {
        //Tratamento erro em produção
        if(!event || !event.detail || !event.detail.selectedRows[0]){
            return;
        }
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
            cycleEndDate:  this.selectedRow[0]?.l9CycleCloseDate || ''
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
            accountId: this.accountId
        };

    const options = {
        //"isDebug":true, "chainable":false, "resetCache":false, "ignoreCache":true, "queueableChainable":false, "useQueueableApexRemoting":false
        };
    
        const params = {
            input: JSON.stringify(obj),
            sClassName: `${this._ns}IntegrationProcedureService`,
            sMethodName: "IP_DisputeSearchInvoiceCharges",
            options: JSON.stringify(options)
        };

        this.omniRemoteCall(params, true)
            .then((response) => {
                this.resetSelectionsByTypeField();
                this.tableVisible = true;
                this.responseIP = response.result.IPResult;
                this.isSuccess = response.result.IPResult.isSuccess;
                if(this.responseIP && this.responseIP.invoiceCharges){
                    this.responseIP.invoiceCharges = Array.isArray(this.responseIP.invoiceCharges) ? this.responseIP.invoiceCharges : [this.responseIP.invoiceCharges];
                    this.responseIP.invoiceCharges = this.responseIP.invoiceCharges.map(item => {
                        item.ChargeCategory = this.getTabByFrontEndCode(item.frontEndCode);
                        return item;
                    });
                }
                this.omniApplyCallResp({"responseIP": this.responseIP});

                const processedCharges = this.processCharges(this.responseIP.invoiceCharges);
                const credits = this.ensureArray(this.responseIP.invoiceCredits);
                const newCharges = this.combineChargesAndCredits(processedCharges, credits);
                

                this.productList = this.normalizeCharges(newCharges ?? []);
                let types = [];
                this.productListByType= [];
                
                for (let i = 0; i < this.productList.length; i++) {
                    let product = this.productList[i];
                    try {
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
                            if (!product.totalAmount) product.totalAmount = '0';
                            if (!product.amountCredits) product.amountCredits = '0';
                            if (!product.discount) product.discount = '0';
                            if (!product.availableAmount) product.availableAmount = '0';
                            if (!product.startTime) product.startTime = '---';
                            this.productListByType[type].push(product);
                            if (!types.includes(type)) {
                                types.push(type);
                            };
                        }
                    } catch (e) {
                        console.log('Erro ao tentar exibir o produto: ' + e);
                        console.log('product', JSON.stringify(this.product));
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

    // Função para garantir que os dados estejam no formato de array
    ensureArray(data) {
        return Array.isArray(data) ? data : [data];
    }

    // Função para processar charges, completando informações que podem estar faltando
    processCharges(charges) {
        charges = this.ensureArray(charges);
        const offerMapping = {};      
        return charges.map(charge => {
            if (!charge) {
                return charge;
            }
            if (charge.offerId && charge.offerType) {
                offerMapping[charge.subscriberId] = { offerType: charge.offerType };
                return charge;
            }
            const offerDetails = offerMapping[charge.subscriberId];
            return offerDetails ? { ...charge, ...offerDetails } : charge;
        });
    }

    // Função para combinar informações de charges e credits
     combineChargesAndCredits(charges, credits) {
        let check = JSON.stringify(credits);
        if(check != '[null]'){
            return charges.map(charge => {
                if (parseFloat(charge.totalAmount) >= 0) {
                    const correspondingCredit = credits.find(credit => 
                         (credit.reversalReason === null || credit.reversalReason === "") && (credit.l9ChargeInvoiceId === charge.id || credit.l9EventId === charge.id || credit.l9BillingChargeSeqNo === charge.id)
                    );
                    if (correspondingCredit) {
                        return { ...charge, amountCredits: correspondingCredit.amount };
                    }
                }
                return charge;
            });
        } else {
            return charges;
        }
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
        this.template.querySelectorAll('.tab').forEach(tab => {
            tab.classList.remove('tab-selected');
        });
        event.currentTarget.parentElement.classList.add('tab-selected');
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

    resetSelectionsByTypeField() {
        this.selectionsByType = {};
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
            this.omniApplyCallResp({"selectedItems": JSON.parse(JSON.stringify(allSelections)) });
        }
    }  
    
}