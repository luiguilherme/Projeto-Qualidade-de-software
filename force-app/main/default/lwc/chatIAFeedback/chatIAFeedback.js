import { LightningElement, track, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import sendFeedback from '@salesforce/apex/ChatIAController.sendFeedback';
import updateFeedback from '@salesforce/apex/ChatIAController.updateFeedback';
export default class ChatIAFeedback extends LightningElement {
    @api
    correlator
    @api
    feedback
    @api
    chatid
    @track
    isModalOpen
    @track
    titulo = '';
    @track
    placeholder='';
    @track
    mensagem = '';
    @track
    loading = false;
    @track
    questionario = false;
    @track
    conclusao = false;
    @track
    error = false;
    @track
    enviado = false;

    connectedCallback(){
        this.isModalOpen = true;
        this.questionario = true;
        this.verificaFeedback();
    }
    closeModal(event){
        this.isModalOpen = false;
        this.dispatchEvent(
            new CustomEvent('feedback', { detail: 'cancelado' })
          );
    }
    verificaFeedback(){
        if(this.feedback === 'positive'){
            this.titulo = 'Feedback Positivo';
            this.placeholder = 'O que você gosta na resposta?'
        }else{
            this.titulo = 'Feedback Negativo';
            this.placeholder = 'O que poderia melhorar na resposta?'
        }
    }
    handleChangeMensagem(event){
        this.mensagem = event.detail.value;
    }
    enviaRetorno(event){
        this.isModalOpen = false;
        let retorno = this.enviado === true? 'sucesso': 'cancelado';
        this.dispatchEvent(
            new CustomEvent('feedback', { detail: retorno })
          );
    }
    async enviaFeedback(event){
        try{
            this.questionario = false;
            this.loading = true;
            const data = await sendFeedback({
                correlator: this.correlator,
                feedback: this.feedback,
                message: this.mensagem
            });
            if(data){
                console.log(JSON.stringify(data));
                const historico = await updateFeedback({
                    correlator: this.correlator,
                    feedback: this.feedback,
                    chatId : this.chatid
                });
                if(historico){
                    this.loading = false;
                    this.conclusao = true;
                    this.enviado = true;
                    this.titulo = 'Feedback enviado!';
                }
            }
        } catch{
            this.conclusao = true;
            this.error = true;
            this.dispatchEvent(new ShowToastEvent({
                title: 'Erro',
                message: 'Não foi possível obter o histórico do chat.',
                variant: 'error'
            }));
        }
    }
}