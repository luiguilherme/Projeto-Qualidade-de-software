import { LightningElement, api, wire, track } from 'lwc';
import { OmniscriptBaseMixin } from 'vlocity_cmt/omniscriptBaseMixin';
import ToastContainer from 'lightning/toastContainer';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { FlowAttributeChangeEvent } from 'lightning/flowSupport';
import createCaseAmdocs from '@salesforce/apex/DisputeFixedCreateCaseAmdocs.createCaseAmdocs';

export default class DisputeCreateCaseAmdocsFixed extends OmniscriptBaseMixin(LightningElement) {

    @api disabledOptions;
    @api caseId;
    @api caseAmdocsId;
    @api disputedItemId;
    @api defaultAnswear;
    @api textAreaTemplate;
    @track isLoading = false;
    @track disabledCreateCaseButton = false;

    connectedCallback() {
        const toastContainer = ToastContainer.instance();
        toastContainer.maxShown = 1;
        toastContainer.toastPosition = 'top-center';

        if (!this.textAreaTemplate) {
            this.textAreaTemplate = '- Dados do cliente: \n'
                + '- Nome do titular: \n'
                + '- CPF: \n'
                + '- Terminal/Linha que cliente desconhece: \n'
                + '- Conta cobrança: \n'
                + '- Motivo da fraude: ';
        }
        if (!this.caseAmdocsId) {
            this.disableOptions(true);
        }
        this.updateQuestionResponse('Não');
    }

    disableCreateCaseButton(disabled) {
        this.disabledCreateCaseButton = disabled;
    }

    disableOptions(disable) {
        this.disabledOptions = disable;
        const attributeChangeEvent = new FlowAttributeChangeEvent('disabledOptions', this.disabledOptions);
        this.dispatchEvent(attributeChangeEvent);
    }

    updateCaseAmdocsId(caseAmdocsId) {
        this.caseAmdocsId = caseAmdocsId;
        const attributeChangeEvent = new FlowAttributeChangeEvent('caseAmdocsId', this.caseAmdocsId);
        this.dispatchEvent(attributeChangeEvent);
    }

    updateQuestionResponse(response) {
        this.defaultAnswear = response;
        const attributeChangeEventTwo = new FlowAttributeChangeEvent('defaultAnswear', this.defaultAnswear);
        this.dispatchEvent(attributeChangeEventTwo);
    }

    saveCurrentTextTemplate() {
        const attributeChangeEventTwo = new FlowAttributeChangeEvent('textAreaTemplate', this.textAreaTemplate);
        this.dispatchEvent(attributeChangeEventTwo);
    }

    textAreaChangeHandler(e) {
        this.textAreaTemplate = e.detail.value;
    }

    async createCase() {
        this.isLoading = true;
        this.disabledOptions = true;

        let input = {
            caseId: this.caseId,
            notes: this.textAreaTemplate,
            disputedItemId: this.disputedItemId
        };

        let result;

        try {
            result = await createCaseAmdocs({inputs: input});

            if (!result || !result.status || result.status != "Success") {
                this.failureHandler();
            }
    
            if (result.status == "Success") {
                this.successHandler(result);
            }
        } catch (error) {
            console.error(error);
        }
        
        this.isLoading = false;

        return result;
    }

    openAlertModal(success) {
        let variant = success ? 'success' : 'error';
        let message = success ? 'O Caso foi aberto com sucesso.' : 'O Caso NÃO foi aberto.';

        this.dispatchEvent(
            new ShowToastEvent({
                title: message,
                message: ' ',
                variant: variant
            })
        );
	}

    async successHandler(result) {
        this.disableOptions(false);
        this.openAlertModal(true);
        this.updateCaseAmdocsId(result.caseAmdocsId);
        this.updateQuestionResponse('Sim');
        this.disableCreateCaseButton(true);
        return;
    }

    async failureHandler() {
        this.disableOptions(false);
        this.openAlertModal(false);
        return;
    }

    @api
    validate() {
        this.saveCurrentTextTemplate();
        if (this.disabledOptions) {
            return {
                isValid: false,
                errorMessage: 'Você precisa tentar abrir o Caso antes de prosseguir.'
            };
        }
        return {
            isValid: true,
        };
    }
}