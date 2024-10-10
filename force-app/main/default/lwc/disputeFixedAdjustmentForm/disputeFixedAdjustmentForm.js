import { LightningElement, api, track } from 'lwc';
import { creditReasonDescriptionMapping } from './creditReasonDescriptionMapping';
import getDisputedInvoice from'@salesforce/apex/DisputedInvoiceController.findByCaseId';
import getDisputedItens from'@salesforce/apex/DisputedItemController.getByCaseId';
import LightningAlert from 'lightning/alert';
import { OmniscriptBaseMixin } from 'vlocity_cmt/omniscriptBaseMixin';
import { OmniscriptActionCommonUtil } from 'vlocity_cmt/omniscriptActionUtils';
import disputeModal from 'c/disputeFixedAdjustmentModal';
import pubsub from 'vlocity_cmt/pubsub';

export default class DisputeFixedAdjustmentForm extends OmniscriptBaseMixin(LightningElement) {
    // Chamdas para Omnstudio
    _actionUtil;

    // Variaveis
    selectedInvoice;
    creditReasonDescriptionMapping;
    isPaid;
    invoiceNumber;
    accountId;
    invoiceStatus;
    emailsOptions;
    billingAccountId;
    financialAccountId;
    modalInput;
    accountHref;


    // Entradas do Usuário
    selectedEmail;
    bank;
    agency;
    accountBank;
    modality;
    notes;

    
    // Decoradores api
    @api caseId;

    // Valores Rastreados
    @track adjustmentItems = [];
    @track adjustmentItemsFormated = [];
    @track cartItems;
    @track totalAdjustmentAmount = 'R$0,00';
    @track totalAdjustmentAmountWithoutFormat = 0.0;
    @track totalAdjustmentAmountInitial;
    @track showPage = false;
    @track showLoading = true;
    @track sessionFields = false;
    @track isDisabled = false;
    @track disableBankCard = false;
    @track disableEmailCard = false;
    @track disableEmailInput = true;

    // Variáveis Estáticas
    static MODALIDADES = {
        BOLETO: 'Boleto',
        CONTA_FUTURA: 'Crédito em conta futura',
        REEMBOLSO: 'Reembolso'
    };

    // Opções Pré-definidas 01
    optionsTipoAjuste = [
        {label: 'Retificação', value: 'Retificação'},
        {label: 'Concessão', value: 'Concessão'}
    ];

    // Opções Pré-definidas 02
    optionsModalidade = [
        {label: 'Boleto', value: 'Boleto'},
        {label: 'Crédito em conta futura', value: 'Crédito em conta futura'},
        {label: 'Reembolso', value: 'Reembolso'}
    ];

    // Opções Pré-definidas 03
    creditReasonMapping = {
        'C': 'Retificação',
        'S': 'Concessão'
    };

    connectedCallback() {
        // Adiciona Listener
        this._actionUtil = new OmniscriptActionCommonUtil();

        // Captura variaveis
        this.getFromRecords();
        
        // Captura Parâmetros Amdocs
        this.creditReasonDescriptionMapping = creditReasonDescriptionMapping();
        
    }

    // Método utilizado para capturar de {records} as variáveis necessárias
    getFromRecords(){
        getDisputedInvoice({ caseId: this.caseId })
		.then(result => {
            console.log(JSON.stringify(result));
            this.invoiceNumber = (result.invoiceNumber__c !== undefined && result.invoiceNumber__c !== "") ? result.invoiceNumber__c : null;
            this.invoiceStatus = (result.status__c !== undefined && result.status__c !== "") ? result.status__c : null;
            this.billingAccountId = (result.BillingAccountId__c !== undefined && result.BillingAccountId__c !== "") ? result.BillingAccountId__c : null;
            this.financialAccountId = (result.FinancialAccountId__c !== undefined && result.FinancialAccountId__c !== "") ? result.FinancialAccountId__c : null;
            this.accountId = (result.case__r.AccountId !== undefined && result.case__r.AccountId !== "") ? result.case__r.AccountId : null;
            this.accountHref = (result.AccountHref__c !== undefined && result.AccountHref__c !== "") ? result.AccountHref__c : null;
            this.selectedInvoice = {
                "adjustedPaymentAmount": (result.adjustedPaymentAmount__c !== undefined && result.adjustedPaymentAmount__c !== "") ? result.adjustedPaymentAmount__c : null,
                "l9CycleStartDate":  (result.l9CycleStartDate__c !== undefined && result.l9CycleStartDate__c !== "") ? result.l9CycleStartDate__c : null,
                "l9CycleCloseDate":  (result.l9CycleCloseDate__c !== undefined && result.l9CycleCloseDate__c !== "") ? result.l9CycleCloseDate__c : null,
                "billOrigin": (result.billOrigin__c !== undefined && result.billOrigin__c !== "") ? result.billOrigin__c : null,
                "status": (result.Status__c !== undefined && result.Status__c !== "") ? result.Status__c : null,
                "invoiceNumber": (result.invoiceNumber__c !== undefined && result.invoiceNumber__c !== "") ? result.invoiceNumber__c : null,
                "amount": (result.amount__c !== undefined && result.amount__c !== "") ? result.amount__c : null,
                "billNo": (result.billNo__c !== undefined && result.billNo__c !== "") ? result.billNo__c : null,
                "imageNo": (result.imageNo__c !== undefined && result.imageNo__c !== "") ? result.imageNo__c : null,
                "balance": (result.Balance__c !== undefined && result.Balance__c !== "") ? result.Balance__c : null,
              };
            console.log(JSON.stringify(this.selectedInvoice));
            // Pegar os itens contestados e formatar
            this.handleGetItems();

            if (this.invoiceStatus != null && typeof this.invoiceStatus === 'string') {
                const status = this.invoiceStatus.toLowerCase();
                if (status === 'open') {
                    this.isPaid = false;
                } else if (status === 'closed') {
                    this.isPaid = true;
                } else {
                    this.isPaid = null;
                }
            } else {
                this.isPaid = null;
            }
            console.log('this.accountId',this.accountId);
            //Dispara ação para preencher o select options
            if(this.accountId) {
                this.getOptionsFromAccountId();
            }
		})
		.catch(error => {
			console.log('getDisputedInvoice error:', JSON.stringify(error));
		})

    }

    getOptionsFromAccountId() {
        console.log('getOptionsFromAccountId');
        const getOptionsFromAccountId = { AccountId: this.accountId };
        const options = {};
        const params = {
            input: JSON.stringify(getOptionsFromAccountId),
            sClassName: 'vlocity_cmt.IntegrationProcedureService',
            sMethodName: 'Dispute_GetEmailOptionsFromAccountId',
            options: JSON.stringify(options)
        };
    
        this._actionUtil.executeAction(params, null, this, null, null)
            .then((response) => {
                console.log('getOptionsFromAccountId responseIp', JSON.stringify(response));
                let responseIp = Array.isArray(response.result.IPResult.Options) ? response.result.IPResult.Options : [response.result.IPResult.Options];
                const resultOptions = [];
    
                for (let key in responseIp[0]) {
                    const option = responseIp[0][key];
                    if (option.label !== "Não Cadastrado" && this.isValidEmail(option.label)) {
                        resultOptions.push({
                            value: option.value,
                            name: option.name,
                            label: option.label
                        });
                    }
                }
    
                resultOptions.push({
                    value: "Outro",
                    name: "Outro",
                    label: "Outro"
                });
                this.emailsOptions = resultOptions;
            })
            .catch((error) => {
                console.log('getOptionsFromAccountId error:', JSON.stringify(error));
            });
    }
    
    isValidEmail(email) {
        const emailRegex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
        return emailRegex.test(email);
    }
    
    // Método utilizado para converter os valores para ser exibidos na tela como R$
    formatNumberForHtml(adjustmentItems, isBlur = false, changedItem = null){
        return adjustmentItems.map(item => {
            let formattedItem = { ...item };
            formattedItem.valor = item.valor.toLocaleString('pt-BR', { style: 'currency', currency: 'BRL' });
            formattedItem.descontos = item.descontos.toLocaleString('pt-BR', { style: 'currency', currency: 'BRL' });
            formattedItem.valorAtual = item.valorAtual.toLocaleString('pt-BR', { style: 'currency', currency: 'BRL' });
            if(isBlur || item.isReadOnly || item.id != changedItem){
                formattedItem.valorAjuste = item.valorAjuste.toLocaleString('pt-BR', { style: 'currency', currency: 'BRL' });
            }
            
            if (item.valorPagar) {
                formattedItem.valorPagar = parseFloat(item.valorPagar) ? parseFloat(item.valorPagar).toLocaleString('pt-BR', { style: 'currency', currency: 'BRL' }) : "R$0,00";
                if(item.isReadOnly){
                    formattedItem.valorPagar = '+'.concat(' ', formattedItem.valorPagar);
                }
            } else {
                formattedItem.valorPagar = "R$0,00";
            }
            console.log('formattedItem', JSON.stringify(formattedItem));
            return formattedItem;
        });
    }
    
    // Método utilitário para converter os valores em float
    convertToFloat(value) {
        if (typeof value === 'string') {
            return parseFloat(value) || 0;
        } else if (typeof value === 'number') {
            return value;
        } else {
            return 0;
        }
    }

    // Montar Modalidades de acordo com o Status da Fatura (Boleto, Reembolso, Conta Futura, Caso BKO)
    getModalidadesOptions() {
        let options = [];
        console.log('getModalidadesOptions this.invoiceStatus',this.invoiceStatus);
        if (this.invoiceStatus != null && typeof this.invoiceStatus === 'string') {
            const status = this.invoiceStatus.toLowerCase();
            switch (status) {
                case 'closed':
                    options.push({ label: DisputeFixedAdjustmentForm.MODALIDADES.CONTA_FUTURA, value: DisputeFixedAdjustmentForm.MODALIDADES.CONTA_FUTURA });
                    options.push({ label: DisputeFixedAdjustmentForm.MODALIDADES.REEMBOLSO, value: DisputeFixedAdjustmentForm.MODALIDADES.REEMBOLSO });
                    break;
                    
                case 'open':
                    // if (this.hasAutoDebit === "yes") {
                    //     if (this.withinAdjustmentPeriod === "yes") {
                    //         options.push({ label: DisputeFixedAdjustmentForm.MODALIDADES.BOLETO, value: DisputeFixedAdjustmentForm.MODALIDADES.BOLETO });
                    //     } else {
                    //         options.push({ label: DisputeFixedAdjustmentForm.MODALIDADES.CONTA_FUTURA, value: DisputeFixedAdjustmentForm.MODALIDADES.CONTA_FUTURA });
                    //     }
                    // } else {
                    options.push({ label: DisputeFixedAdjustmentForm.MODALIDADES.BOLETO, value: DisputeFixedAdjustmentForm.MODALIDADES.BOLETO });
                    
                    break;
            }
        }
        return options;
    }
    
    // Montar Motivos do Crédito de acordo com o Tipo de Ajuste (Combobox)
    getCreditReasonOptions(newTipoAjuste, isEvent) {
        let itemType = isEvent ? 'EVENT' : 'CHARGE';
        let adjustmentTypeKey = Object.keys(this.creditReasonMapping).find(key => this.creditReasonMapping[key] === newTipoAjuste);
        let creditReasonOptions = [];
        for (let creditReason in this.creditReasonDescriptionMapping) {
            if (this.creditReasonDescriptionMapping[creditReason].CATEGORY_CODE === adjustmentTypeKey && this.creditReasonDescriptionMapping[creditReason].TYPE === itemType) {
                creditReasonOptions.push({
                    label: creditReason,
                    value: this.creditReasonDescriptionMapping[creditReason].CREDIT_REASON_CODE
                });
            }
        }
        return creditReasonOptions;
    }

    handleEmailChange(event){
        this.disableEmailInput = event.target.value != 'Outro';
        this.selectedEmail = event.target.value;
        this.refs.inputEmail.value = '';
    }

    handleEmailInputChange(event){
        this.selectedEmail = event.target.value;
    }

    handleInputedEmail(event){
        let inputedEmail = this.selectedEmail;
        
        if (!inputedEmail || inputedEmail == 'Outro'){
            this.selectedEmail = '';
        }else{
            this.selectedEmail = inputedEmail
        }
    }

    handleInputNote(event){
        this.notes = event.target.value;
    }

    handleInputBank(event){
        this.bank = event.target.value;
    }

    handleInputAgency(event){
        this.agency = event.target.value;
    }

    handleInputCC(event){
        this.accountBank = event.target.value;
    }

    

    // Mudança no Valor Ajuste (input para o usuário)
    handleAdjustmentChange(event) {
        let itemId = event.target.dataset.itemId;
        let adjustmentValueStr = event.target.value.replace(',', '.');
        if (adjustmentValueStr.endsWith('.')) {
            return;
        }
        let adjustmentValue = parseFloat(adjustmentValueStr) || 0;
        let adjustmentItem = this.adjustmentItems.find(item => item.id === itemId);
        if (adjustmentItem && !adjustmentItem.isReadOnly) {
            let valorAtual = parseFloat(adjustmentItem.valorAtual);
            let difference = valorAtual - adjustmentValue;
            let decimalPart = (adjustmentValueStr.split('.')[1] || '').length;
            if (adjustmentValue < 0) {
                return this.openAlertModal('Valor inválido', 'Favor fornecer um número positivo', 'error');
            }
            if (decimalPart > 2) {
                return this.openAlertModal('Valor inválido', 'Favor fornecer um número com no máximo duas casas decimais', 'error');
            }
            if (adjustmentValue > valorAtual || difference < 0) {
                return this.openAlertModal('Valor inválido', 'Não há como gerar crédito para item de fatura maior do que o valor disponível', 'error');
            }
            if (adjustmentValue == 0) {
                adjustmentItem.valorAjuste = '';
            } else {
                adjustmentItem.valorAjuste = adjustmentValue;
            }
            
            this.calculateTotalAdjustmentAmount();
            adjustmentItem.valorPagar = (valorAtual - adjustmentValue).toFixed(2);
            this.adjustmentItemsFormated = this.formatNumberForHtml(this.adjustmentItems,false,adjustmentItem.id);
            console.log('this.adjustmentItemsFormated:', this.adjustmentItemsFormated);
        } else {
            console.error('Item not found: ', itemId);
        }
        this.disableEmailCard = (this.adjustmentItems[0].modalidade == 'Boleto' && this.adjustmentItems.reduce((total, item) => total + (item.valorAjuste || 0), 0).toFixed(2) > 0);
    }

    handleInputBlur(event){
        this.adjustmentItemsFormated = this.formatNumberForHtml(this.adjustmentItems, true);
    }

    // Mudança no Valor Ajuste (input para o usuário)
    handleInputFocus(event) {
        let itemId = event.target.dataset.itemId;
        let adjustmentItem = this.adjustmentItems.find(item => item.id === itemId);
        if(adjustmentItem.isReadOnly){
            return;
        }
        event.target.value = '';
        if (adjustmentItem) {
            adjustmentItem.valorPagar = adjustmentItem.valorAtual;
            this.handleAdjustmentChange(event);
            this.adjustmentItemsFormated = this.formatNumberForHtml(this.adjustmentItems, true);
        }
    }

    // Mudança no Valor Ajuste (input para o usuário)
    handleInput(event) {
        let value = event.target.value.replace(',', '.');
        if (isNaN(value) || /^\d+\.?\d{0,2}$|^\.\d{0,2}$/.test(value) == false) {
            event.target.value = '';
        } else {
            let parts = value.split('.');
            if (parts.length > 1 && parts[1].length > 2) {
                value = parts[0] + '.' + parts[1].substring(0, 2);
                event.target.value = value;
            }
        }
    }

    // Mudança no Valor Ajuste (input para o usuário)
    handleInvalidInput(event) {
        event.target.value = '';
        let itemId = event.target.dataset.itemId;
        let adjustmentItem = this.adjustmentItems.find(item => item.id === itemId);
        if (adjustmentItem) {
            adjustmentItem.valorPagar = adjustmentItem.valorAtual;
            this.adjustmentItemsFormated = this.formatNumberForHtml(this.adjustmentItems);
        }
    }

    // Mudança no 'Motivo de Crédito' (combobox)
    handleCreditReasonChange(event) {
        let itemId = event.target.dataset.itemId;
        let newCreditReason = event.target.value;
        let adjustmentItemIndex = this.adjustmentItems.findIndex(item => item.id === itemId);
        if (adjustmentItemIndex !== -1) {
            let adjustmentItemsCopy = [...this.adjustmentItems];
            let adjustmentItem = adjustmentItemsCopy[adjustmentItemIndex];
            let selectedOption = adjustmentItem.motivoCreditoOptions.find(option => option.value === newCreditReason);;
            adjustmentItem.motivoCreditoSelecionado = selectedOption ? selectedOption.label : '';
            adjustmentItem.motivoCredito = newCreditReason
            adjustmentItem.motivoCreditoCode = this.creditReasonDescriptionMapping[adjustmentItem.motivoCreditoSelecionado].CREDIT_REASON_CODE;

            this.adjustmentItems = adjustmentItemsCopy;
            this.adjustmentItemsFormated = this.formatNumberForHtml(adjustmentItemsCopy);
        }
        this.handleCollapsePage();
    }

    // Mudança em 'Modalidades' (Boleto, Reembolso, Conta Futura, Caso BKO) - todos os itens
    handleModalidadesChange(event) {
        let newModalidade = event.target.value;
        this.modality = newModalidade;
        this.adjustmentItems = Array.isArray(this.adjustmentItems) ? this.adjustmentItems : [this.adjustmentItems];
        let adjustmentItemsCopy = [...this.adjustmentItems];
        adjustmentItemsCopy.forEach(item => {
            if(!item.isEvent){
                item.valorPagar = 0;
                item.valorAjuste = 0;
                item.isReadOnly = false;
            }
            item.modalidade = newModalidade;
            item.modalidadeSelecionada = newModalidade;
        });
        this.adjustmentItems = adjustmentItemsCopy;
        this.calculateTotalAdjustmentAmount();
        this.adjustmentItemsFormated = this.formatNumberForHtml(this.adjustmentItems,true);
        this.disableBankCard = newModalidade == 'Reembolso';
        this.disableEmailCard = (newModalidade == 'Boleto' && this.adjustmentItems.reduce((total, item) => total + (item.valorAjuste || 0), 0).toFixed(2) > 0);
        console.log('this.totalAdjustmentAmountInitial',this.totalAdjustmentAmountInitial);
        // pubsub.fire('ServiceDefinition', 'GetModality', newModalidade);
        this.handleCollapsePage();
    }

    // Método para validar os campos baseado na modalidade
    validateSessionFields( Session ) {
        const { modality, email, bank, agency, cc , notes } = Session;
        // Validação para a modalidade 'Boleto'.
        if(this.showPage){
            if (modality === 'Boleto') {
                if (!email) {
                    this.openAlertModal('Campos Obrigatórios!', 'Favor preencher o e-mail', 'error');
                    return false;
                }
                // Validação para 'Email'.
                if(!this.isValidEmail(email)){
                    this.openAlertModal('Erro E-mail', 'Formato de e-mail inválido!', 'error');
                    return false;
                }
            }
            // Validação para a modalidade 'Reembolso'.
            else if (modality === 'Reembolso') {
                if (!bank || !agency || !cc) {
                    const missingField = !bank ? 'Banco' : (!agency ? 'Agência' : 'Conta Corrente');
                    this.openAlertModal('Campos Obrigatórios!', 'Favor preencher o campo ' + missingField, 'error');
                    return false;
                }
            }
        }

        // Validação para 'Notes' que é um campo obrigatório em todos os casos.
        if (!notes) {
            this.openAlertModal('Campos Obrigatórios!', 'Favor preencher o campo Observações', 'error');
            return false;
        }

        this.sessionFields = true;
        return true;
    }


    async handleSave(evt) {
        const objValidate = {
            modality: this.modality, 
            email: this.selectedEmail, 
            bank: this.bank, 
            agency: this.agency, 
            cc: this.accountBank, 
            notes: this.notes
        };

        const CustomerIds = {
            accountHref: this.accountHref,
            barId: this.billingAccountId,
            faId: this.financialAccountId
          };
        

        if (!this.validateSessionFields(objValidate)) {
            return;
        }

        if(this.showPage){
            const filteredAdjustmentItems = this.adjustmentItems.map(item => {
                return {
                    id: item.id,
                    fatura: item.fatura,
                    descricao: item.descricao,
                    valor: item.valor,
                    descontos: item.descontos,
                    valorAtual: item.valorAtual,
                    tipoAjuste: item.tipoAjuste,
                    valorAjuste: item.valorAjuste,

                    isEvent: item.isEvent,

                    modalidadeSelecionada: item.modalidadeSelecionada,
                    motivoCreditoSelecionado: item.motivoCreditoSelecionado,
                    motivoCreditoCode: item.motivoCreditoCode
                };
            });
            let allItemsValid = true;
            let nonAdjustmentValue = true;
            let haveEvents = false;
            for (const item of filteredAdjustmentItems) {
                if (!item.tipoAjuste || item.valorAjuste === undefined || !item.modalidadeSelecionada || !item.motivoCreditoSelecionado || !item.motivoCreditoCode) {
                    allItemsValid = false;
                    break;
                }
                if(!item.isEvent && (item.valorAjuste == '' || item.valorAjuste == 0)){
                    nonAdjustmentValue = false;
                    break;
                }
                if(item.isEvent){
                    haveEvents = true;
                }
            }
            if(!allItemsValid){
                return this.openAlertModal('Campos obrigatórios!', 'Todos os campos do Formulário devem ser preenchidos antes de Registrar o Atendimento.', 'error');
            } else if (!nonAdjustmentValue) {
                return this.openAlertModal('Erro', 'O valor de Ajuste deve ser diferente de R$0.00', 'error');
            } else if (this.sessionFields){
                const subscriber = this.adjustmentItems[0].SubscriberId__c;

                const createRequestObject = (creditType, subscriber, isEvent) => {
                    let requestObject = {
                        billingSystem: "AMDOCS",
                        countryCode: "BRA",
                        languageCode: "por",
                        billingAccountId: this.billingAccountId,
                        financialAccountId: this.financialAccountId,
                        flagToCreateCase: false,
                        creditType: creditType,
                        notes: this.notes,
                        userId: '',
                        subscriberId : subscriber,
                        invoiceDetails: {
                            invoiceId: this.selectedInvoice.imageNo,
                            billingInvoiceNumber: this.selectedInvoice.invoiceNumber,
                            documentId: this.selectedInvoice.billNo,
                            cycleStartDate: this.selectedInvoice.l9CycleStartDate,
                            cycleCloseDate: this.selectedInvoice.l9CycleCloseDate,
                            amount: this.selectedInvoice.amount,
                            adjustedPaymentAmount: this.selectedInvoice.adjustedPaymentAmount,
                            balance: this.selectedInvoice.balance
                        },
                        charges: [],
                        events: []
                    }
                    if(isEvent){
                        requestObject.invoiceDetails.startDate = this.selectedInvoice.l9CycleStartDate;
                        requestObject.invoiceDetails.endDate = this.selectedInvoice.l9CycleCloseDate;
                    }
                    return requestObject;
                };

                const procedenteRequest = createRequestObject("C", subscriber, haveEvents);
                const concessaoRequest = createRequestObject("S", subscriber, haveEvents);

                const prepareNotesRequestArray = [];
                
                this.adjustmentItems.forEach(item => {
                    const isEvent = item.isEvent;
                    const eventOrCharge = isEvent ? {
                        eventId: item.ItemId__c,
                        message: item.motivoCreditoCode,
                    } : {
                        chargeId: item.ItemId__c,
                        creditReason: item.motivoCreditoCode,
                        amount: item.valorAjuste
                    };
                    const prepareNotesRequest = isEvent ? { 
                        //Evento:
                        name: item.Description__c,
                        value: item.valor,
                        creditReason: item.motivoCreditoSelecionado,
                        status: item.StatusPt, 
                        modality: item.modalidade                  
                    } : {
                        //Charge:
                        name: item.Description__c,
                        value: item.valorAjuste,
                        creditReason: item.motivoCreditoSelecionado,
                        status: item.StatusPt,
                        modality: item.modalidade
                    };
                    prepareNotesRequestArray.push(prepareNotesRequest);
                    // Procedente = Retificação = C
                    if (item.StatusPt === 'Procedente') { 
                        if (isEvent) {
                            procedenteRequest.events.push(eventOrCharge);
                        } else {
                            procedenteRequest.charges.push(eventOrCharge);
                        }
                    // Concessão = S
                    } else if (item.StatusPt === 'Concessão') { 
                        if (isEvent) {
                            concessaoRequest.events.push(eventOrCharge);
                        } else {
                            concessaoRequest.charges.push(eventOrCharge);
                        }
                    }
                });
                const convertNotesToStringBoth = prepareNotesRequestArray.map(e => {
                    const status = e.status === 'Procedente' ? 'Retificação' : e.status;
                    return `Nome do Item: ${e.name}CHAR_ESPValor do Crédito: R$ ${e.value}CHAR_ESPTipo de Ajuste: ${status}CHAR_ESPMotivo de Crédito: ${e.creditReason}CHAR_ESPModalidade: ${e.modality}`;
                }).toString().replaceAll('\n', 'CHAR_ESP');

                const convertNotesToStringConcession = prepareNotesRequestArray.filter(e => e.status === 'Concessão').map(e => {
                    return `Nome do Item: ${e.name}CHAR_ESPValor do Crédito: R$ ${e.value}CHAR_ESPTipo de Ajuste: ${e.status}CHAR_ESPMotivo de Crédito: ${e.creditReason}CHAR_ESPModalidade: ${e.modality}`;
                }).toString().replaceAll('\n', 'CHAR_ESP');

                const convertNotesToStringApproved = prepareNotesRequestArray.filter(e => e.status === 'Procedente').map(e => {
                    return `Nome do Item: ${e.name}CHAR_ESPValor do Crédito: R$ ${e.value}CHAR_ESPTipo de Ajuste: RetificaçãoCHAR_ESPMotivo de Crédito: ${e.creditReason}CHAR_ESPModalidade: ${e.modality}`;
                }).toString().replaceAll('\n', 'CHAR_ESP');
	
                
                const requests = {
                    procedente: procedenteRequest.charges.length > 0 || procedenteRequest.events.length > 0 ? [procedenteRequest] : [],
                    concessao: concessaoRequest.charges.length > 0 || concessaoRequest.events.length > 0 ? [concessaoRequest] : []
                };
                let notesFix = this.notes;

                const obj = {
                    Items: requests,
                    Notes: notesFix.replaceAll('\n',' '),
                    selectedInvoice: [this.selectedInvoice],
                    CustomerIds: CustomerIds,
                    CaseId: this.caseId,
                    ConvertNotesToStringBoth: convertNotesToStringBoth,
                    ConvertNotesToStringApproved: convertNotesToStringApproved,
                    ConvertNotesToStringConcession: convertNotesToStringConcession,
                    Agency: this.agency,
                    Bank: this.bank,
                    Email: this.selectedEmail,
                    CC: this.accountBank,
                    ShouldSendBill: !(this.totalAdjustmentAmountWithoutFormat == this.totalAdjustmentAmountInitial),
                    TotalAdjustmentAmount: this.totalAdjustmentAmountWithoutFormat,
                    Modality: this.modality,
                    cartItems: this.cartItems,
                    AccountId: this.accountId
                };
                //Substituir evento por chamada para Integration Procedure
                console.log(JSON.stringify(obj));
                this.modalInput = obj;
                //this.isDisabled = true;
            }
        } else{
            let notesFix = this.notes;
            const obj = { 
                Items:'',
                Notes:notesFix.replaceAll('\n',' '),
                CustomerIds: CustomerIds,
                CaseId: this.caseId,
                AccountId: this.accountId
            };   
            //Substituir evento por chamada para Integration Procedure
            this.modalInput = obj;
            //this.isDisabled = true;
        }

        const result = await disputeModal.open({
            size: 'medium',
            description: 'Dispute Adjustment Modal',
            content: this.modalInput,
            disableClose: true,
        }).then((result) => {
            if (result == 'finished') {
                pubsub.fire('FixedDispute','finishFlow',{});
            }
        })
    }

    // Capturar Informações do Carrinho e converter para formulário
    handleGetItems(){
        getDisputedItens({ caseId: this.caseId })
            .then((response) => {
                console.log(' handleGetItems getDisputedItens: ',response);
                let responseArray = Array.isArray(response) ? response : [response];
                // Transformação dos dados recebidos para se adequar ao formato esperado
                this.cartItems = responseArray.map(item => {
                    const isEvent = !!item.Csp__c;
                    let adjustmentItens = {
                    _Id: item.Id,
                    isEvent: isEvent,
                    invoiceNumber: this.invoiceNumber,
                    Description__c: item.Description__c,
                    TotalAmount__c: item.TotalAmount__c,
                    Discounts__c: item.Discounts__c,
                    AvailableAmount__c: item.AvailableAmount__c,  
                    ItemId__c: item.ItemId__c,
                    FrontEndCode__c: item.FrontEndCode__c,
                    StartTime__c: item.StartTime__c,
                    BillingStartDate__c:item.BillingStartDate__c,
                    BillingEndDate__c:item.BillingEndDate__c,
                    Code__c: item.Code__c,
                    SubscriberId__c: item.SubscriberId__c,
                    NameFull__c: item.NameFull__c,            
                    StatusPt: item.statusLabel,
                    AttendantMessage: item.ServiceDefinitionId__r.AttendantMessage__c,
                    StepCode: item.ServiceDefinitionId__r.StepCode__c
                    }
                    return adjustmentItens;
                });
                // Verificar se 'status' != 'Procedente' ou 'Concessão'
               const statusIsValid = this.cartItems.some(item => item.StatusPt === 'Procedente' || item.StatusPt === 'Concessão');
                if (!statusIsValid) {
                    this.showLoading = false;
                    this.showPage = false;
                } else {
                    // Prepara Objeto que Realiza Cálculos (back-end)
                    this.adjustmentItems = this.cartItems
                        .filter(item => item.StatusPt === 'Procedente' || item.StatusPt === 'Concessão') // Separar apenas os Status 'Procedente' e 'Concessão'
                        .map(item => {
                            let adjustmentType = item.StatusPt === 'Procedente' ? 'Retificação' : 'Concessão';
                            const isReadOnly = false;
                            let adjustmentItem = {
                                id: item._Id,
                                fatura: item.invoiceNumber,
                                descricao: item.Description__c,
                                valor: this.convertToFloat(item.TotalAmount__c),
                                descontos: this.convertToFloat(item.Discounts__c),
                                valorAtual: this.convertToFloat(item.AvailableAmount__c),
                                valorPagar: item.isEvent ? this.convertToFloat(item.AvailableAmount__c) - this.convertToFloat(item.TotalAmount__c) : this.convertToFloat(item.AvailableAmount__c),
                                valorAjuste: item.isEvent ? this.convertToFloat(item.TotalAmount__c) : '',
                                isEvent: item.isEvent,
                                isReadOnly: isReadOnly,
                                tipoAjuste: adjustmentType,
                                modalidades: this.getModalidadesOptions(),
                                motivoCreditoOptions: this.getCreditReasonOptions(adjustmentType, item.isEvent),
                                ItemId__c: item.ItemId__c,
                                FrontEndCode__c: item.FrontEndCode__c,
                                StartTime__c: item.StartTime__c,
                                BillingStartDate__c:item.BillingStartDate__c,
                                BillingEndDate__c:item.BillingEndDate__c,
                                Code__c: item.Code__c,
                                Description__c: item.Description__c,
                                SubscriberId__c: item.SubscriberId__c,
                                NameFull__c: item.NameFull__c,
                                StatusPt: item.StatusPt
                            };
                
                            return adjustmentItem;
                        });

                    console.log('handleGetItems adjustmentItems',JSON.stringify(this.adjustmentItems));
                    
                    this.calculateTotalAdjustmentAmount();
                    console.log(' handleGetItems totalAdjustmentAmount',JSON.stringify(this.totalAdjustmentAmount));    
                    this.adjustmentItemsFormated = this.formatNumberForHtml(this.adjustmentItems);
                    this.showPage = true;
                    this.showLoading = false;
                    console.log('handleGetItems adjustmentItemsFormated4',JSON.stringify(this.adjustmentItemsFormated));
                }
            })
            .catch((error) => {
                console.error('getDisputedItens error:', JSON.stringify(error));
            });
    }

    calculateTotalAdjustmentAmount(){
        if (this.adjustmentItems && this.adjustmentItems.length) {
            this.totalAdjustmentAmountWithoutFormat = this.adjustmentItems.reduce((total, item) => total + (item.valorAjuste || 0), 0).toFixed(2);
            this.totalAdjustmentAmountInitial = this.adjustmentItems.reduce((total, item) => total + (item.valorAtual || 0), 0).toFixed(2);
            this.totalAdjustmentAmount = parseFloat(this.totalAdjustmentAmountWithoutFormat) ? parseFloat(this.totalAdjustmentAmountWithoutFormat).toLocaleString('pt-BR', { style: 'currency', currency: 'BRL' }) : "R$0,00";
        } else {
            this.totalAdjustmentAmount = "R$0.00";
        }
    }

    // Mensagem para usuário
    async openAlertModal(label, message, theme){
		const result = await LightningAlert.open({
			label: label,
			message: message,
            theme: theme,
		});
	}

    handleExpandPage(event) {
        let height = this.refs.maincontainer.offsetHeight + 320;
        this.refs.maincontainer.style.height = `${height}px`;
    }

    handleCollapsePage(event) {
        this.refs.maincontainer.style.height = "auto";
    }
}