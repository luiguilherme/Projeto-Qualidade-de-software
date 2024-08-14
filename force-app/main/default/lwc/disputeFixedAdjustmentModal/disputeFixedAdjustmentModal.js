import { api, track } from 'lwc';
import LightningModal from 'lightning/modal';
import { OmniscriptBaseMixin } from 'vlocity_cmt/omniscriptBaseMixin';
import { OmniscriptActionCommonUtil } from 'vlocity_cmt/omniscriptActionUtils';
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import pubsub from 'vlocity_cmt/pubsub';

import getParamsByAccountId from'@salesforce/apex/DisputeFixedFlowController.getParamsByAccountId';
import getCaseParams from'@salesforce/apex/DisputeFixedFlowController.getCaseParam';
import getInteractionParams from'@salesforce/apex/DisputeFixedFlowController.getCustomerInteractions';

export default class DisputeFixedAdjustmentModal extends OmniscriptBaseMixin(LightningModal) {
    _actionUtil;
    @api content;
    
    isUraCall = false;
    createdCredit = false;
    caseClosed = false;
    feedbackCreditAmdocs;
    interactionTopicId;
    interactionId;
    
    @track errorMessage;
    @track haveSomeError = false;
    @track currentStep = '';
    @track steps = [];
    @track protocol = '---------';
    @track interactionNext = '---------';
    @track caseStatus = '---------';
    @track caseNumber = '---------';
    @track caseBKO = '---------';
    @track finished = false;

    itemstabledata = [];

    @track progressSteps = [
        { label: 'Criar interação', value: 'step-4' },
        { label: 'Fechar o caso', value: 'step-5' }
    ];

    connectedCallback() {
        // Adiciona Listener
        this._actionUtil = new OmniscriptActionCommonUtil();
        //Pegar interactions ID's e protocolo URA
        this.getCustomerInteractionParams();
        //Pegar itens para tabela
        this.itemstabledata = this.content.cartItems;
        //Pegar caseNumber e Status
        //this.updateCaseParams();
        
    }

    get isLastStep(){
        return this.currentStep == 'step-99';
    }

    get buttonLabel(){
        return this.haveSomeError? 'Voltar para o formulário' : 'Concluir atendimento';
    }

    get disabledButton(){
        return !(this.haveSomeError || this.finished);
    }

    getCustomerInteractionParams(){
        getInteractionParams({caseId: this.content.CaseId})
        .then( result => {
            const resultObj = JSON.parse(JSON.stringify(result));
            if(result){
                this.isUraCall = resultObj.protocolo != null && resultObj.protocolo != '';
                this.protocol = this.isUraCall ? resultObj.protocolo : '---------';
                this.interactionTopicId = resultObj.interactionTopicId;
                this.interactionId = resultObj.interactionId;
                this.caseNumber = resultObj.caseNumber;
                this.caseStatus = resultObj.statusLabel;
            }
            //Criar Lista de passos
            this.createProgressStepList();
        })
        .catch(error => {
            this.errorMessage = 'Erro ao carregar dados '+error;
            this.haveSomeError = true;
        })
    }

    updateCaseParams(){
        getCaseParams({ caseId: this.content.CaseId})
		.then(  result => {
            const resultObj = JSON.parse(JSON.stringify(result));
            if(resultObj){
                this.caseNumber = resultObj.CaseNumber;
                this.caseStatus = resultObj.statusLabel;
                this.caseBKO = resultObj.CaseNumberLegacySystem__c != null ? resultObj.CaseNumberLegacySystem__c : '---------';
            }
        })
        .catch(error =>{
            this.errorMessage = 'Erro ao carregar dados '+error;
            this.haveSomeError = true;
        })
    }

    createProgressStepList(){
        if(!this.isUraCall){
            this.progressSteps.splice(0,0,{
                value: 'step-1',
                label: 'Criar protocolo'
            });
        }
        if(this.content.Items != ''){
            this.progressSteps.splice(this.isUraCall? 0 : 1,0,{
                value: 'step-2',
                label: 'Criar créditos'
            });
        }
        if(this.content.Modality == 'Reembolso'){
            this.progressSteps.splice(2,0,{
                value: 'step-3',
                label: 'Criar caso de reembolso'
            });
        }else if(this.content.Modality == 'Boleto'){
            this.progressSteps.splice(2,0,{
                value: 'step-3',
                label: 'Enviar boleto'
            });
        }

        this.steps = [...this.progressSteps];
        //Começar a rodar Loop nos passos
        this.handleLoop();
    }

    handleLoop(){
        if(this.steps.length == 0){
            this.finished = true;
            this.currentStep = 'step-99';
            return;
        }

        const currentStep = this.steps.shift();
        this.currentStep = currentStep.value;

        switch (true) {
            case currentStep.label == 'Criar protocolo':
                this.handleCreateProtocol();
                break;
            case ['Criar créditos','Enviar boleto'].includes(currentStep.label):
                this.handleCreateCredit();
                break;
            case ['Criar interação','Criar caso de reembolso','Fechar o caso'].includes(currentStep.label):
                this.handleCloseCase();
                break;
            default:
              console.log('Houve algum erro no Switch-Case');
          }
    }

    handleCreateProtocol(){
        getParamsByAccountId({ accountId: this.content.AccountId })
		.then(  result => {
            const resultObj = JSON.parse(JSON.stringify(result));
            const obj = { 
                ServiceIdentifier: resultObj.customerPhoneNumber,
                AccountId: this.content.AccountId,
                CaseId: this.content.CaseId,
                CustomerIds: this.content.CustomerIds
                
            };
            const options = {};
            const params = {
                input: JSON.stringify(obj),
                sClassName: 'vlocity_cmt.IntegrationProcedureService',
                sMethodName: 'Dispute_PrepareVivoNetProtocolRequest',
                options: JSON.stringify(options)
            };
        
            this._actionUtil.executeAction(params, null, this, null, null)
                .then((response) => {
                    const responseIP = response.result.IPResult;
                    if(responseIP.feedbackProtocol.Success){
                        this.protocol = responseIP.protocolNumber;
                        this.handleLoop();
                    }else{
                        this.errorMessage = responseIP.feedbackProtocol.Message;
                        this.haveSomeError = true;
                    }
                })
                .catch((error) => {
                    this.errorMessage = 'Erro ao criar protocolo '+error;
                    this.haveSomeError = true;
                });
        })
		.catch(error => {
            this.errorMessage = 'Erro ao criar protocolo '+error;
            this.haveSomeError = true;
		})
    }

    handleCreateCredit(){
        if(this.createdCredit){
            this.handleLoop();
            return;
        }

        const obj = { 
            CaseId: this.content.CaseId,
            CustomerIds: this.content.CustomerIds,
            Email: this.content.Email,
            Modality: this.content.Modality,
            ShouldSendBill: this.content.Modality == 'Boleto',
            agency: this.content.Agency,
            bank: this.content.Bank,
            cc: this.content.CC,
            filteredAdjustmentItems: this.content.Items,
            selectedInvoice: this.content.selectedInvoice,
            totalAdjustmentAmount: this.content.TotalAdjustmentAmount
        };

        const options = {};
        const params = {
            input: JSON.stringify(obj),
            sClassName: 'vlocity_cmt.IntegrationProcedureService',
            sMethodName: 'Dispute_CreateCreditForChargeAndEvent',
            options: JSON.stringify(options)
        };

        this._actionUtil.executeAction(params, null, this, null, null)
            .then((response) => {
                const responseIP = response.result.IPResult;
                const approvedError = responseIP.feedbackCreditApproved ? responseIP.feedbackCreditApproved.Error : null;
                const concessionError = responseIP.feedbackCreditConcession ? responseIP.feedbackCreditConcession.Error : null;

                if(this.content.Modality == 'Boleto' && responseIP.feedbackBill && responseIP.feedbackBill.Error){
                    this.errorMessage = responseIP.feedbackBill.Message;
                    this.haveSomeError = true;
                    return;
                }

                if(approvedError){
                    this.errorMessage = responseIP.feedbackCreditApproved.Message;
                    this.haveSomeError = true;

                }else if(concessionError){
                    this.errorMessage = responseIP.feedbackCreditConcession.Message;
                    this.haveSomeError = true;
                }else{
                    this.feedbackCreditAmdocs  = responseIP.feedbackCreditAmdocs;
                    this.createdCredit = true;
                    this.handleLoop();
                }
            })
            .catch((error) => {
                this.errorMessage = 'Erro ao criar créditos '+error;
                this.haveSomeError = true;
            });
    }

    handleCloseCase(){
        if(this.caseClosed){
            this.handleLoop();
            return;
        }

        const options = {};
        const params = {
            input: {CaseId: this.content.CaseId},
            sClassName: 'vlocity_cmt.IntegrationProcedureService',
            sMethodName: 'Dispute_GetAllServiceDefinitionFromCaseId',
            options: JSON.stringify(options)
        };
    
        this._actionUtil.executeAction(params, null, this, null, null)
            .then((response) => {
                const disputedItems = response.result.IPResult;
                const obj = {
                    CaseId: this.content.CaseId,
                    ConvertNotesToStringApproved: this.content.ConvertNotesToStringApproved,
                    ConvertNotesToStringBoth: this.content.ConvertNotesToStringBoth,
                    ConvertNotesToStringConcession: this.content.ConvertNotesToStringConcession,
                    CustomerIds: this.content.CustomerIds,
                    FeedbackCreditAmdocs: this.feedbackCreditAmdocs,
                    InteractionId: this.interactionId,
                    InteractionTopicId: this.interactionTopicId,
                    Notes: this.content.Notes,
                    disputedItems: [disputedItems]
                }

                const params1 = {
                    input: obj,
                    sClassName: 'vlocity_cmt.IntegrationProcedureService',
                    sMethodName: 'Dispute_CaseClosureDefinition',
                    options: JSON.stringify(options)
                };
            
                this._actionUtil.executeAction(params1, null, this, null, null)
                .then((response) => {
                    const resultIP = response.result.IPResult;
                    
                    if(this.content.Modality == 'Reembolso' && resultIP.feedbackCaseAmdocs && resultIP.feedbackCaseAmdocs.Error){
                        this.errorMessage = resultIP.feedbackCaseAmdocs.Message;
                        this.haveSomeError = true;
                        return;
                        
                    }
                    
                    if(resultIP.feedbackUser){
                        if(resultIP.feedbackUser.Success){
                            this.interactionNext = resultIP.feedbackUserInteraction.ProtocolNumber;
                            this.caseClosed = true;
                            this.updateCaseParams();
                            this.handleLoop()
                        }else if(resultIP.feedbackUser.Error){
                            this.errorMessage = resultIP.feedbackUserInteraction.Message;
                            this.haveSomeError = true;
                        }
                    }else{
                        this.errorMessage = resultIP.feedbackUser.Message;
                        this.haveSomeError = true;
                    }
                    
                })
                .catch(error => {
                    this.errorMessage = 'Erro ao finalizar caso '+error;
                    this.haveSomeError = true;
                })
            })
            .catch((error) => {
                this.errorMessage = error;
                this.haveSomeError = true;
            });
            
    }

    handleOkay() {
        if(this.haveSomeError){
            this.disableClose = false;
            this.close('okay');
        }else{
            this.dispatchEvent(
                new ShowToastEvent({
                    title: "Success",
                    message: "O fluxo foi executado com sucesso!",
                    variant: "success",
                })
            );
            this.disableClose = false;
            this.close('finished');
        }
    }
}