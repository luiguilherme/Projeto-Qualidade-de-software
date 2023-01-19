import { FlexCardMixin } from "vlocity_cmt/flexCardMixin";
    import { CurrentPageReference } from 'lightning/navigation';
    import {interpolateWithRegex, interpolateKeyValue, loadCssFromStaticResource } from "vlocity_cmt/flexCardUtility";
    
          import { LightningElement, api, track, wire } from "lwc";
          import pubsub from "vlocity_cmt/pubsub";
          import { getRecord } from "lightning/uiRecordApi";
          import { OmniscriptBaseMixin } from "vlocity_cmt/omniscriptBaseMixin";
          import data from "./definition";
          
          import styleDef from "./styleDefinition";
              
          export default class cfValTopicsTreeFilterParms extends FlexCardMixin(OmniscriptBaseMixin(LightningElement)){
              currentPageReference;        
              @wire(CurrentPageReference)
              setCurrentPageReference(currentPageReference) {
                this.currentPageReference = currentPageReference;
              }
              @api debug;
              @api recordId;
              @api objectApiName;
              @track _omniSupportKey = 'cfValTopicsTreeFilterParms';
                  @api get omniSupportKey() {
                    return this._omniSupportKey;
                  }
                  set omniSupportKey(parentRecordKey) {
                    this._omniSupportKey = this._omniSupportKey  + '_' + parentRecordKey;
                  }
              @track record;
              @track _sessionApiVars = {};
              @track Label={VisualizacaoFiltrosMsgErroaoSalvar:"Erro ao salvar. Por favor atualize a página",
        VisualizacaoFiltrosMsgFiltrosSalvoscomSucesso:"Filtros salvos com sucesso",
        VisualizacaoFiltrosEscolhaosCanais:"Escolha os Canais",
        VisualizacaoFiltrosCanal:"Canal",
        VisualizacaoFiltrosCanaisAssociados:"Canais Associados",
        VisualizacaoFiltrosCanaisExistentes:"Canais Existentes",
        VisualizacaoFiltrosEscolhaosTiposdeClientes:"Escolha os Tipos de Clientes",
        VisualizacaoFiltrosTipodeCliente:"Tipo de Cliente",
        VisualizacaoFiltrosTiposdeClientesAssociados:"Tipos de Clientes Associados",
        VisualizacaoFiltrosTiposdeClientesExistentes:"Tipos de Clientes Existentes",
        VisualizacaoFiltrosEscolhaosTiposdeLinhas:"Escolha os Tipos de Linhas",
        VisualizacaoFiltrosTipodeLinha:"Tipo de Linha",
        VisualizacaoFiltrosTiposdeLinhasAssociadas:"Tipos de Linhas Associadas",
        VisualizacaoFiltrosTiposdeLinhasExistentes:"Tipos de Linhas Existentes",
        VisualizacaoFiltrosEscolhaasSegmentacoes:"Escolha as Segmentações",
        VisualizacaoFiltrosSegmentacao:"Segmentação",
        VisualizacaoFiltrosSegmentacoesAssociadas:"Segmentações Associadas",
        VisualizacaoFiltrosSegmentacoesExistentes:"Segmentações Existentes",
        VisualizacaoFiltrosEscolhaosTiposdeCarteiras:"Escolha os Tipos de Carteiras",
        VisualizacaoFiltrosCarteiras:"Carteiras",
        VisualizacaoFiltrosTiposdeCarteirasAssociadas:"Tipos de Carteiras Associadas",
        VisualizacaoFiltrosTiposdeCarteirasExistentes:"Tipos de Carteiras Existentes",
        VisualizacaoFiltrosEscolhaasInstancias:"Escolha as Instâncias",
        VisualizacaoFiltrosInstancia:"Instância",
        VisualizacaoFiltrosInstanciasAssociadas:"Instâncias Associadas",
        VisualizacaoFiltrosInstanciasExistentes:"Instâncias Existentes",
        VisualizacaoFiltrosEscolhaosSegmentos:"Escolha os Segmentos do Operador",
        VisualizacaoFiltrosSegmentoOperador:"Segmento do Operador",
        VisualizacaoFiltrosSegmentosOperadorAssociados:"Segmento do Operador Associados",
        VisualizacaoFiltrosSegmentoOperadorExistentes:"Segmento do Operador Existentes",
        VisualizacaoFiltrosEscolhaosVisivelPara:"Escolha para quem deverá ser visível",
        VisualizacaoFiltrosVisivelPara:"Visível Para",
        VisualizacaoFiltrosVisivelParaAssociados:"Visível para Associados",
        VisualizacaoFiltrosVisivelParaExistentes:"Visível para Existentes",
        VisualizacaoFiltrosBtnCancelar:"Cancelar",
        VisualizacaoFiltrosBtnSalvar:"Salvar"
        };
              pubsubEvent = [];
              customEvent = [];
              
              connectedCallback() {
                super.connectedCallback();
                this.setThemeClass(data);
                this.setStyleDefinition(styleDef);
                data.Session = {} //reinitialize on reload
                
                
                this.customLabels = this.Label;
                      
                          this.fetchUpdatedCustomLabels();
                      
                this.setDefinition(data);
 this.registerEvents();
                
                
              }
              
              disconnectedCallback(){
                super.disconnectedCallback();
                    this.omniSaveState(this.records,this.omniSupportKey,true);
                    

                  this.unregisterEvents();
              }

              registerEvents() {
                
        this.pubsubEvent[0] = {
          [interpolateWithRegex(`channels`,this._allMergeFields,this._regexPattern,"noparse")]: this.handleEventAction.bind(this, data.events[0],0),
[interpolateWithRegex(`customertypes`,this._allMergeFields,this._regexPattern,"noparse")]: this.handleEventAction.bind(this, data.events[1],1),
[interpolateWithRegex(`portfolios`,this._allMergeFields,this._regexPattern,"noparse")]: this.handleEventAction.bind(this, data.events[2],2),
[interpolateWithRegex(`segmentations`,this._allMergeFields,this._regexPattern,"noparse")]: this.handleEventAction.bind(this, data.events[3],3),
[interpolateWithRegex(`linestypes`,this._allMergeFields,this._regexPattern,"noparse")]: this.handleEventAction.bind(this, data.events[4],4),
[interpolateWithRegex(`instance`,this._allMergeFields,this._regexPattern,"noparse")]: this.handleEventAction.bind(this, data.events[5],5),
[interpolateWithRegex(`operatorsegment`,this._allMergeFields,this._regexPattern,"noparse")]: this.handleEventAction.bind(this, data.events[6],6),
[interpolateWithRegex(`visibleto`,this._allMergeFields,this._regexPattern,"noparse")]: this.handleEventAction.bind(this, data.events[7],7)
        };
        this.pubsubChannel0 = interpolateWithRegex(`updatelistfilterparms`,this._allMergeFields,this._regexPattern,"noparse");
        pubsub.register(this.pubsubChannel0,this.pubsubEvent[0]);

              }

              unregisterEvents(){
                pubsub.unregister(this.pubsubChannel0,this.pubsubEvent[0]);

              }
            
              renderedCallback() {
                super.renderedCallback();
                
              }
          }