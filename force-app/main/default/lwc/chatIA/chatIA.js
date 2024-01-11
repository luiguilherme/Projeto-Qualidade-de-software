import { LightningElement, track, api } from 'lwc';
import { NavigationMixin } from "lightning/navigation";
import { createRecord, updateRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

import userId from "@salesforce/user/Id";
import LightningConfirm from 'lightning/confirm';
import logoChatIA from '@salesforce/resourceUrl/LogoChatIA';
import getSessionId from '@salesforce/apex/ChatIAController.getSessionId';
import getQuestionSuggestion from '@salesforce/apex/ChatIAController.getQuestionSuggestion';
import getChatById from '@salesforce/apex/ChatIAController.getChatById';
import createNewChat from '@salesforce/apex/ChatIAController.createNewChat';
import addConversation from '@salesforce/apex/ChatIAController.AddConversation';
import deleteChatById from '@salesforce/apex/ChatIAController.deleteChatById';
import getQNAAnswer from '@salesforce/apex/ChatIAController.getQNAAnswer';
import getPermission from '@salesforce/apex/ChatIAController.getPermission';

import CHATIA_OBJECT from "@salesforce/schema/ChatIA__c";
import ID_FIELD from "@salesforce/schema/ChatIA__c.Id";
import BACKUP_FIELD from "@salesforce/schema/ChatIA__c.Backup__c";
import USUARIO_FIELD from "@salesforce/schema/ChatIA__c.Usuario__c";
import ACTIVE_FIELD from "@salesforce/schema/ChatIA__c.Active__c";

export default class ChatIA extends NavigationMixin(LightningElement) {
    @track userId = userId;
    @track backupChat;
    @track chatIAId;
    @track mensagemInput;
    @track conversaCompleta = [];
    @track questionSuggestions = [];
    
    @track fieldsChatIAInsert = {};
    @track fieldsChatIAUpdate = {};
    
    //variáveis de controle
    @track thereIsPermission = true;
    @track loading = false;
    @track isOpen = false;
    @track buttomDisabled = false;
    @track suggestions = false;
    @track tabIndex = '-1';
    @track heigthSize = 'height:98%';
    @track roleARIA = '';
    
    styleCSS = '<p style=\"align-items: flex-start; background-color: var(--colorIA, #660099); color: #ffffff; margin-left: -40px\; border-radius: 1.15rem; line-height: 1.25; max-width: 75%; padding: 0.5rem .875rem; position: relative; word-wrap: break-word">'

    connectedCallback(){
        let size = (window.screen.height *0.7) -110;
        this.heigthSize = 'height:'+ size.toString() +'px';
        this.verifyPermission();
    }
    
    @api
    forceScroll(){
        if(this.thereIsPermission){
            setTimeout(() => {
                const inputScroll = this.template.querySelector('[data-id="scrollable"]');
                const input = this.template.querySelector('lightning-input[data-id="campoMensagem"]');
                console.log(input + ' input');
                inputScroll.scrollTop = inputScroll.scrollHeight;
                input.focus();
            })
        }
    }
    async verifyPermission(){
        try{
            const data = await getPermission();
            this.thereIsPermission = data;
            if(this.thereIsPermission === true){
                this.getQuestions();
                this.startSessionId();
            }
        } catch{
            this.thereIsPermission = false;
        }
    }
    async getQuestions(){
        try{
            const data = await getQuestionSuggestion();
            this.questionSuggestions = data;
            this.suggestions = true;
        } catch{
            this.thereIsPermission = false;
            this.dispatchEvent(new ShowToastEvent({
            title: 'Erro',
            message: 'Não foi possível obter as sugestões de perguntas.',
            variant: 'error'
            }));
        }
    }
    
    async startSessionId(){
        try{
            const data = await getSessionId();
            for (let key in data) {
                this.backupChat = key;
                this.chatIAId = data[key];
            }
            if(this.chatIAId === 'null'){
                this.fieldsChatIAInsert[USUARIO_FIELD.fieldApiName] = this.userId;
                this.fieldsChatIAInsert[ACTIVE_FIELD.fieldApiName] = true;
                this.roleARIA = 'alert';
            } else{
                this.getChatHistory();
            }
            this.tabIndex = '0';
        }catch {
            this.dispatchEvent(new ShowToastEvent({
                title: 'Erro',
                message: 'Não foi possível obter a sessão ativa.',
                variant: 'error'
            }));
        }
    }

    async getChatHistory(){
        this.loading = true;
        try{
            const data = await getChatById({backupChat: this.backupChat});
            if(data.chatFound){
                data.history.forEach(hist => {
                    let mensagemUser = {
                        mensagemUsuario: hist.type === 'user' ? true : false,
                        conteudoMensagem: hist.message,
                    }
            
                    this.conversaCompleta.push(mensagemUser);
                });
                this.suggestions = false;
            } else{
                let closeConfirmModal = true;
                this.clearHistory(closeConfirmModal);
            }
        } catch{
            this.dispatchEvent(new ShowToastEvent({
                title: 'Erro',
                message: 'Não foi possível obter o histórico do chat.',
                variant: 'error'
            }));
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

    questionInput(event){
        if(event.keyCode === 13){
            this.armazenarMensagem(event);
          }
    }

    async armazenarMensagem(event){
        try{
            this.buttomDisabled = true;
            this.loading = true;
            this.suggestions = false;
            let mensagemVar = event.target.value ? event.target.value : this.template.querySelector('lightning-input[data-id="campoMensagem"]').value;
            this.template.querySelector('lightning-input[data-id="campoMensagem"]').value = null;
    
            let mensagemUser = {
                mensagemUsuario: true,
                conteudoMensagem: mensagemVar,
            }
    
            this.conversaCompleta.push(mensagemUser);

            const data = await getQNAAnswer({question: mensagemVar});
            if(data){
                let urlDocument = '';
                let firstUrl = true;
                data.supporting_snippets.forEach(snippets => {
                    if(firstUrl){
                        urlDocument += '<br><br>Referências:';
                    }
                    urlDocument += '<br><i><a href="' + snippets.document.url + '"><font color=#80CEF9>'+ snippets.document.name +'.</a></i><br>';
                    firstUrl = false;
                });
                let mensagemIA = {
                    mensagemUsuario: false,
                    conteudoMensagem: this.styleCSS + data.content + urlDocument,
                }
                
                let conversaParcial = [];
    
                if(this.chatIAId === 'null'){
                    conversaParcial.push(mensagemUser);
                    conversaParcial.push(mensagemIA);
                    const newChat = await createNewChat({chatList: JSON.stringify(conversaParcial)});
                    if(newChat){
                        this.backupChat = newChat.x_id;
                    } else{
                        this.dispatchEvent(new ShowToastEvent({
                            title: 'Erro',
                            message: 'Não foi possível criar a sessão.',
                            variant: 'error'
                        }));
                    }
                    
                    this.fieldsChatIAInsert[USUARIO_FIELD.fieldApiName] = this.userId;
                    this.fieldsChatIAInsert[BACKUP_FIELD.fieldApiName] = this.backupChat;
                    this.fieldsChatIAInsert[ACTIVE_FIELD.fieldApiName] = true;
                    const createChatIA = {
                        apiName: CHATIA_OBJECT.objectApiName,
                        fields: this.fieldsChatIAInsert
                    };
                    
                    const record = await createRecord(createChatIA);
                    if(record){
                        this.chatIAId = record.id;
                    }else {
                        this.dispatchEvent(new ShowToastEvent({
                            title: 'Erro',
                            message: 'Não foi possível criar a sessão.',
                            variant: 'error'
                        }));
                    }
                } else {
                    conversaParcial.push(mensagemUser);
                    conversaParcial.push(mensagemIA);
    
                    const data = await addConversation({chatList: JSON.stringify(conversaParcial), backupChat: this.backupChat});
                    if(!data){
                        this.dispatchEvent(new ShowToastEvent({
                            title: 'Erro',
                            message: 'Não foi possível salvar o histórico da conversa.',
                            variant: 'error'
                        }));
                    } 
                }
                this.conversaCompleta.push(mensagemIA);
                setTimeout(() => {
                    this.loading = false;
                    const inputScroll = this.template.querySelector('[data-id="scrollable"]');
                    inputScroll.scrollTop = inputScroll.scrollHeight;
                    this.buttomDisabled = false;
                })
                
            }else{
                this.dispatchEvent(new ShowToastEvent({
                    title: 'Erro',
                    message: 'Alguma coisa deu errado. Tente novamente ou contate nosso time de suporte para solicitar ajuda.',
                    variant: 'error'
                }));
            }
            
    
            const input = this.template.querySelector('lightning-input[data-id="campoMensagem"]');
            setTimeout(() => input.focus());

        }catch{
            this.loading = false;
            this.buttomDisabled = false;
            this.dispatchEvent(new ShowToastEvent({
                title: 'Erro',
                message: 'Não foi possível obter resposta.',
                variant: 'error'
            }));
        }
    }
    
    
    async clearHistory(closeConfirmModal){
        let result;
        if(closeConfirmModal != true){
                result = await LightningConfirm.open({
                message: "Deseja deletar o histórico do chat?",
                variant: "headerless",
                label: "Deletar histórico",
                theme: 'info'
            });
        }

        if(result || closeConfirmModal == true){
            this.buttomDisabled = true;
            this.loading = true;
            this.conversaCompleta = [];
            this.suggestions = true;
    
            this.fieldsChatIAUpdate[ID_FIELD.fieldApiName] = this.chatIAId;
            this.fieldsChatIAUpdate[ACTIVE_FIELD.fieldApiName] = false;
    
            const updateChatIA =  {
                fields: this.fieldsChatIAUpdate
            };
    
            try{
                const data = await updateRecord(updateChatIA);
                this.chatIAId = 'null';
            }catch {
                this.dispatchEvent(new ShowToastEvent({
                    title: 'Erro',
                    message: 'Não foi possível encerrar a sessão.',
                    variant: 'error'
                }));
            }
            if(closeConfirmModal != true){
                try{
                    const response = await deleteChatById({backupChat: this.backupChat});
                    this.dispatchEvent(new ShowToastEvent({
                        title: 'Sucesso',
                        message: 'Histórico deletado com sucesso.',
                        variant: 'success'
                    }));
                }catch {
                    this.dispatchEvent(new ShowToastEvent({
                        title: 'Erro',
                        message: 'Não foi possível excluir o histórico.',
                        variant: 'error'
                    }));
                }
            }
        }

        this.buttomDisabled = false;
        this.loading = false;
        const input = this.template.querySelector('lightning-input[data-id="campoMensagem"]');
        setTimeout(() => input.focus());
    }
   
}