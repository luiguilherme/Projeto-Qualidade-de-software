import { LightningElement, track, api } from 'lwc';
import { OmniscriptActionCommonUtil } from "vlocity_cmt/omniscriptActionUtils";
import pubsub from "vlocity_cmt/pubsub";
import { interpolateWithRegex } from 'vlocity_cmt/flexCardUtility';

export default class ContestItemsList extends LightningElement {
    @api record;
    @track items = []; // Armazena os dados que virão do IP
    @track columns = []; // Armazena as colunas da tabela
    @track nonProceedPicklist = [];
    @track impugnationPicklist = [];
    @track ChallengeValue;
    @track DoubleValue;
    @track FineValue;
    @track InterestValue;
    @track ApprovalLimitValue;
    @track showIcon = false;
    @track showAlert = false;


    _actionUtil = new OmniscriptActionCommonUtil();

    connectedCallback() {
        // Definir as colunas do datatable
        this.columns = [
            { label: '', fieldName: '', cellAttributes: { iconName: { fieldName: 'itemRuleIcon' }, title: { fieldName:'tooltipText' }}, initialWidth: 32, hideDefaultActions: false },
            { label: 'Item', fieldName: 'service', type: 'text', wrapText: true, initialWidth: 180 },
            { label: 'Data e Hora', fieldName: 'eventDateTime', type: 'text', hideDefaultActions: true, initialWidth: 140 },
            { label: 'Operação', fieldName: 'callType', type: 'text', wrapText: true, initialWidth: 160 },
            { label: 'Saldo', fieldName: 'usedUnitOfMeasure', type: 'text', hideDefaultActions: true, initialWidth: 50 },
            { label: 'Valor', fieldName: 'valorTotal', type: 'text', hideDefaultActions: true, initialWidth: 120 },
            { label: 'Status', fieldName: 'contestStatus', type: 'text', editable: false, hideDefaultActions: true, initialWidth: 160 },
            { label: 'Motivo Constestação', fieldName: 'reasonImpugnation', type: 'text', editable: false, hideDefaultActions: true, initialWidth: 180 },
            { label: 'Tipo Impugnação', fieldName: 'reason', type: 'picklistColumn', editable: true, typeAttributes: { placeholder: '', options: { fieldName: 'pickListOptions' }, value: { fieldName: 'reason' }, context: { fieldName: 'recordId' } }, hideDefaultActions: true, initialWidth: 180 },
            { label: 'Motivo Impugnação', fieldName: 'impugnationReason', type: 'picklistColumn', editable: { fieldName: 'isReasonEditable' }, typeAttributes: { placeholder: '', options: { fieldName: 'pickListOptionsReason' }, value: { fieldName: 'impugnationReason' }, context: { fieldName: 'recordId' } }, hideDefaultActions: true, initialWidth: 180 },
            { label: 'Valor Impugnação', fieldName: 'impugnationValue', type: 'currency', editable: { fieldName: 'isImpugnationValueEditable' }, hideDefaultActions: true, initialWidth: 180 }
        ];

        // Chama o Integration Procedure ao carregar o componente
        this.callIntegrationProcedure();
        

        this.paramValues = JSON.stringify(
            this.items.map(item => ({
                
                itemRuleIcon: item.itemRuleIcon,
                service: item.service,
                eventDateTime: item.eventDateTime,
                callType: item.callType,
                usedUnitOfMeasure: item.usedUnitOfMeasure,
                valorTotal: item.valorTotal,
                contestStatus: item.contestStatus,
                reasonImpugnation: item.reasonImpugnation,
                reason: item.reason,
                impugnationReason: item.impugnationReason,
                impugnationValue: item.impugnationValue
            }))
        );
    }

    // disconnectedCallback(){
    //     this.unsubscribeFromAllEvents();
    // }

    subscribeToEvent(channel, event, callback){
        const channelKey = interpolateWithRegex(channel, this._allMergeFields, this._regexPattern, 'noparse');

        if (!this.pubsubEvents[channelKey]) {
            this.pubsubEvents[channelKey] = {};
        }

        const eventKey = interpolateWithRegex(event, this._allMergeFields, this._regexPattern, 'noparse');
        this.pubsubEvents[channelKey][eventKey] = callback;
        pubsub.register(channelKey, this.pubsubEvents[channelKey]);
    }

    // unsubscribeFromAllEvents(){
    //     Object.keys(this.pubsubEvents).forEach((channelKey) => {
    //         pubsub.unregister(channelKey, this.pubsubEvents[channelKey]);
    //     });
    // }     

    handleResetVariables(data) {
        this.hasRecord = false;    
    }

    // Função para verificar se todos os campos foram preenchidos
    validateFields() {
        let allFieldsValid = true;

        this.items.forEach(item => {
            if (!item.reason || !item.impugnationReason || item.impugnationValue === undefined || item.impugnationValue === '') {
                allFieldsValid = false;
            }
        });
        console.log('Todos preenchidos ' +  allFieldsValid);

        return allFieldsValid;
    }

    // Enviar evento se todos os campos forem preenchidos
    checkAndSendEvent() {
        // Verifica se todos os campos foram preenchidos
        const allFieldsValid = this.validateFields();
        // Verifica se tem pelo menos um item que seja concessão
        let reasonImpugnation = this.items.some(item => item.impugnationReason === "Fidelização - Liberalidade (Concessão)" && item.reason === "Impugnação Parcial");
        // Verifica se algum valor final impugnado é maior que o valor contestado
        let initialValue = 0;
        let finalValue = 0;
        const finalValueGreater = this.items.some(item => { 
            initialValue = parseFloat(item.valorTotal.replace("R$", "").replace(",", "."));
            finalValue = parseFloat(item.impugnationValue);

            return finalValue >= initialValue || finalValue == 0;
        });
        // Soma todos os valores impugnados
        let totalImpugnationValue = 0;
        this.items.forEach(item => {
            totalImpugnationValue += item.impugnationValue  && item.impugnationReason === "Fidelização - Liberalidade (Concessão)" ? parseFloat(item.impugnationValue) : 0;                               
        });
    
        console.log('Soma dos valores impugnados: ' + totalImpugnationValue);
        console.log('ApprovalLimitValue: ' + this.ApprovalLimitValue);
        console.log('reasonIpugnation: ' + reasonImpugnation);
        console.log('Valor final Impugnação: ' + finalValueGreater);

        // Se todos os campos estiverem válidos e o valor for menor que o limite, continue o processo normal
        if (totalImpugnationValue > this.ApprovalLimitValue && allFieldsValid && reasonImpugnation == true) {
            // Se o total exceder o limite e for concessão, envie o payload com o erro
            const eventPayload = {
                approvalLimitValue: false,
                showButton: true,
                limitMessage: "Você não tem um valor de alçada suficiente para realizar uma Contestação por Concessão para a linha.",
                limitVariant: "warning"
            };
            pubsub.fire("Contest", "enableImpugnation", eventPayload);
            console.log('Payload enviado: ' + JSON.stringify(eventPayload));

        } else if (allFieldsValid && finalValueGreater == true && reasonImpugnation == true) {
            const eventPayload = {
                approvalLimitValue: false,
                showButton: true,
                limitMessage: "Você não pode selecionar um valor de impugnação parcial maior que o valor total.",
                limitVariant: "warning"
            };
            pubsub.fire("Contest", "enableImpugnation", eventPayload);
            console.log('Payload enviado: ' + JSON.stringify(eventPayload));
            console.log('valor Inicial ' + initialValue);
            console.log('valor Final: ' + finalValue);

        } else if ((allFieldsValid && reasonImpugnation == false) || (allFieldsValid && reasonImpugnation && finalValueGreater == false)){
            const eventPayload = {
                showButton: true,
                approvalLimitValue: true,
                items: this.items
            };
            pubsub.fire("Contest", "enableImpugnation", eventPayload);
            console.log('Payload enviado: ' + JSON.stringify(eventPayload));

        } else {
            const eventPayload = {
                showButton: false
            };
            pubsub.fire("Contest", "enableImpugnation", eventPayload);
            console.log("Nem todos os campos foram preenchidos.");
        }                    
    }
    

    callIntegrationProcedure() {
        console.log("record " + JSON.stringify(this.record));
        console.log("CaseNumber " + this.record.caseNumber);
        this._actionUtil = new OmniscriptActionCommonUtil();

        const options = {};
        const params = {
            input: {
                CaseNumber : this.record.caseNumber//para teste 00001827 00001857... o correto é this.record.caseNumber
            },

            sClassName: "vlocity_cmt.IntegrationProcedureService",
            sMethodName: "val_SearchDisputedItemData",
            options: JSON.stringify(options)
        };
        console.log("params " + JSON.stringify(params));
        this._actionUtil
            .executeAction(params, null, this, null, null)
            .then((response) => {
                const result = response.result.IPResult.DREGetDisputedItem;
                const nonProceedPicklistValues = response.result.IPResult.RAPicklistOptions.NonProceedPicklistValues;
                const impugnationPicklistValues = response.result.IPResult.RAPicklistOptions.ImpunationPicklistValues;
                this.ApprovalLimitValue = response.result.IPResult.DRGetFromToMapping.ApprovalLimitValue;
                console.log('RESPONSE: ' + JSON.stringify(response))
                
                this.items = result.map(item => {
                    // Definir as opções do Tipo Impugnação baseado no PreviousStatus
                    let pickListOptions = this.getImpugnationOptions(item.PreviousStatus,item.callType);
                    this.nonProceedPicklist = nonProceedPicklistValues;
                    this.impugnationPicklist = impugnationPicklistValues;
                    this.ChallengeValue = item.ChallengeValue;
                    this.DoubleValue = item.DoubleValue;
                    this.FineValue = item.FineValue;
                    this.InterestValue = item.InterestValue;
                    if(item.hasReachedLimitOfImpugnations){
                        this.showIcon = true;
                    }
                    
                    return {
                        ...item,
                        itemRuleIcon: item.hasReachedLimitOfImpugnations ? 'utility:warning' : '',
                        
                       // tooltipText: 'O item já atingiu a quantidade máxima de impugnações parciais e/ou não procedente, não sendo mais possível realizar nova solicitação de impugnação',
                        
                        pickListOptions: pickListOptions
                    } 
                                    
                });
                console.log("Teste: " + JSON.stringify(this.items));
            })
            .catch((error) => {
                this.responseIP = null;
            }).finally(()=>{
                pubsub.fire("Contest", "SearchResults", {"HasRecord" : this.hasRecord,"HasSearch" : true});                               
            });
    }

    getImpugnationOptions(previousStatus,calltype) {
        let pickListOptions = [];
        if (previousStatus === "Impugnado Parcial" && calltype != "ScoreCredit") {
            pickListOptions = [
                { label: "Impugnação Parcial", value: "Impugnação Parcial" },
                { label: "Não Procede", value: "Não Procede" }
            ];
        }else if (previousStatus === "Impugnado Parcial" && calltype == "ScoreCredit"){
            pickListOptions = [
                { label: "Não Procede", value: "Não Procede" }
            ];
        }else if (previousStatus === "Limite de Impugnações Atingido") {
            pickListOptions = [
                { label: "Não Procede", value: "Não Procede" }
            ];
        }else if (previousStatus === "Não Procede" || previousStatus === "Não Contestado" && calltype != "ScoreCredit") {
            pickListOptions = [
                { label: "Impugnação Parcial", value: "Impugnação Parcial" },
                { label: "Impugnação", value: "Impugnação" },
                { label: "Não Procede", value: "Não Procede" }
            ];
        }else if (previousStatus === "Não Procede" || previousStatus === "Não Contestado" && calltype == "ScoreCredit"){
            pickListOptions = [
                { label: "Impugnação", value: "Impugnação" },
                { label: "Não Procede", value: "Não Procede" }
            ];
        }
        return pickListOptions;
    }

    handleItemsCellChange(event) {
        this.handleCellChange(event, "Items");
        // Após cada mudança, verifica se os campos estão preenchidos
        this.checkAndSendEvent();
    }

    handleCellChange(event, type) {
        console.log("Mudou de valor " + JSON.stringify(event.detail.draftValues))

        let draftValues = event.detail.draftValues;
        draftValues.forEach(ele => {
            this.updateColumnData(ele, type);
            let item = type === "Items" ? this.items.find(i => i.recordId === ele.recordId) : this.filteredItems.find(i => i.recordId === ele.recordId);
            console.log("Mudou de item " + JSON.stringify(item))
            console.log("Mudou de ele " + JSON.stringify(ele))
    
            if (item) {
                let isReasonEditable = false;
                let pickListOptionsReason = [];
                // Atualiza as opções de motivo de impugnação com base no tipo de impugnação
                if (ele.reason) {
                    if (ele.reason === "Impugnação" || ele.reason === "Impugnação Parcial") {
                        pickListOptionsReason = this.impugnationPicklist || []; // Opções de impugnação
                        isReasonEditable = true;
                        item.impugnationReason = '';
                    } else if (ele.reason === "Não Procede") {
                        pickListOptionsReason = this.nonProceedPicklist || []; // Opções de "Não Procede"
                        isReasonEditable = true;
                        item.impugnationReason = '';
                    }

                    /*// Verifica se o motivo já foi preenchido anteriormente e o mantém dependendo do tipo de impugnação
                    if (item.reason !== ele.reason && (item.reason === "Não Procede" || ele.reason === "Não Procede")) {
                        // Resetar o motivo de impugnação
                        item.impugnationReason = '';
                    } */
    
                    item.pickListOptionsReason = pickListOptionsReason;
                    item.isReasonEditable = isReasonEditable;
                    item.impugnationValue = ''; // Resetar o valor impugnado                    
                    item.isImpugnationValueEditable = false;
                }  
    
                // Atualizar a lógica de "Valor Impugnação"
                console.log('ele.impugnationReason: ' + ele.impugnationReason)
                console.log('ele.reason: ' + ele.reason)

                if (ele.impugnationReason) {
                    console.log('ele.impugnationReason: ' + ele.impugnationReason)
                    console.log('ele.impugnationValue: ' + ele.impugnationValue)
                    if (item.reason === "Impugnação" && ele.impugnationReason === "Fidelização - Liberalidade (Concessão)") {
                        console.log('this.ChallengeValue: ' + this.ChallengeValue)
                        item.impugnationValue = this.ChallengeValue; // Valor fixo
                        console.log('item.impugnationValue: ' + item.impugnationValue)
                        item.isImpugnationValueEditable = false; // Não editável
                    } else if (item.reason === "Impugnação" && ele.impugnationReason === "Retificação - Falha de cobrança") {
                        console.log('this.ChallengeValue: ' + this.ChallengeValue)
                        item.impugnationValue = this.ChallengeValue; // Valor fixo
                        console.log('item.impugnationValue: ' + item.impugnationValue)
                        item.isImpugnationValueEditable = false; // Não editável
                    } else if (item.reason === "Impugnação Parcial") {
                        //item.impugnationReason = '';
                        item.isImpugnationValueEditable = true; // Editável
                        console.log('ele.reason: ' + ele.reason)
                    } else if (item.reason === "Não Procede") {
                        item.impugnationValue = 0; // Sem valor
                        item.isImpugnationValueEditable = false; // Não editável
                    }
                }

                // Verifica se o motivo já foi preenchido ao trocar o tipo de impugnação
                if (ele.reason === "Impugnação" && item.impugnationReason) {
                    /*if (item.impugnationReason === "Fidelização - Liberalidade (Concessão)") {*/
                        item.impugnationValue = this.ChallengeValue; // Valor fixo
                        item.isImpugnationValueEditable = false; // Não editável
                    /*} else if (item.impugnationReason === "Retificação - Falha de cobrança") {
                        item.impugnationValue = this.DoubleValue + this.FineValue + this.InterestValue; // Soma dos valores
                        item.isImpugnationValueEditable = false; // Não editável
                    } */
                } else if (ele.reason === "Impugnação Parcial" && item.impugnationReason) {
                    item.isImpugnationValueEditable = true; // Editável
                }
            }
            console.log("handleCellChange " + JSON.stringify(item));
            // Atualiza o valor do item com as novas mudanças
            Object.assign(item, ele);
        });
        this.draftValues = [];
        // Atualizar a lista de itens para refletir as mudanças
        this.items = [...this.items];

        console.log("this.pagedItems " + JSON.stringify(this.items));

    }
    

    updateColumnData(updatedItem, type)
    {      
        console.log("updateColumnData")
        let copyData;
        copyData = type === "Items" ? JSON.parse(JSON.stringify(this.items)) : JSON.parse(JSON.stringify(this.filteredItems));
 
        copyData.forEach(item => {
            if (item.recordId === updatedItem.recordId) {
                // eslint-disable-next-line guard-for-in
                for (let field in updatedItem) {
                    console.log(`Atribuindo o campo ${field} com valor ${updatedItem[field]}`);
                    item[field] = updatedItem[field];
                }
            }
        });
 
        if (type === "Items") {
            this.items = [...copyData];
        } else {
            this.filteredItems = [...copyData];
        }
        console.log("this.copyData " + JSON.stringify(this.items))
    }
}