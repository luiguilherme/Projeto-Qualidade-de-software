import { LightningElement, track, api } from 'lwc';
import getIntegracaoSuggestions from '@salesforce/apex/ChatIAController.getIntegracaoSuggestions';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class ChatIASuggestions extends LightningElement {
    @track inputValue = '';
    @track suggestions = [];
    @track showSuggestions = false;
    @track heigthSize = 0;
    @track token = '';
    @track user_id = '';
    @track subscription_id = '';
    @track user_Agent = '';
    @track service = '';
    @track session_id = '';
    @track content_type = '';
    @track endpoint = '';
    @track integracao = false;
    @track windowHight = window.innerHeight;
    async getSuggestions(inputValue) {
        try {
            const controller = new AbortController();
            const signal = controller.signal;
            const timeout = 3100; // Tempo máximo de espera (em milissegundos)
            if (this.integracao === false) {
                this.integracao = true;
                this.showSuggestions = false;
                this.suggestions = [];
                const timer = setTimeout(() => {
                    controller.abort(); // Aborta a requisição após o timeout
                }, timeout);
                const response = await fetch(this.endpoint + inputValue, {
                    method: 'GET',
                    headers: {
                        'Content-Type': this.content_type,
                        'token': this.token,
                        'user_id': this.user_id,
                        'subscription_id': this.subscription_id,
                        'User-Agent': this.user_Agent,
                        'service': this.service,
                        'session_id': this.session_id
                    },
                    signal // Passa o sinal para o fetch
                });
                clearTimeout(timer); // Cancela o timer se a requisição for bem-sucedida
                if (response.ok) {
                    const data = await response.json();
                    if (data) {
                        data.questions.forEach(suggestionObj => {
                            this.suggestions.push(suggestionObj.suggestion);
                        });
                        if (this.suggestions.length === 1) {
                            this.heightUpdate(92);
                        } else if (this.suggestions.length === 2) {
                            this.heightUpdate(122);
                        } else {
                            this.heightUpdate(152);
                        }
                        this.showSuggestions = this.suggestions.length > 0;
                        this.integracao = false;
                    }
                } else {
                    if (response.status === 401) {
                        let getParametros = await this.getParametrosIntegracao();
                        if (getParametros) {
                            this.getSuggestions(inputValue); // Chama o método novamente para revalidar parâmetros
                        }
                    } else {
                       this.notificarErro(`Status: ${response.status} - ${response.statusText}`);
                       this.suggestions = [];
                       this.showSuggestions = false;
                    }
                }
            }
        } catch (error) {
            if (error.name === 'AbortError') {
                console.log('Requisição abortada: tempo de espera excedido');
            } else {
                console.log(error.message);
            }
                this.suggestions = [];
                this.showSuggestions = false;
        } finally {
            this.integracao = false; // Garante que a flag seja resetada no final
        }
    }
    async getParametrosIntegracao() {
        try {
            const integracaoSuggestions = await getIntegracaoSuggestions();
            if (integracaoSuggestions) {
                this.content_type = integracaoSuggestions.header_ContentType;
                this.token = integracaoSuggestions.header_token;
                this.user_id = integracaoSuggestions.header_userId;
                this.subscription_id = integracaoSuggestions.header_subscriptionId;
                this.user_Agent = integracaoSuggestions.header_UserAgent;
                this.service = integracaoSuggestions.header_service;
                this.session_id = integracaoSuggestions.header_sessionId;
                this.endpoint = integracaoSuggestions.endpoint_qna;
                return true;
            }
        } catch (error) {
            this.notificarErro('Não foi possível obter sugestões. - ' + error.message);
        }
    }
    @api
    async updateSuggestions(inputValue) {
        if (this.token !== '') {
            this.getSuggestions(inputValue);
        }
        else {
            let getParametros = await this.getParametrosIntegracao();
            if (getParametros) {
                this.getSuggestions(inputValue);
            }
        }
    }
    @api
    closeSuggestion() {
        this.showSuggestions = false;
    }
    heightUpdate(height) {
        let size = (this.windowHight * 0.825) - height;
        this.heigthSize = 'top:' + size.toString() + 'px';
    }
    handleInputClick() {
        this.showSuggestions = this.suggestions.length > 0;
    }

    handleSuggestionClick(event) {
        this.inputValue = event.target.innerText;
        this.showSuggestions = false;
        this.dispatchEvent(
            new CustomEvent('autocomplete', { detail: this.inputValue })
        );
    }
    connectedCallback() {
        let size = (window.innerHeight * 0.825) - 152;
        this.heigthSize = 'top:' + size.toString() + 'px';
    }

    disconnectedCallback() {
        document.removeEventListener('click', this.handleDocumentClick.bind(this));
    }

    handleDocumentClick(event) {
            this.showSuggestions = false;
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