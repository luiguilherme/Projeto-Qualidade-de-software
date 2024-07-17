import { LightningElement, api, track } from 'lwc';
import { OmniscriptBaseMixin } from 'vlocity_cmt/omniscriptBaseMixin';
import { creditReasonDescriptionMapping } from './creditReasonDescriptionMapping';
import { getNamespaceDotNotation } from 'vlocity_cmt/omniscriptInternalUtils';
import { OmniscriptActionCommonUtil } from 'vlocity_cmt/omniscriptActionUtils';
import pubsub from 'vlocity_cmt/pubsub';
import { interpolateWithRegex } from 'vlocity_cmt/flexCardUtility';
import LightningAlert from 'lightning/alert';

    export default class DisputeAdjustmentForm extends OmniscriptBaseMixin(LightningElement) {
    // Controlar Eventos
    WrapperContextId;

    // Eventos
    _actionUtil;
    _ns = getNamespaceDotNotation();
    _regexPattern = /\{([a-zA-Z.0-9_]+)\}/g;
    pubsubEvents = {};

    // Variaveis
    selectedInvoice;
    CustomerIds;
    creditReasonDescriptionMapping;
    beforeTransformationCartItems;
    isPaid;
    invoiceNumber;
    caseId;
    interactionId;
    interactionTopicId;
    accountId;
    isLastItem;
    shouldSendBill; 
    invoiceStatus;
    hasAutoDebit;
    withinAdjustmentPeriod;

    // Decoradores api
    @api param;

    // Valores Rastreados
    @track contextId;
    @track adjustmentItems = {};
    @track adjustmentItemsFormated = {};
    @track cartItems;
    @track totalAdjustmentAmount = 'R$0,00';
    @track totalAdjustmentAmountInitial;
    @track showPage = false;
    @track showLoading = true;
    @track receivedFromAdjusment = false;
    @track sessionFields = false;
    @track sessionNotes;
    @track isDisabled = false;

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

        // Ouvir alertas
        this.subscribeToEvent('ServiceDefinition', 'RegisterBtn',  this.handleEvent.bind(this));
       
        // Captura Parâmetros Amdocs
        this.creditReasonDescriptionMapping = creditReasonDescriptionMapping();

        // Para testar Mockado, voltar para this.setMockData()
        if(this.receivedFromAdjusment){
            this.handleGetItems();
        } else {
            this.showLoading = false;
        }
    }

    //Comparar interactionId (fixo) presente no FlexCard entregue pelo valServiceFlow com {recordId} da Wrapper que pode alterar
    validateFireEvent() {
        return this.interactionId === this.WrapperContextId;
    }

    //Verificando quem irá disparar o evento recebido pelo Registrar 
    handleEvent(evt){
        // Id da interaction deve ser o mesmo recebido através do evt.value (Parâmetro da action Register:Btn)
        // Id recebido é o Id {recordId} do DisputeFlexCardWrapper
        this.WrapperContextId = evt.WrapperContextId;
            //Transportado via prefill {recordId} para DisputeInvoicesFlow
            //Utilizado no OS MobileAdjust através da IP ValidateCartItemStatus (acionada duas vezes)
            //Inserido no nó svAdjust
        if (this.validateFireEvent()) {
            //Antes da execução normal, setar o valor para DisputeFlexCardWrapper e DisputeFlexCardMessage
            pubsub.fire('DisputeFlexCardService', 'SetLocalCurrentContextId', {WrapperContextId: this.WrapperContextId});       
 	        this.handleSave(evt);
        }
    }
    
    disconnectedCallback(){
        this.unsubscribeFromAllEvents();
    }

    subscribeToEvent(channel, event, callback){
        const channelKey = interpolateWithRegex(channel, this._allMergeFields, this._regexPattern, 'noparse');
        if (!this.pubsubEvents[channelKey]) {
            this.pubsubEvents[channelKey] = {};
        }
        // Verifica se o callback já está registrado para este evento
        const eventKey = interpolateWithRegex(event, this._allMergeFields, this._regexPattern, 'noparse');
        if (this.pubsubEvents[channelKey][eventKey] && this.pubsubEvents[channelKey][eventKey] === callback) {
            return;
        }
        this.pubsubEvents[channelKey][eventKey] = callback;
        pubsub.register(channelKey, this.pubsubEvents[channelKey]);
    }

    unsubscribeFromAllEvents(){
        Object.keys(this.pubsubEvents).forEach((channelKey) => {
            pubsub.unregister(channelKey, this.pubsubEvents[channelKey]);
        });
    }

    // Método utilizado para capturar de {records} as variáveis necessárias
    getFromRecords(){
        if (!this.param || typeof this.param !== 'object') {
            
            console.error('Invalid parameter: this.param should be an object');
            return;
        }
        //param são {records} enviados via attributo lwc
        let forceParamObject = JSON.parse(JSON.stringify(this.param))[0];
        for (let key in forceParamObject) {
            if (typeof forceParamObject[key] === 'string' && forceParamObject[key].startsWith('=')) {
                forceParamObject[key] = forceParamObject[key].substring(1);
            }
        }
        const { 
            caseId, 
            hasAutoDebit, 
            invoiceStatus, 
            invoiceNumber, 
            withinAdjustmentPeriod, 
            isLastItem,
            accountId, 
            selectedInvoice, 
            CustomerIds, 
            InteractionId, 
            InteractionTopicId,
        } = forceParamObject;
  
        this.caseId = (caseId !== undefined && caseId !== "") ? caseId : null;
        this.interactionId = (InteractionId !== undefined && InteractionId !== "") ? InteractionId : null;
        this.interactionTopicId = (InteractionTopicId !== undefined && InteractionTopicId !== "") ? InteractionTopicId : null;
        this.invoiceNumber = (invoiceNumber !== undefined && invoiceNumber !== "") ? invoiceNumber : null;
        this.isLastItem = (isLastItem !== undefined && isLastItem !== "") ? isLastItem : null;
        this.selectedInvoice = (selectedInvoice !== undefined && selectedInvoice !== "") ? selectedInvoice : null;
        this.CustomerIds = (CustomerIds !== undefined && CustomerIds !== "") ? CustomerIds : null;
        this.hasAutoDebit = (hasAutoDebit !== undefined && hasAutoDebit !== "") ? hasAutoDebit : null;
        this.invoiceStatus = (invoiceStatus !== undefined && invoiceStatus !== "") ? invoiceStatus : null;
        this.withinAdjustmentPeriod = (withinAdjustmentPeriod !== undefined && withinAdjustmentPeriod !== "") ? withinAdjustmentPeriod : null;

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

        //Verifica se os parâmetros foram recebidos e se isLastItem é 'no', pois só pode renderizar o formulário quando ele retorna 'yes'
        if (this.hasAutoDebit === null || this.invoiceStatus === null || this.withinAdjustmentPeriod === null || this.isLastItem === null || this.isLastItem == 'no') {
            this.receivedFromAdjusment = false;
        } else if (this.isLastItem == 'yes'){
            this.receivedFromAdjusment = true;
        }

        //Dispara ação para preencher o select options
        this.accountId = (accountId !== undefined && accountId !== "") ? accountId : null;
        if(this.accountId) {
            this.getOptionsFromAccountId();
        }
    }

    getOptionsFromAccountId() {
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
                pubsub.fire('ServiceDefinition', 'GetOptions', resultOptions);
            })
            .catch((error) => {
                console.log('error:', JSON.stringify(error));
            });
    }
    
    isValidEmail(email) {
        const emailRegex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
        return emailRegex.test(email);
    }
    
    // Método utilizado para converter os valores para ser exibidos na tela como R$
    formatNumberForHtml(adjustmentItems){
        return adjustmentItems.map(item => {
            let formattedItem = { ...item };
            formattedItem.valor = item.valor.toLocaleString('pt-BR', { style: 'currency', currency: 'BRL' });
            formattedItem.descontos = item.descontos.toLocaleString('pt-BR', { style: 'currency', currency: 'BRL' });
            formattedItem.valorAtual = item.valorAtual.toLocaleString('pt-BR', { style: 'currency', currency: 'BRL' });
            if (item.valorPagar) {
                formattedItem.valorPagar = parseFloat(item.valorPagar) ? parseFloat(item.valorPagar).toLocaleString('pt-BR', { style: 'currency', currency: 'BRL' }) : "R$0,00";
            } else {
                formattedItem.valorPagar = "R$0,00";
            }
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
        if (this.invoiceStatus != null && typeof this.invoiceStatus === 'string') {
            const status = this.invoiceStatus.toLowerCase();
            switch (status) {
                case 'closed':
                    options.push({ label: DisputeAdjustmentForm.MODALIDADES.CONTA_FUTURA, value: DisputeAdjustmentForm.MODALIDADES.CONTA_FUTURA });
                    options.push({ label: DisputeAdjustmentForm.MODALIDADES.REEMBOLSO, value: DisputeAdjustmentForm.MODALIDADES.REEMBOLSO });
                    break;
                    
                case 'open':
                    if (this.hasAutoDebit === "yes") {
                        if (this.withinAdjustmentPeriod === "yes") {
                            options.push({ label: DisputeAdjustmentForm.MODALIDADES.BOLETO, value: DisputeAdjustmentForm.MODALIDADES.BOLETO });
                        } else {
                            options.push({ label: DisputeAdjustmentForm.MODALIDADES.CONTA_FUTURA, value: DisputeAdjustmentForm.MODALIDADES.CONTA_FUTURA });
                        }
                    } else {
                        options.push({ label: DisputeAdjustmentForm.MODALIDADES.BOLETO, value: DisputeAdjustmentForm.MODALIDADES.BOLETO });
                    }
                    break;
            }
        }
        return options;
    }
    
    // Montar Motivos do Crédito de acordo com o Tipo de Ajuste (Combobox)
    getCreditReasonOptions(newTipoAjuste) {
        let adjustmentTypeKey = Object.keys(this.creditReasonMapping).find(key => this.creditReasonMapping[key] === newTipoAjuste);
        let creditReasonOptions = [];
        for (let creditReason in this.creditReasonDescriptionMapping) {
            if (this.creditReasonDescriptionMapping[creditReason].CATEGORY_CODE === adjustmentTypeKey) {
                creditReasonOptions.push({
                    label: creditReason,
                    value: this.creditReasonDescriptionMapping[creditReason].CREDIT_REASON_CODE
                });
            }
        }
        return creditReasonOptions;
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
        if (adjustmentItem) {
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
            if (this.adjustmentItems && this.adjustmentItems.length) {
                this.totalAdjustmentAmount = this.adjustmentItems.reduce((total, item) => total + (item.valorAjuste || 0), 0).toFixed(2);
                this.totalAdjustmentAmountInitial = this.adjustmentItems.reduce((total, item) => total + (item.valorAtual || 0), 0).toFixed(2);
                this.totalAdjustmentAmount = parseFloat(this.totalAdjustmentAmount) ? parseFloat(this.totalAdjustmentAmount).toLocaleString('pt-BR', { style: 'currency', currency: 'BRL' }) : "R$0,00";
            } else {
                this.totalAdjustmentAmount = "R$0.00";
            }
            adjustmentItem.valorPagar = (valorAtual - adjustmentValue).toFixed(2);
            this.adjustmentItemsFormated = this.formatNumberForHtml(this.adjustmentItems);
            pubsub.fire('ServiceDefinition', 'GetTotalAdjustmentAmount', parseFloat(this.totalAdjustmentAmount.replace(/\D/g, '').replace(',', '.')) / 100);
         
            if (parseFloat(this.totalAdjustmentAmount.replace(/\D/g, '').replace(',', '.')) / 100 == parseFloat(this.selectedInvoice[0].balance)){
                this.shouldSendBill = false;
                pubsub.fire('ServiceDefinition', 'ShouldSendBill', false);
            } else {
                this.shouldSendBill = true;
                pubsub.fire('ServiceDefinition', 'ShouldSendBill', true);
            }

        } else {
            console.error('Item not found: ', itemId);
        }
    }

    // Mudança no Valor Ajuste (input para o usuário)
    handleInputFocus(event) {
        event.target.value = '';
        let itemId = event.target.dataset.itemId;
        let adjustmentItem = this.adjustmentItems.find(item => item.id === itemId);
        if (adjustmentItem) {
            adjustmentItem.valorPagar = adjustmentItem.valorAtual;
            this.handleAdjustmentChange(event);
            this.adjustmentItemsFormated = this.formatNumberForHtml(this.adjustmentItems);
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
        this.adjustmentItems = Array.isArray(this.adjustmentItems) ? this.adjustmentItems : [this.adjustmentItems];
        let adjustmentItemsCopy = [...this.adjustmentItems];
        adjustmentItemsCopy.forEach(item => {
            item.modalidade = newModalidade;
            item.modalidadeSelecionada = newModalidade;
        });
        this.adjustmentItems = adjustmentItemsCopy;
        this.adjustmentItemsFormated = this.formatNumberForHtml(adjustmentItemsCopy);
        pubsub.fire('ServiceDefinition', 'GetModality', newModalidade);
        this.handleCollapsePage();
    }

    // Método para validar os campos baseado na modalidade
    validateSessionFields({ Session, Notes} ) {
        const { modality, email, otherEmail, bank, agency, cc } = Session;
        const notes = Notes;
        
        // Validação para a modalidade 'Boleto'.
        if (modality === 'Boleto' && this.shouldSendBill == true ) {
            if (!email || (email === 'Outro' && !otherEmail)) {
                this.openAlertModal('Campos Obrigatórios!', 'Favor preencher o campo ' + (!email ? 'E-mail' : 'Outro e-mail'), 'error');
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
        // Validação para 'Email'.
        if(email === 'Outro' && !this.isValidEmail(otherEmail)){
            this.openAlertModal('Erro E-mail', 'Formato de e-mail inválido!', 'error');
            return false;
        }

        // Validação para 'Notes' que é um campo obrigatório em todos os casos.
        if (!notes || notes == '{notes}') {
            this.openAlertModal('Campos Obrigatórios!', 'Favor preencher o campo Observações', 'error');
            return false;
        }

        this.sessionNotes = notes;
        this.sessionFields = true;
        return true;
    }


    handleSave(evt) {
        if (!this.validateSessionFields(evt)) {
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
            for (const item of filteredAdjustmentItems) {
                if (!item.tipoAjuste || item.valorAjuste === undefined || !item.modalidadeSelecionada || !item.motivoCreditoSelecionado || !item.motivoCreditoCode) {
                    allItemsValid = false;
                    break;
                }
                if(!item.isEvent && (item.valorAjuste == '' || item.valorAjuste == 0)){
                    nonAdjustmentValue = false;
                    break;
                }
            }
            if(!allItemsValid){
                return this.openAlertModal('Campos obrigatórios!', 'Todos os campos do Formulário devem ser preenchidos antes de Registrar o Atendimento.', 'error');
            } else if (!nonAdjustmentValue) {
                return this.openAlertModal('Erro', 'O valor de Ajuste deve ser diferente de R$0.00', 'error');
            } else if (this.sessionFields){
                const formatDateToISO = dateStr => {
                    const [day, month, year] = dateStr.split('/');
                    return new Date(`${year}-${month}-${day}T00:00:00.000-03:00`).toISOString();
                };

                const subscriber = this.adjustmentItems[0].SubscriberId__c;
                const createRequestObject = (creditType, subscriber) => ({
                    billingSystem: "AMDOCS",
                    countryCode: "BRA",
                    languageCode: "por",
                    billingAccountId: this.selectedInvoice[0].billingAccountId,
                    financialAccountId: this.selectedInvoice[0].financialAccountId,
                    flagToCreateCase: false,
                    creditType: creditType,
                    notes: this.sessionNotes,
                    userId: '',
                    subscriberId : subscriber,
                    invoiceDetails: {
                        invoiceId: this.selectedInvoice[0].imageNo,
                        billingInvoiceNumber: this.selectedInvoice[0].invoiceNumber,
                        documentId: this.selectedInvoice[0].billNo,
                        cycleStartDate: formatDateToISO(this.selectedInvoice[0].l9CycleStartDate),
                        cycleCloseDate: formatDateToISO(this.selectedInvoice[0].l9CycleCloseDate),
                        amount: this.selectedInvoice[0].amount,
                        adjustedPaymentAmount: this.selectedInvoice[0].adjustedPaymentAmount,
                        balance: this.selectedInvoice[0].balance
                    },
                    charges: [],
                    events: []
                });

                const procedenteRequest = createRequestObject("C", subscriber);
                const concessaoRequest = createRequestObject("S", subscriber);

                const prepareNotesRequestArray = [];
                
                this.adjustmentItems.forEach(item => {
                    const isEvent = !isNaN(item.FrontEndCode__c);
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
                // CHAR_ESP: string que será substituída por uma quebra de linha na IP PrepareCaseAmdocs para evitar transportar \n
                const convertNotesToStringBoth = prepareNotesRequestArray.map( e => {
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
                let notesFix = this.sessionNotes;

                const obj = {
                    Items: requests,
                    Notes: notesFix.replaceAll('\n',' '),
                    selectedInvoice: this.selectedInvoice,
                    CustomerIds: this.CustomerIds,
                    CaseId: this.caseId,
                    InteractionId: this.interactionId,
                    InteractionTopicId: this.interactionTopicId,
                    ConvertNotesToStringBoth: convertNotesToStringBoth,
                    ConvertNotesToStringApproved: convertNotesToStringApproved,
                    ConvertNotesToStringConcession: convertNotesToStringConcession,
                    WrapperContextId: this.WrapperContextId
                };

                pubsub.fire('ServiceDefinition', 'SendRequestGetInformationAndCreateCredit', obj);
                this.isDisabled = true;
            }
        } else if (this.sessionFields){
            let notesFix = this.sessionNotes;
            const obj = { 
                Items:'',
                Notes:notesFix.replaceAll('\n',' '),
                CustomerIds: this.CustomerIds,
                CaseId: this.caseId,
                InteractionId: this.interactionId,
                InteractionTopicId: this.interactionTopicId,
                WrapperContextId: this.WrapperContextId
            };   
           pubsub.fire('DisputeFlexCardServiceDefinitionMessage', 'CaseClosureDefinition', obj);
           this.isDisabled = true;
        }
    }

    // Capturar Informações do Carrinho e converter para formulário
    handleGetItems(){
        const getItemsFromCaseId = { CaseId: this.caseId };
        const options = {};
        const params = {
            input: JSON.stringify(getItemsFromCaseId),
            sClassName: 'vlocity_cmt.IntegrationProcedureService',
            sMethodName: 'Dispute_GetItemsFromCaseId',
            options: JSON.stringify(options)
        };
        this._actionUtil.executeAction(params, null, this, null, null)
            .then((response) => {
                let responseIp = Array.isArray(response.result.IPResult.cartItems) ? response.result.IPResult.cartItems : [response.result.IPResult.cartItems];
                // Transformação dos dados recebidos para se adequar ao formato esperado
                this.cartItems = responseIp.map(item => ({
                    _Id: item.Id,
                    isEvent: !isNaN(item.FrontEndCode__c),
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
                    StatusPt: item.StatusPt
                }));
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
                            const isEvent = !isNaN(item.FrontEndCode__c);
                            let adjustmentItem = {
                                id: item._Id,
                                fatura: item.invoiceNumber,
                                descricao: item.Description__c,
                                valor: this.convertToFloat(item.TotalAmount__c),
                                descontos: this.convertToFloat(item.Discounts__c),
                                valorAtual: this.convertToFloat(item.AvailableAmount__c),
                                valorPagar: isEvent ? this.convertToFloat(item.AvailableAmount__c) - this.convertToFloat(item.TotalAmount__c) : this.convertToFloat(item.AvailableAmount__c),
                                valorAjuste: isEvent ? this.convertToFloat(item.TotalAmount__c) : '',
                                isEvent: isEvent,
                                tipoAjuste: adjustmentType,
                                modalidades: this.getModalidadesOptions(),
                                motivoCreditoOptions: this.getCreditReasonOptions(adjustmentType),
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
                    // Prepara Objeto que Renderiza em Tela (front-end)

                    //Calcula inicialmente o valor de Ajuste Total:
                    if (this.adjustmentItems && this.adjustmentItems.length) {
                        this.totalAdjustmentAmount = this.adjustmentItems.reduce((total, item) => total + (item.valorAjuste || 0), 0).toFixed(2);
                        this.totalAdjustmentAmountInitial = this.adjustmentItems.reduce((total, item) => total + (item.valorAtual || 0), 0).toFixed(2);
                        this.totalAdjustmentAmount = parseFloat(this.totalAdjustmentAmount) ? parseFloat(this.totalAdjustmentAmount).toLocaleString('pt-BR', { style: 'currency', currency: 'BRL' }) : "R$0,00";
                    } else {
                        this.totalAdjustmentAmount = "R$0.00";
                    }

                    this.adjustmentItemsFormated = this.formatNumberForHtml(this.adjustmentItems);
                    this.showPage = true;
                    this.showLoading = false;
                }
            })
            .catch((error) => {
                console.error(error);
            });
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