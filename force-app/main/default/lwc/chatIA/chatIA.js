import { LightningElement, track, api } from 'lwc';
import { NavigationMixin } from "lightning/navigation";
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import userId from "@salesforce/user/Id";
import logoChatIA from '@salesforce/resourceUrl/LogoChatIA';
import getQuestionSuggestion from '@salesforce/apex/ChatIAController.getQuestionSuggestion';
import getChatById from '@salesforce/apex/ChatIAController.getChatById';
import deleteChatById from '@salesforce/apex/ChatIAController.deleteChatById';
import getPermission from '@salesforce/apex/ChatIAController.getPermission';
import getIntegracaoQNA from '@salesforce/apex/ChatIAController.getIntegracaoQNA';
import getConfig from '@salesforce/apex/ChatIAController.getConfig';


export default class ChatIA extends NavigationMixin(LightningElement) {
    @track userId = userId;
    @track mensagemInput;
    @track correlator;
    @track correlatorFeedback = '';
    @track feedbackValue;
    @track conversaCompleta = [];
    @track questionSuggestions = [];
    @track lixeiraIsOpen = false;
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
    @track inputValue = '';
    @track windowScreenHeight = 0;
    @track words = true;
    @track letters = false;
    @track quantify = 2;
    @track _timeout = 0;
    @track enter = true;

    height = 110;
    styleCSS = '<p style=\"align-items: flex-start; background-color: var(--colorIA, #5C169D); color: #ffffff; margin-left: -40px\; border-radius: 1.15rem; line-height: 1.25; max-width: 75%; padding: 0.5rem .875rem; position: relative; word-wrap: break-word">'
    connectedCallback() {
        this.updateHeight();
        this.verifyPermission();
        this.autocompleteSettings();
    }
    updateHeight() {
        if (this.windowScreenHeight !== window.innerHeight) {
            this.windowScreenHeight = window.innerHeight;
            let size = (this.windowScreenHeight * 0.825) - this.height;
            this.heigthSize = 'height:' + size.toString() + 'px';
        }
    }
    async autocompleteSettings() {
        try{
            let config = await getConfig();
            if(config){
                this.words = config.words;
                this.letters = config.letters;
                this.quantify = config.quantify;
            }
        }catch(error){
            console.log(error);
        }
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
                this.getChatHistory();
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
    async getChatHistory() {
        this.loading = true;
        try {
            const data = await getChatById();
    
            // Verifica se a resposta é válida e contém o histórico
            if (data && data.response === true && Array.isArray(data.history)) {
                data.history.forEach(hist => {
                    let historicoBr = hist.response.replace(/\\n/g, '<br>');
                    let historicoTratado = historicoBr.replace(/"/g, '');
                    let mensagemIA = {
                        mensagemUsuario: false,
                        conteudoMensagem: this.styleCSS + historicoTratado,
                        correlator: hist.correlator,
                        disableLike: false,
                        disableDislike: false,
                        css: '',
                    };
                    
                    if (hist.feedback === 'positive') {
                        mensagemIA.disableDislike = true;
                        mensagemIA.css = '--slds-c-icon-color-foreground: #5C169D;margin-left: -20px;';
                    }
                    
                    if (hist.feedback === 'negative') {
                        mensagemIA.disableLike = true;
                        mensagemIA.css = '--slds-c-icon-color-foreground: #5C169D;margin-left: -20px;';
                    }
    
                    let conteudoMensagem = hist.message;
                    let regex = /--- PERGUNTA ([\s\S]*?).\\n/;
                    let match = conteudoMensagem.match(regex);
                    let mensagemFinal = '';
    
                    if (match) {
                        mensagemFinal = match[1].trim();
                    } else {
                        mensagemFinal = "Mensagem não encontrada.";
                    }
    
                    let mensagemUser = {
                        mensagemUsuario: true,
                        conteudoMensagem: mensagemFinal,
                        correlator: null,
                        disableLike: false,
                        disableDislike: false,
                        css: '',
                    };
    
                    this.conversaCompleta.push(mensagemUser);
                    this.conversaCompleta.push(mensagemIA);
    
                    if (this.suggestions === true) {
                        this.suggestions = false;
                    }                         
                });
            } else {
                // Exibe o erro retornado pela API
                this.notificarErro(`Erro ao obter histórico: ${data.message}`);
            }
        } catch (error) {
            // Exibe erros inesperados
            this.notificarErro('Não foi possível obter o histórico de chat. ' + error.message);
        }
        this.loading = false;
        setTimeout(() => {
            const inputScroll = this.template.querySelector('[data-id="scrollable"]');
            inputScroll.scrollTop = inputScroll.scrollHeight;
        });
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
            if (showToast != true) {
                try {
                    const response = await deleteChatById();
                    if(response.response){
                            this.dispatchEvent(new ShowToastEvent({
                            title: 'Sucesso',
                            message: 'Histórico deletado com sucesso.',
                            variant: 'success'
                        }));
                    }else{
                        this.notificarErro('Não foi possível excluir o histórico. ' + response.code + ' - ' + response.message);
                    }
                } catch (error) {
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
    handleInputChange(event) {
        this.enter = true;
        clearTimeout(this._timeout)
        this.inputValue = event.target.value;
        this._timeout = setTimeout(() => this.postSuggestions(), 300);
    }
    postSuggestions(){
        if(this.enter){
            if (this.words) {
                let regex = / (?=\S)/g;
                let matches = this.inputValue.match(regex);
                if(matches){
                    if (matches.length >= this.quantify) {
                        this.template.querySelector('c-chat-i-a-suggestions').updateSuggestions(this.inputValue);
                    } else {
                        this.template.querySelector('c-chat-i-a-suggestions').closeSuggestion();
                    }
                }else {
                    this.template.querySelector('c-chat-i-a-suggestions').closeSuggestion();
                } 
            } else {
                if (this.inputValue.length >= this.quantify) {
                    this.template.querySelector('c-chat-i-a-suggestions').updateSuggestions(this.inputValue);
                } else {
                    this.template.querySelector('c-chat-i-a-suggestions').closeSuggestion();
                }
            }
        }
    }
    handleInputInsert(event) {
        this.mensagemInput = event.detail;
        this.template.querySelector('lightning-input[data-id="campoMensagem"]').focus();
    }
    async sendMessage(event) {
        this.template.querySelector('c-chat-i-a-suggestions').closeSuggestion();
        this.enter = false;
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
        let mensagemVarEncoded = encodeURIComponent(mensagemVar);
        this.dots = true;
        this.forceScroll();
        const integracaoQNA = await getIntegracaoQNA();     
        if (integracaoQNA) {
            try {
                const response = await fetch(integracaoQNA.endpoint_qna + integracaoQNA.header_subscriptionId + '/' + mensagemVarEncoded, {
                    method: 'GET',
                    headers: {
                        'Content-Type': integracaoQNA.header_ContentType,
                        'token':  integracaoQNA.header_token,
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
                if (!response.ok) {
                    throw new Error(`Status: ${response.status} - ${response.statusText}`);
                }
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
                if (firstUrl) {
                    urlDocument += '<br><br>Referências:';
                }
                urlDocument += '<br><i><a href="' + reference.url + '"><font color=#80CEF9>' + reference.filename + '.</a></i><br>';
                firstUrl = false;
            });
        }
        const velocidadeTypingEffect = 2;
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
                            this.typingEffectOff = true;
                            ultimaMensagem.conteudoMensagem = ultimaMensagem.conteudoMensagem.replace(loadingDotsString, "");
                            if (this.streamOff) {
                                ultimaMensagem.conteudoMensagem += urlDocument;
                                ultimaMensagem.disableLike = false;
                                ultimaMensagem.disableDislike = false;
                                this.forceScroll();
                                this.buttomDisabled = false;
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
    notificarErro(mensagem) {
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