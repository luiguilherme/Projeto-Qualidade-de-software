import { LightningElement, api, track } from 'lwc';
import sendEmailNotification from '@salesforce/apex/CaseMyRequestsController.sendEmailNotificationWhenCaseStatusUpdatedManually';
import getCase from '@salesforce/apex/CaseMyRequestsController.getCase';
import updateCaseStatus from '@salesforce/apex/CaseMyRequestsController.updateCaseStatus';

export default class CaseActionsContainer extends LightningElement {
    @api recordId;
    @track notifications;


    // Variaveis de controle
    isLoading = false;
    showNotifyCustomerContent = false;
    showCloseTheCaseContent = false;
    caseIsClosed = true;

    connectedCallback() {
        this.getCaseObj();
    }

    async getCaseObj() {
        await getCase({ caseId: this.recordId })
            .then(data => {
                this.caseIsClosed = this.isCaseClosed(data.Status);
            })
            .catch(error => {
                console.error('getCase');
                console.error('error => ', error);
                console.error('error.body.exceptionType => ', error.body.exceptionType);
                console.error('error.body.message => ', error.body.message);
                console.error('error.body.stackTrace => ', error.body.stackTrace);
            });
    }

    isCaseClosed(status) {
        return ['Closed', 'Cancelado', 'Expirado'].includes(status);
    }

    get notificationsNotIsEmpty() {
        return (this.notifications.length > 0);
    }

    async handleNotifyCustomerAction() {
        this.hiddenContent();
        this.showNotifyCustomerContent = true;

        this.isLoading = true;

        this.notifications = [];
        await sendEmailNotification({ caseId: this.recordId })
            .then(data => {
                if (data == 'SUCCESS') {
                    let notificationsTemp = [];
                    let emailNotification = this.buildNotification((new Date()).getTime(), 'Email enviado.', '', 'success');
                    notificationsTemp.push(emailNotification);
                    this.notifications = [...notificationsTemp];
                }
            })
            .catch(error => {
                var notificationsTemp = [];
                let emailNotification = this.buildNotification((new Date()).getTime(), 'Erro no envio do Email.', error.body.message, 'error');
                notificationsTemp.push(emailNotification);
                this.notifications = [...notificationsTemp];

                console.error('sendEmailNotification');
                console.error('error => ', error);
                console.error('error.body.exceptionType => ', error.body.exceptionType);
                console.error('error.body.message => ', error.body.message);
                console.error('error.body.stackTrace => ', error.body.stackTrace);
            });
        this.isLoading = false;
    }

    handleCloseTheCaseAction() {
        this.hiddenContent();
        this.showCloseTheCaseContent = true;
    }

    async handleConfirmCloseCase() {
        this.isLoading = true;
        this.hiddenContent();
        this.showNotifyCustomerContent = true;
        this.notifications = [];
        await updateCaseStatus({ caseId: this.recordId, status: 'Closed' })
            .then(data => {
                if (data == 'SUCCESS') {
                    this.caseIsClosed = true;
                    let notifcationsTemp = [];
                    let notification = this.buildNotification((new Date()).getTime(), 'Caso fechado.', '', 'success');
                    notifcationsTemp.push(notification);
                    this.notifications = [...notifcationsTemp];
                }
            })
            .catch(error => {
                let notifcationsTemp = [];
                let notification = this.buildNotification((new Date()).getTime(), 'Erro ao fechar o Caso.', error.body.message, 'error');
                notifcationsTemp.push(notification);
                this.notifications = [...notifcationsTemp];

                console.error('updateCaseStatus');
                console.error('error => ', error);
                console.error('error.body.exceptionType => ', error.body.exceptionType);
                console.error('error.body.message => ', error.body.message);
                console.error('error.body.stackTrace => ', error.body.stackTrace);
            })
        this.isLoading = false;
    }

    handlerefuseCloseCase() {
        this.hiddenContent();
    }

    hiddenContent() {
        this.showNotifyCustomerContent = false;
        this.showCloseTheCaseContent = false;
    }

    buildNotification(id, message, messageDetail, variant) {

        let theme;
        let icon;

        if (variant == 'success') {
            theme = 'notification slds-notify slds-theme_success';
            icon = 'utility:success';
        }
        else if (variant == 'error') {
            theme = 'notification slds-notify slds-theme_error';
            icon = 'utility:error'
        }

        return {
            id: id,
            message: message,
            messageDetail: messageDetail,
            theme: theme,
            variant: variant,
            icon: icon
        };
    }
}