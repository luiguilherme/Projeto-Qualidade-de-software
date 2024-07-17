import { LightningElement, track, api } from 'lwc';
import { NavigationMixin } from "lightning/navigation";
import { createRecord, updateRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

import userId from "@salesforce/user/Id";
import logoChatIA from '@salesforce/resourceUrl/LogoChatIA';
import getSessionId from '@salesforce/apex/ChatIAController.getSessionId';
import getQuestionSuggestion from '@salesforce/apex/ChatIAController.getQuestionSuggestion';
import getChatById from '@salesforce/apex/ChatIAController.getChatById';
import createNewChat from '@salesforce/apex/ChatIAController.createNewChat';
import addConversation from '@salesforce/apex/ChatIAController.AddConversation';
import deleteChatById from '@salesforce/apex/ChatIAController.deleteChatById';
import getPermission from '@salesforce/apex/ChatIAController.getPermission';
import createNewHistory from '@salesforce/apex/ChatIAController.createNewHistory';
import getIntegracaoQNA from '@salesforce/apex/ChatIAController.getIntegracaoQNA';

import CHATIA_OBJECT from "@salesforce/schema/ChatIA__c";
import ID_FIELD from "@salesforce/schema/ChatIA__c.Id";
import BACKUP_FIELD from "@salesforce/schema/ChatIA__c.Backup__c";
import USUARIO_FIELD from "@salesforce/schema/ChatIA__c.Usuario__c";
import ACTIVE_FIELD from "@salesforce/schema/ChatIA__c.Active__c";
import HISTORY_FIELD from "@salesforce/schema/ChatIA__c.History__c";

export default class ChatIA extends NavigationMixin(LightningElement) {
    @track userId = userId;
    @track backupChat;
    @track chatIAId;
    @track active;
    @track history;
    @track mensagemInput;
    @track correlator;
    @track correlatorFeedback = '';
    @track feedbackValue;
    @track conversaCompleta = [];
    @track questionSuggestions = [];
    @track lixeiraIsOpen = false;
    @track fieldsChatIAInsert = {};
    @track fieldsChatIAUpdate = {};
    @track lastMensagemUser = []
    @track lastMensagemIA = []
    //variáveis de controle
    @track thereIsPermission = true;
    @track loading = false;
    @track dots = false;
    @track isOpen = false;
    @track buttomDisabled = false;
    @track suggestions = false;
    @track feedbackIsOpen = false;
    @track likeDisabled = false;
    @track dislikeDisabled = false;
    @track tabIndex = '-1';
    @track heigthSize = 'height:98%';
    @track roleARIA = '';
    @track typingEffectOff = true;
    @track concatenaMensagemTypingEffect = '';
    @track streamOff = false;

    styleCSS = '<p style=\"align-items: flex-start; background-color: var(--colorIA, #5C169D); color: #ffffff; margin-left: -40px\; border-radius: 1.15rem; line-height: 1.25; max-width: 75%; padding: 0.5rem .875rem; position: relative; word-wrap: break-word">'

    connectedCallback() {
        let size = (window.screen.height * 0.7) - 110;
        this.heigthSize = 'height:' + size.toString() + 'px';
        this.verifyPermission();
    }
    modalControl(event) {
        if (event.detail === 'cancelado') {
            this.conversaCompleta.forEach(mensagem => {
                if (mensagem.correlator === this.correlator) {
                    mensagem.disableLike = false;
                    mensagem.disableDislike = false;
                    mensagem.css = '';
                }
            })
        }
        this.feedbackIsOpen = false;
    }
    @api
    forceScroll() {
        if (this.thereIsPermission) {
            setTimeout(() => {
                const inputScroll = this.template.querySelector('[data-id="scrollable"]');
                const input = this.template.querySelector('lightning-input[data-id="campoMensagem"]');
                console.log(input + ' input');
                inputScroll.scrollTop = inputScroll.scrollHeight;
                input.focus();
            })
        }
    }
    async verifyPermission() {
        try {
            const data = await getPermission();
            this.thereIsPermission = data;
            if (this.thereIsPermission === true) {
                this.getQuestions();
                this.startSessionId();
            }
        } catch {
            this.thereIsPermission = false;
        }
    }
    async getQuestions() {
        try {
            const data = await getQuestionSuggestion();
            this.questionSuggestions = data;
            this.suggestions = true;
        } catch {
            this.thereIsPermission = false;
            this.notificarErro('Não foi possível obter as sugestões de perguntas.');
        }
    }
    async startSessionId() {
        try {
            const data = await getSessionId();
            if (data) {
                this.backupChat = data.backupChat;
                this.chatIAId = data.recordFound;
                this.active = data.active;
                this.history = data.history;
            }
            if (this.chatIAId === 'null') {
                this.fieldsChatIAInsert[USUARIO_FIELD.fieldApiName] = this.userId;
                this.fieldsChatIAInsert[ACTIVE_FIELD.fieldApiName] = true;
                this.fieldsChatIAInsert[HISTORY_FIELD.fieldApiName] = true;
                this.roleARIA = 'alert';
            } else {
                this.getChatHistory();
            }
            this.tabIndex = '0';
        } catch {
            this.notificarErro('Não foi possível obter a sessão ativa.');
        }
    }
    async getChatHistory() {
        this.loading = true;
        try {
            const data = await getChatById({ backupChat: this.backupChat });
            if (data.chatFound) {
                data.history.forEach(hist => {
                    let mensagemUser = {
                        mensagemUsuario: hist.type === 'user' ? true : false,
                        conteudoMensagem: hist.message,
                        correlator: hist.correlator,
                        disableLike: false,
                        disableDislike: false,
                        css: '',
                    }
                    if (hist.feedback === 'positive') {
                        mensagemUser.disableDislike = 'true';
                        mensagemUser.css = '--slds-c-icon-color-foreground: #5C169D;margin-left: -20px;';
                    }
                    if (hist.feedback === 'negative') {
                        mensagemUser.disableLike = 'true';
                        mensagemUser.css = '--slds-c-icon-color-foreground: #5C169D;margin-left: -20px;';
                    }
                    this.conversaCompleta.push(mensagemUser);
                });
                this.suggestions = false;
            } else {
                let closeConfirmModal = true;
                let showToast = true;
                this.clearHistory(closeConfirmModal, showToast);
            }
        } catch {
            this.notificarErro('Não foi possível obter o histórico de chat.');
        }
        this.loading = false;
        setTimeout(() => {
            const inputScroll = this.template.querySelector('[data-id="scrollable"]');
            inputScroll.scrollTop = inputScroll.scrollHeight;
        })
    }
    get logoChat() {
        return logoChatIA;
    }
    questionInput(event) {
        if (event.keyCode === 13) {
            this.sendMessage(event);
        }
    }
    openLixeira(event) {
        this.lixeiraIsOpen = true;
    }
    clearHistoryEvent(event) {
        let result = event.detail
        if (result === 'sucesso') {
            this.clearHistory(true, false);
            this.lixeiraIsOpen = false;
        } else {
            this.lixeiraIsOpen = false;
        }
    }
    async clearHistory(closeConfirmModal, showToast) {
        if (closeConfirmModal == true) {
            this.buttomDisabled = true;
            this.loading = true;
            this.conversaCompleta = [];
            this.suggestions = true;

            this.fieldsChatIAUpdate[ID_FIELD.fieldApiName] = this.chatIAId;
            this.fieldsChatIAUpdate[ACTIVE_FIELD.fieldApiName] = false;

            const updateChatIA = {
                fields: this.fieldsChatIAUpdate
            };
            try {
                const data = await updateRecord(updateChatIA);
                this.chatIAId = 'null';
            } catch {
                this.notificarErro('Não foi possível encerrar a sessão.');
            }
            if (showToast != true) {
                try {
                    const response = await deleteChatById({ backupChat: this.backupChat });
                    this.dispatchEvent(new ShowToastEvent({
                        title: 'Sucesso',
                        message: 'Histórico deletado com sucesso.',
                        variant: 'success'
                    }));
                } catch {
                    this.notificarErro('Não foi possível excluir o histórico.');
                }
            }
        }
        this.buttomDisabled = false;
        this.loading = false;
        const input = this.template.querySelector('lightning-input[data-id="campoMensagem"]');
        setTimeout(() => input.focus());
    }
    likeButton(event) {
        this.conversaCompleta.forEach(mensagem => {
            if (mensagem.correlator === event.target.value && mensagem.css == '') {
                mensagem.css = '--slds-c-icon-color-foreground: #5C169D;margin-left: -20px;';
                this.correlator = event.target.value;
                mensagem.disableDislike = true;
                this.feedbackIsOpen = true;
                this.dislikeDisabled = true;
                this.feedbackValue = 'positive';
            }
        })
    }
    dislikeButton(event) {
        this.conversaCompleta.forEach(mensagem => {
            if (mensagem.correlator === event.target.value && mensagem.css == '') {
                mensagem.css = '--slds-c-icon-color-foreground: #5C169D;margin-left: -20px;';
                this.correlator = event.target.value;
                mensagem.disableLike = true;
                this.feedbackIsOpen = true;
                this.likeDisabled = true;
                this.feedbackValue = 'negative';
            }
        })
    }
    async armazenarMensagem() {
        try {
            let conversaParcial = [];
            conversaParcial.push(this.lastMensagemUser);
            conversaParcial.push(this.lastMensagemIA);
            this.buttomDisabled = false;
            if (this.chatIAId === 'null') {
                if (this.history != 'null') {
                    const newChat = await createNewChat({ chatList: JSON.stringify(conversaParcial) });
                    if (newChat) {
                        this.backupChat = newChat.x_id;
                    } else {
                        this.notificarErro('Não foi possível criar um novo chat.');
                    }
                } else {
                    const newChat = await createNewHistory({ chatList: JSON.stringify(conversaParcial) });
                    if (newChat) {
                        this.backupChat = newChat.x_id;
                    } else {
                        this.notificarErro('Não foi possível criar um novo histórico.');
                    }
                }
                this.fieldsChatIAInsert[USUARIO_FIELD.fieldApiName] = this.userId;
                this.fieldsChatIAInsert[BACKUP_FIELD.fieldApiName] = this.backupChat;
                this.fieldsChatIAInsert[ACTIVE_FIELD.fieldApiName] = true;
                this.fieldsChatIAInsert[HISTORY_FIELD.fieldApiName] = true;
                const createChatIA = {
                    apiName: CHATIA_OBJECT.objectApiName,
                    fields: this.fieldsChatIAInsert
                };

                const record = await createRecord(createChatIA);
                if (record) {
                    this.chatIAId = record.id;
                } else {
                    this.notificarErro('Não foi possível criar a sessão.');
                }
            }
            else {
                const data = await addConversation({ chatList: JSON.stringify(conversaParcial), backupChat: this.backupChat });
                if (!data) {
                    this.notificarErro('Não foi possível salvar o histórico da conversa.');
                }
            }
            const input = this.template.querySelector('lightning-input[data-id="campoMensagem"]');
            setTimeout(() => input.focus());
        } catch (error) {
            this.error(error.message);
        }
        this.lastMensagemIA = [];
        this.lastMensagemUser = [];
    }

    async sendMessage(event) {
        this.buttomDisabled = true;
        this.suggestions = false;
        let mensagemVar = event.target.value ? event.target.value : this.template.querySelector('lightning-input[data-id="campoMensagem"]').value;
        this.template.querySelector('lightning-input[data-id="campoMensagem"]').value = null;
        let mensagemUser = {
            mensagemUsuario: true,
            conteudoMensagem: mensagemVar,
            correlator: '',
            disableLike: false,
            disableDislike: false,
            css: '',
        }
        this.lastMensagemUser = mensagemUser;
        this.conversaCompleta.push(mensagemUser);
        this.dots = true;
        this.forceScroll();
        const integracaoQNA = await getIntegracaoQNA();
        if (integracaoQNA) {
            try {
                const response = await fetch(integracaoQNA.endpoint_qna + integracaoQNA.header_subscriptionId + '/' + mensagemVar, {
                    method: 'GET',
                    headers: {
                        'Content-Type': integracaoQNA.header_ContentType,
                        'token': integracaoQNA.header_token,
                        'user_id': integracaoQNA.header_userId,
                        'subscription_id': integracaoQNA.header_subscriptionId,
                        'Origin': integracaoQNA.header_Origin,
                        'User-Agent': integracaoQNA.header_UserAgent,
                        'service': integracaoQNA.header_service,
                        'user_name': integracaoQNA.header_userName,
                        'user_email': integracaoQNA.header_userEmail,
                        'session_id': integracaoQNA.header_sessionId,
                        'user_profile': integracaoQNA.header_userProfile
                    },
                });
                await this.appendStreamMessage(response);
            } catch (error) {
                this.notificarErro('Não foi possível obter resposta. - ' + error.message);
            }
        }
    }
    async appendStreamMessage(responseBody) {
        const loadingDotsString = '<span style="display: inline-block; width: 0.75em; height: 0.75em; border-radius: 50%; background-color: #ffffff; animation: spin 1s linear infinite;margin-top:1px"></span>'; 
        const decoder = new TextDecoder();
        const reader = responseBody.body.getReader();
        const correlator = responseBody.headers.get("correlator");
        const references = responseBody.headers.get("references");
        this.streamOff = false;
        let urlDocument = '';
        let firstUrl = true;
        if (references != '') {       
            let referencias = JSON.parse(references);
            referencias.forEach(reference => {
                if(firstUrl){
                    urlDocument += '<br><br>Referências:';
                }
                urlDocument += '<br><i><a href="' + reference.url + '"><font color=#80CEF9>'+ reference.filename +'.</a></i><br>';
                firstUrl = false;
            });
        }
        const velocidadeTypingEffect = 10;
        let mensagemIAConcatenada = '';
        let novaMensagem = true;
        try {
            while (true) {
                const { done, value } = await reader.read();
                if (done) {
                    this.streamOff = true;
                    return true;
                }
                let mensagem = decoder.decode(value);
                mensagem = mensagem.replace(/\n/g, "<br>")
                if (novaMensagem) {
                    this.dots = false;
                    let mensagemIA = {
                        mensagemUsuario: false,
                        conteudoMensagem: this.styleCSS,
                        correlator: correlator,
                        disableLike: true,
                        disableDislike: true,
                        css: '',
                    }
                    this.conversaCompleta.push(mensagemIA);
                    novaMensagem = false;
                }
                const ultimaMensagem = this.conversaCompleta[this.conversaCompleta.length - 1];
                this.concatenaMensagemTypingEffect += mensagem;
                mensagemIAConcatenada += mensagem;
                if (this.typingEffectOff) {
                    this.typingEffectOff = false;
                    let index = 0;
                    const typingInterval = setInterval(() => {
                        if (index < this.concatenaMensagemTypingEffect.length) {
                                ultimaMensagem.conteudoMensagem = ultimaMensagem.conteudoMensagem.replace(loadingDotsString, "");
                                ultimaMensagem.conteudoMensagem += this.concatenaMensagemTypingEffect[index];
                                ultimaMensagem.conteudoMensagem = ultimaMensagem.conteudoMensagem + loadingDotsString;
                                this.forceScroll();
                                index++;
                        } else {
                            this.concatenaMensagemTypingEffect = '';
                            this.typingEffectOff  = true;
                            ultimaMensagem.conteudoMensagem = ultimaMensagem.conteudoMensagem.replace(loadingDotsString, "");
                            if(this.streamOff){
                                ultimaMensagem.conteudoMensagem += urlDocument;
                                ultimaMensagem.disableLike = false;
                                ultimaMensagem.disableDislike = false;
                                this.forceScroll();
                                this.lastMensagemIA = ultimaMensagem;
                                this.armazenarMensagem();
                            }
                            clearInterval(typingInterval);
                        }
                    }, velocidadeTypingEffect);
                }
            }
        } catch (error) {
            this.notificarErro('Não foi possível obter resposta. - ' + error.message);
        }
    }
    notificarErro(mensagem){
        this.dots = false;
        this.loading = false;
        this.buttomDisabled = false;
        this.dispatchEvent(new ShowToastEvent({
            title: 'Erro',
            message: mensagem,
            variant: 'error'
        }));
    }
}