import { LightningElement, api, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import findByFilters from '@salesforce/apex/OrderManagementController.findByFilters';
import findByAccountIdAndOrderNumber from '@salesforce/apex/RetrieveOrderDetailsController.findByAccountIdAndOrderNumber';

const columns = [
    { label: 'Número do Pedido', fieldName: 'referenceNumber', wrapText: true},
    { label: 'Data de Criação', fieldName: 'creationDate', type: 'date', wrapText: true},
    { label: 'Valor', fieldName: 'finalAmount', type: 'currency', wrapText: true},
    { label: 'Situação', fieldName: 'status', wrapText: true},
];

const gridColumns = [
    { label: 'Instância', fieldName: 'instancia', wrapText: true},
    { label: 'Produto', fieldName: 'produto', wrapText: true},
    { label: 'Plano', fieldName: 'plano', wrapText: true},
    { label: 'Data do pedido', fieldName: 'dataDoPedido', type: 'date', wrapText: true},
    { label: 'Data da conclusão', fieldName: 'dataDaConclusao', type: 'date', wrapText: true},
    { label: 'Ação', fieldName: 'acao', wrapText: true},
];

export default class RetrieveOrdersList extends LightningElement {
    @api orderItemRequired = false;
    @api accountId;
    @api type;
    @api status;
    @api startDate;
    @api endDate;
    @api selectedOrder = null;
    @track starDateFilter;
	@track endDateFilter;
    @track orders = [];
    @track orderDetails = [];
    @track columns = columns;
    @track gridColumns = gridColumns;
    @track error;
    @track isLoading = false;
    otherDates = false;
    viewDatatable = true;
    viewTableRelated = false;
    error = false;
    errorMessage = '';
    isSearchButtonDisabled = false;
    errorData = false;

    connectedCallback() {
        this.viewDatatable = true;

        if (this.startDate || this.endDate) {
            this.starDateFilter = this.startDate;
			this.endDateFilter = this.endDate;
            this.otherDates = true;
            this.validateDates();
        }
    }

    handleSearchLast30Days(){
        this.startDate = this.calculateStartDate(30);
        this.endDate = new Date().toISOString();
        this.loadOrders();
        this.otherDates = false;
    }

    handleSearchLast60Days(){
        this.startDate = this.calculateStartDate(59);
        this.endDate = new Date().toISOString();
        this.loadOrders();
        this.otherDates = false;
    }

    handleSearchOtherDates(){
        this.otherDates = true;
        this.starDateFilter = this.startDate;
        this.endDateFilter = this.endDate;
        this.validateDates();
    }

    handleStartDateChange(event) {
        this.startDate = new Date(event.target.value).toISOString();
        this.validateDates();
    }

    handleEndDateChange(event) {
        this.endDate = new Date(event.target.value).toISOString();
        this.validateDates();
    }

    handleCheckOrders(event){
        if (this.isSearchButtonDisabled) {
            return;
        }
        this.loadOrders();
    }

    getSelectedColumn(event){
        const selectedRows = event.detail.selectedRows;
        if (selectedRows.length > 0) {
            this.selectedOrder = selectedRows[0];
            this.viewTableRelated = true;
            this.loadOrderDetails(this.accountId, this.selectedOrder.referenceNumber);
        }
    }

    loadOrders(){
        this.isLoading = true;

        const statusArray = this.status ? this.status.split(',') : [];
        const typeArray = this.type ? this.type.split(',') : [];

       findByFilters({accountId: this.accountId, status: statusArray, types: typeArray, startDate: this.startDate, endDate: this.endDate})
            .then(result => {
                console.log('Result:' + JSON.stringify(result));
                if(result != null && result.length > 0){
                    this.orders = result.map(order => ({
                        referenceNumber: order.referenceNumber,
                        creationDate: order.creationDate,
                        finalAmount: order.finalAmount,
                        status: this.getStatusDescription(order.status)
                    }));
                    console.log('Result:' + JSON.stringify(this.orders));
                    this.viewDatatable = true;
                    this.isLoading = false;
                } else {
                    this.viewDatatable = false;
                    this.viewTableRelated = false;
                    this.errorMessageData = 'Não há itens a serem exibidos.';
                    this.isLoading = false;
                }                
            })
            .catch(error => {
                this.isLoading = false;
                this.error = error;
                this.showToast('Erro ao carregar pedidos', error.body.message, 'error');
            });
    }

    getStatusDescription(statusOrder) {
		let description;
		switch (statusOrder) {
			case "SUBMITTED":
				description = "Submetida";
				break;
			case "CLOSED":
				description = "Fechado";
				break;
			case "OPEN":
				description = "Aberto";
				break;
			case "TO_BE_CANCELED":
				description = "Será Cancelado";
				break;
			case "CANCELED":
				description = "Cancelado";
				break;
			case "SUBMIT_REQUESTED":
				description = "Será Enviado";
				break;
			default: 
				description = "-";
		}
		return description;
	}

    loadOrderDetails(accountId, referenceNumber){
        this.isLoading = true;
        findByAccountIdAndOrderNumber({accountId: accountId, orderNumber: referenceNumber})
            .then(result => {
                this.orderDetails = result.map(detail => ({
                    instancia: detail.serviceId,
                    produto: detail.itemName,
                    plano: detail.plan,
                    dataDoPedido: detail.creationDate,
                    dataDaConclusao: detail.closedDate,
                    _children: detail.children.map(child => ({
                        produto: child.itemName,
                        acao: child.action
                    }))                
                }));
                this.isLoading = false;
            })
            .catch(error => {
                this.isLoading = false;
                this.error = error;
                this.showToast('Erro ao carregar detalhes do pedido', error.body.message, 'error');
            });
    }

    validateDates() {
        if (this.startDate && this.endDate && new Date(this.startDate) > new Date(this.endDate)) {
            this.error = true;
            this.errorMessage = 'A data inicial não pode ser maior que a data final.';
            this.isSearchButtonDisabled = true;
        } else {
            this.error = false;
            this.errorMessage = '';
            this.isSearchButtonDisabled = false;
        }
    }

    calculateStartDate(days) {
        const date = new Date();
        date.setDate(date.getDate() - days);
        return date.toISOString();
    }
    
    showToast(title, message, variant) {
        this.dispatchEvent(
            new ShowToastEvent({
                title: title,
                message: message,
                variant: variant
            })
        );
    }

    @api
    validate() {
        if (this.orderItemRequired == true){

            if (this.orders.length === 0 || this.orders === null) {
                console.log('Nenhuma ordem encontrada, permitindo seguir.');
                return {
                    isValid: true
                };
            }
    
            if (this.orders != null && !this.selectedOrder) {
                console.log('Ordem não selecionada, impedindo fluxo.');
                return {
                    isValid: false,
                    errorMessage: 'Selecione ao menos um pedido antes de continuar.'
                };
            }
    
            console.log('Ordem selecionada, permitindo seguir.');
            return {
                isValid: true
            };
        }
        return{
            isValid: true
        };
    }


}