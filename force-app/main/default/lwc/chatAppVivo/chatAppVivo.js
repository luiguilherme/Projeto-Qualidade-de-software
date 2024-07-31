import { LightningElement, track, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import logoChatAppVivo from '@salesforce/resourceUrl/LogoChatIA';
import getChatMessagesByCaseId from '@salesforce/apex/ChatAppVivoController.getChatMessagesByCaseId';
import newChatMessage from '@salesforce/apex/ChatAppVivoController.newChatMessage';

export default class ChatAppVivo extends LightningElement {
    @api recordId;
    @track chatContainerHeight;
    @track chatMessages;
    @track loading;

    constructor() {
        super();
        this.chatContainerHeight = '';
        this.chatMessages = [];
        this.loading = false;
    }

    get logoChat() { return logoChatAppVivo; }

    get isChatMessagesEmpty() {
        return this.chatMessages.length == 0;
    }

    connectedCallback() {
        this.chatMessagesHandle();
        this.setChatContainerHeight();
    }

    setChatContainerHeight() {
        let maxHeight = (window.screen.height * 0.5) - 110;
        let minHeight = (window.screen.height * 0.3) - 110;
        this.chatContainerHeight = `min-height: ${minHeight}px;`;
        this.chatContainerHeight += `max-height: ${maxHeight}px;`;
    }

    async chatMessagesHandle() {
        this.setLoading(true);
        try {
            await this.setChatMessages();
            this.forceScroll();
        } catch (error) {
            console.error('chatMessagesHandle: ', error.message);
            this.showToast('Erro', error.message, 'error');
        }
        this.setLoading(false);
    }

    async setChatMessages() {
        try {
            const messages = await getChatMessagesByCaseId({ caseId: this.recordId });
            this.chatMessages = this.buildChatMessages(messages);
        } catch (error) {
            let errorMessage = 'Não foi possível obter o histórico do chat.';
            this.showToast('Erro', errorMessage, 'error');

            console.error('setChatMessages'); 
            console.error('error => ', error);  
            console.error('error.body.exceptionType => ', error.body.exceptionType);
            console.error('error.body.message => ', error.body.message);
            console.error('error.body.stackTrace => ', error.body.stackTrace);
        }
       
    }

    buildChatMessages(messages) {
        let tempChatHistory = [];
        messages.forEach(message => { tempChatHistory.push(this.buildChatMessage(message)); });
        return tempChatHistory;
    }

    handleKeyPress(event) { if (event.keyCode === 13) { this.storeMessageHandle(event); } }

    async storeMessageHandle(event) {
        this.setLoading(true);
        try {
            let newMessage = this.getMessage(event);
            this.clearInputField();
            await this.storeMessage(newMessage);
            this.forceScroll();
        } catch (error) {
            console.error('storeMessageHandle: ', error.message);
            this.showToast('Erro', error.message, 'error');
        }
        this.setLoading(false);
    }

    setLoading(isLoading) { this.loading = isLoading; }

    getMessage(event) {
        return event.target.value ? event.target.value : this.template.querySelector('lightning-input[data-id="messageInput"]').value;
    }

    clearInputField() {
        this.template.querySelector('lightning-input[data-id="messageInput"]').value = null;
    }

    async storeMessage(newMessage) {
        const messageResponse = await newChatMessage({ caseId: this.recordId, newMessage: newMessage });
        if (!messageResponse) { throw new Error('Não foi possível enviar a mensagem.'); }
        this.chatMessages.push(this.buildChatMessage(messageResponse));
    }

    buildChatMessage(message) {
        return {
            id: message.id,
            parentId: message.parentId,
            fromCustomer: message.origin == 'App Vivo' ? true : false,
            bodyMessage: message.message,
        }
    }

    forceScroll() {
        setTimeout(() => {
            const inputScroll = this.template.querySelector('[data-id="scrollable"]');
            const input = this.template.querySelector('lightning-input[data-id="messageInput"]');
            console.log('input: ', input);
            inputScroll.scrollTop = inputScroll.scrollHeight;
            input.focus();
        });
    }

    showToast(title, message, variant) {
        const event = new ShowToastEvent({ title, message, variant });
        this.dispatchEvent(event);
    }
}