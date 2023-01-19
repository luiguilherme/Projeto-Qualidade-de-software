import { FlexCardMixin } from "vlocity_cmt/flexCardMixin";
    import { CurrentPageReference } from 'lightning/navigation';
    import {interpolateWithRegex, interpolateKeyValue, loadCssFromStaticResource } from "vlocity_cmt/flexCardUtility";
    
          import { LightningElement, api, track, wire } from "lwc";
          import pubsub from "vlocity_cmt/pubsub";
          import { getRecord } from "lightning/uiRecordApi";
          
          import data from "./definition";
          
          import styleDef from "./styleDefinition";
              
          export default class cfValTopicsTreeConfigParms extends FlexCardMixin(LightningElement){
              currentPageReference;        
              @wire(CurrentPageReference)
              setCurrentPageReference(currentPageReference) {
                this.currentPageReference = currentPageReference;
              }
              @api debug;
              @api recordId;
              @api objectApiName;
              
              @track record;
              
              @track Label={ParametrosPalitoBtnAdicionar:"Adicionar",
        ParametrosPalitoBtnSalvar:"Salvar",
        ParametrosPalitoBtnCancelar:"Cancelar",
        ParametrosPalitoMsgClassificacaoDeveSerPreenchido:"O campo Classificação deve ser preenchido",
        ParametrosPalitoClassificacao:"Classificação",
        ParametrosPalitoNao:"Não",
        ParametrosPalitoSim:"Sim",
        ParametrosPalitoEnvioSMSEmail:"Envio SMS/Email",
        ParametrosPalitoNotificacoes:"Notificações",
        ParametrosPalitoIdentificacaoVivoNet:"Identificação VivoNet",
        ParametrosPalitoMsgIdentificacaoVivoNetDeveSerPreenchido:"O campo Identificação VivoNet deve ser preenchido",
        ParametrosPalitoMsgDescricaoDeveSerPreenchido:"O campo Descrição deve ser preenchido",
        ParametrosPalitoTipodeRelacionamento:"Tipo de Relacionamento",
        ParametrosPalitoPalito:"Palito",
        ParametrosPalitoPasta:"Pasta",
        ParametrosPalitoTipo:"Tipo",
        ParametrosPalitoDescricao:"Descrição",
        ParametrosPalitoMsgPalitoSalvocomSucesso:"adicionado com sucesso",
        ParametrosPalitoMsgErroaoSalvar:"Erro ao salvar. Por favor atualize a página"
        };
              pubsubEvent = [];
              customEvent = [];
              
              connectedCallback() {
                super.connectedCallback();
                this.setStyleDefinition(styleDef);
                data.Session = {} //reinitialize on reload
                
                
                this.customLabels = this.Label;
                      
                          this.fetchUpdatedCustomLabels();
                      
                this.setDefinition(data);
 this.registerEvents();
                
                
              }
              
              disconnectedCallback(){
                super.disconnectedCallback();
                    
                    

                  this.unregisterEvents();
              }

              registerEvents() {
                
        this.pubsubEvent[0] = {
          [interpolateWithRegex(`clearselection`,this._allMergeFields,this._regexPattern,"noparse")]: this.handleEventAction.bind(this, data.events[0],0)
        };
        this.pubsubChannel0 = interpolateWithRegex(`valtopicstreeitem`,this._allMergeFields,this._regexPattern,"noparse");
        pubsub.register(this.pubsubChannel0,this.pubsubEvent[0]);

              }

              unregisterEvents(){
                pubsub.unregister(this.pubsubChannel0,this.pubsubEvent[0]);

              }
            
              renderedCallback() {
                super.renderedCallback();
                
              }
          }