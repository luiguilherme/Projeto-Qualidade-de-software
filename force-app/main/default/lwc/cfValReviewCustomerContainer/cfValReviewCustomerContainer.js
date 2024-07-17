import { FlexCardMixin } from "vlocity_cmt/flexCardMixin";
    import { CurrentPageReference } from 'lightning/navigation';
    import {interpolateWithRegex, interpolateKeyValue, loadCssFromStaticResource } from "vlocity_cmt/flexCardUtility";
    
          import { LightningElement, api, track, wire } from "lwc";
          import pubsub from "vlocity_cmt/pubsub";
          import { getRecord } from "lightning/uiRecordApi";
          import { OmniscriptBaseMixin } from "vlocity_cmt/omniscriptBaseMixin";
          import data from "./definition";
          
          import styleDef from "./styleDefinition";
              
          export default class cfValReviewCustomerContainer extends FlexCardMixin(OmniscriptBaseMixin(LightningElement)){
              currentPageReference;        
              @wire(CurrentPageReference)
              setCurrentPageReference(currentPageReference) {
                this.currentPageReference = currentPageReference;
              }
              @api debug;
              @api recordId;
              @api objectApiName;
              @track _omniSupportKey = 'cfValReviewCustomerContainer';
                  @api get omniSupportKey() {
                    return this._omniSupportKey;
                  }
                  set omniSupportKey(parentRecordKey) {
                    this._omniSupportKey = this._omniSupportKey  + '_' + parentRecordKey;
                  }
              @track record;
              @track _sessionApiVars = {};
        @api set cfInteractionId(val) {
          if(typeof val !== "undefined") {
            this._sessionApiVars["InteractionId"] = val;
          }
        } get cfInteractionId() {
          return this._sessionApiVars["InteractionId"] || "undefined";
        }
      
        @api set cfLineNumber(val) {
          if(typeof val !== "undefined") {
            this._sessionApiVars["LineNumber"] = val;
          }
        } get cfLineNumber() {
          return this._sessionApiVars["LineNumber"] || "undefined";
        }
      
        @api set cfShowAssociateButton(val) {
          if(typeof val !== "undefined") {
            this._sessionApiVars["ShowAssociateButton"] = val;
          }
        } get cfShowAssociateButton() {
          return this._sessionApiVars["ShowAssociateButton"] || "undefined";
        }
      
        @api set cfProtocolNumber(val) {
          if(typeof val !== "undefined") {
            this._sessionApiVars["ProtocolNumber"] = val;
          }
        } get cfProtocolNumber() {
          return this._sessionApiVars["ProtocolNumber"] || "undefined";
        }
      
        @api set cfContextId(val) {
          if(typeof val !== "undefined") {
            this._sessionApiVars["ContextId"] = val;
          }
        } get cfContextId() {
          return this._sessionApiVars["ContextId"] || "undefined";
        }
      
        @api set cfButtonVariantCpf(val) {
          if(typeof val !== "undefined") {
            this._sessionApiVars["ButtonVariantCpf"] = val;
          }
        } get cfButtonVariantCpf() {
          return this._sessionApiVars["ButtonVariantCpf"] || "";
        }
      
        @api set cfButtonVariantEmail(val) {
          if(typeof val !== "undefined") {
            this._sessionApiVars["ButtonVariantEmail"] = val;
          }
        } get cfButtonVariantEmail() {
          return this._sessionApiVars["ButtonVariantEmail"] || "";
        }
      
        @api set cfMessagingCpf(val) {
          if(typeof val !== "undefined") {
            this._sessionApiVars["MessagingCpf"] = val;
          }
        } get cfMessagingCpf() {
          return this._sessionApiVars["MessagingCpf"] || "";
        }
      
        @api set cfMessagingEmail(val) {
          if(typeof val !== "undefined") {
            this._sessionApiVars["MessagingEmail"] = val;
          }
        } get cfMessagingEmail() {
          return this._sessionApiVars["MessagingEmail"] || "";
        }
      
        @api set cfDocType(val) {
          if(typeof val !== "undefined") {
            this._sessionApiVars["DocType"] = val;
          }
        } get cfDocType() {
          return this._sessionApiVars["DocType"] || "";
        }
      
        @api set cfHasEmail(val) {
          if(typeof val !== "undefined") {
            this._sessionApiVars["HasEmail"] = val;
          }
        } get cfHasEmail() {
          return this._sessionApiVars["HasEmail"] || "";
        }
      
        @api set cfTopicName(val) {
          if(typeof val !== "undefined") {
            this._sessionApiVars["TopicName"] = val;
          }
        } get cfTopicName() {
          return this._sessionApiVars["TopicName"] || "";
        }
      
              
              pubsubEvent = [];
              customEvent = [];
              
              connectedCallback() {
                super.connectedCallback();
                this.setThemeClass(data);
                this.setStyleDefinition(styleDef);
                data.Session = {} //reinitialize on reload
                
                
                
                this.setDefinition(data);
 this.registerEvents();
                
                
              }
              
              disconnectedCallback(){
                super.disconnectedCallback();
                    this.omniSaveState(this.records,this.omniSupportKey,true);
                    

                  this.unregisterEvents();
              }

              registerEvents() {
                
              }

              unregisterEvents(){
                
              }
            
              renderedCallback() {
                super.renderedCallback();
                
              }
          }