import { LightningElement, track } from 'lwc';
import { OmniscriptBaseMixin } from 'vlocity_cmt/omniscriptBaseMixin';
import { getNamespaceDotNotation } from 'vlocity_cmt/omniscriptInternalUtils';
import { OmniscriptActionCommonUtil } from 'vlocity_cmt/omniscriptActionUtils';

import pubsub from 'vlocity_cmt/pubsub';
import { interpolateWithRegex } from 'vlocity_cmt/flexCardUtility';
import LightningAlert from 'lightning/alert';

export default class DisputeCartItemsDataTable extends OmniscriptBaseMixin(LightningElement) {
    
    @track cartItems;
    caseId;
    deleteItemsFromId;
    getItemsFromCaseId;
    responseIP;
    isSuccess;
    pubsubEvents = {};
    tableVisible = false;
    isNotDeleted = false;
    _actionUtil;
    _ns = getNamespaceDotNotation();
    _regexPattern = /\{([a-zA-Z.0-9_]+)\}/g;


    columns = [
        { label: 'Conta Financeira', fieldName: 'FinancialAccount__c' , initialWidth: 150, typeAttributes: { title: { fieldName: 'FinancialAccount__c' } }},
        { label: 'Instância/Produto', fieldName: 'InstanceProduct__c', initialWidth: 150, typeAttributes: { title: { fieldName: 'InstanceProduct__c' } } },
        { label: 'Descrição', fieldName: 'Description__c', initialWidth: 150, typeAttributes: { title: { fieldName: 'Description__c' } } },
        { label: 'Ordem', fieldName: 'Order__c', initialWidth: 150,typeAttributes: { title: { fieldName: 'Order__c' } } },
        { label: 'Tipo da Ordem', fieldName: 'OrderType__c', initialWidth: 150,typeAttributes: { title: { fieldName: 'OrderType__c' } } },
        { label: 'Ação da Ordem', fieldName: 'OrderAction__c', initialWidth: 150,typeAttributes: { title: { fieldName: 'OrderAction__c' } } },
        { label: 'Data de Criação da Ordem', fieldName: 'OrderCreationDate__c', initialWidth: 150,typeAttributes: { title: { fieldName: 'OrderCreationDate__c' } } },
        { label: 'Data de Conclusão da Ordem', fieldName: 'OrderCompletionDate__c', initialWidth: 150,typeAttributes: { title: { fieldName: 'OrderCompletionDate__c' } } },
        { label: 'Data de Início Faturamento', fieldName: 'BillingStartDate__c',initialWidth: 150, typeAttributes: { title: { fieldName: 'BillingStartDate__c' } } },
        { label: 'Data Fim Faturamento', fieldName: 'BillingEndDate__c', initialWidth: 150,typeAttributes: { title: { fieldName: 'BillingEndDate__c' } } },
        { label: 'Valor', fieldName: 'TotalAmount__c', initialWidth: 150,typeAttributes: { title: { fieldName: 'TotalAmount__c' } } },
        { label: 'Descontos', fieldName: 'Discounts__c',initialWidth: 150, typeAttributes: { title: { fieldName: 'Discounts__c' } } },
        { label: 'Valor Atual', fieldName: 'AvailableAmount__c', initialWidth: 150,typeAttributes: { title: { fieldName: 'AvailableAmount__c' } } },
        { label: 'Status Contestação', fieldName: 'StatusPt', initialWidth: 150,cellAttributes: { cellClass: 'status-cell' }, typeAttributes: { title: { fieldName: 'StatusPt' } } },
        { label: 'Dias de Ajuste', fieldName: 'AdjustmentDays__c', initialWidth: 150,typeAttributes: { title: { fieldName: 'AdjustmentDays__c' } } },
        { label: 'Ajustes', fieldName: 'Fit__c', initialWidth: 150,typeAttributes: { title: { fieldName: 'Fit__c' } } },
        { label: 'Definição de Atendimento', fieldName: 'ServiceDefinitionName', initialWidth: 150,typeAttributes: { title: { fieldName: 'ServiceDefinitionName' } } },
        { type: 'action', typeAttributes: { rowActions: [{ label: 'Remover', name: 'delete', iconName: 'utility:delete' }] } }
    ];

    connectedCallback(){
        this._actionUtil = new OmniscriptActionCommonUtil();
        this.subscribeToEvent('omniscript_action', 'data', this.handleReload.bind(this));
    }


    disconnectedCallback(){
        this.unsubscribeFromAllEvents();
    }

    subscribeToEvent(channel, event, callback){
        const channelKey = interpolateWithRegex(channel, this._allMergeFields, this._regexPattern, 'noparse');
        if (!this.pubsubEvents[channelKey]) {
            this.pubsubEvents[channelKey] = {};
        }

        const eventKey = interpolateWithRegex(event, this._allMergeFields, this._regexPattern, 'noparse');
        this.pubsubEvents[channelKey][eventKey] = callback;
        pubsub.register(channelKey, this.pubsubEvents[channelKey]);
    }

    unsubscribeFromAllEvents(){
        Object.keys(this.pubsubEvents).forEach((channelKey) => {
            pubsub.unregister(channelKey, this.pubsubEvents[channelKey]);
        });
    }

    handleReload(evt){
        if(evt && evt.CaseId){
            this.caseId = evt.CaseId;
        }
        this.handleGetItems();
    }


    handleDelete(){
        if(this.deleteItemsFromId !== null){
            const options = {};
            const params = {
                input: JSON.stringify(this.deleteItemsFromId),
                sClassName: 'vlocity_cmt.IntegrationProcedureService',
                sMethodName: 'Dispute_DeleteCartItems',
                options: JSON.stringify(options)
            };

            this._actionUtil.executeAction(params, null, this, null, null)
                .then((response) => {
                    this.handleReload();
                })
                .catch((error) => {
                    console.log('Erro ao remover o registro.');
                    console.error(error);
                });
        }
    }

    handleGetItems(){
        console.log('Entrou CaseId', this.caseId);
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
                console.log('update');
                this.cartItems = Array.isArray(response.result.IPResult.cartItems) ? response.result.IPResult.cartItems : [response.result.IPResult.cartItems];
                this.cartItems = [...this.cartItems];
                this.isSuccess = response.result.IPResult.isSuccess;
                this.tableVisible = false; // Forçar a re-renderização 
                this.tableVisible = true;
            })
            .catch((error) => {
                console.error(error);
            });
    }
    
    handleRowAction(event){
        const action = event.detail.action;
        const row = event.detail.row;
        if (action.name === 'delete') {
            if(row.StatusPt == "Não iniciado" || row.StatusPt == "Em análise"){
            this.deleteItemsFromId = { disputedItemId: row.Id };
            this.handleDelete();
            }
            else{
                return this.openAlertModal();
            }
        }
    }

    async openAlertModal(){
		const result = await LightningAlert.open({
			label: 'Alerta',
			message: 'O item não pode ser deletado, pois o item já foi analisado.',
            theme: 'error'
		});
	}
}