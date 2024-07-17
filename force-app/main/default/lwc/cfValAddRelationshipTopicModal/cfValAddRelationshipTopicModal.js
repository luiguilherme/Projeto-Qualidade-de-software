import { FlexCardMixin } from "vlocity_cmt/flexCardMixin";
    import { CurrentPageReference } from 'lightning/navigation';
    import {interpolateWithRegex, interpolateKeyValue, loadCssFromStaticResource } from "vlocity_cmt/flexCardUtility";
    
          import { LightningElement, api, track, wire } from "lwc";
          import pubsub from "vlocity_cmt/pubsub";
          import { getRecord } from "lightning/uiRecordApi";
          import { OmniscriptBaseMixin } from "vlocity_cmt/omniscriptBaseMixin";
          import data from "./definition";
          
          import styleDef from "./styleDefinition";
              
          export default class cfValAddRelationshipTopicModal extends FlexCardMixin(OmniscriptBaseMixin(LightningElement)){
              currentPageReference;        
              @wire(CurrentPageReference)
              setCurrentPageReference(currentPageReference) {
                this.currentPageReference = currentPageReference;
              }
              @api debug;
              @api recordId;
              @api objectApiName;
              @track _omniSupportKey = 'cfValAddRelationshipTopicModal';
                  @api get omniSupportKey() {
                    return this._omniSupportKey;
                  }
                  set omniSupportKey(parentRecordKey) {
                    this._omniSupportKey = this._omniSupportKey  + '_' + parentRecordKey;
                  }
              @track record;
              @track _sessionApiVars = {};
        @api set cfCustomerInteractionId(val) {
          if(typeof val !== "undefined") {
            this._sessionApiVars["CustomerInteractionId"] = val;
          }
        } get cfCustomerInteractionId() {
          return this._sessionApiVars["CustomerInteractionId"] || "undefined";
        }
      
        @api set cfChannel(val) {
          if(typeof val !== "undefined") {
            this._sessionApiVars["Channel"] = val;
          }
        } get cfChannel() {
          return this._sessionApiVars["Channel"] || "undefined";
        }
      
        @api set cfOrderId(val) {
          if(typeof val !== "undefined") {
            this._sessionApiVars["OrderId"] = val;
          }
        } get cfOrderId() {
          return this._sessionApiVars["OrderId"] || "undefined";
        }
      
        @api set cfAccountId(val) {
          if(typeof val !== "undefined") {
            this._sessionApiVars["AccountId"] = val;
          }
        } get cfAccountId() {
          return this._sessionApiVars["AccountId"] || "undefined";
        }
      
        @api set cfAssetId(val) {
          if(typeof val !== "undefined") {
            this._sessionApiVars["AssetId"] = val;
          }
        } get cfAssetId() {
          return this._sessionApiVars["AssetId"] || "undefined";
        }
      
        @api set cfLineNumber(val) {
          if(typeof val !== "undefined") {
            this._sessionApiVars["LineNumber"] = val;
          }
        } get cfLineNumber() {
          return this._sessionApiVars["LineNumber"] || "";
        }
      
        @api set cfSourceCalled(val) {
          if(typeof val !== "undefined") {
            this._sessionApiVars["SourceCalled"] = val;
          }
        } get cfSourceCalled() {
          return this._sessionApiVars["SourceCalled"] || "undefined";
        }
      
        @api set cfInteractionNumber(val) {
          if(typeof val !== "undefined") {
            this._sessionApiVars["InteractionNumber"] = val;
          }
        } get cfInteractionNumber() {
          return this._sessionApiVars["InteractionNumber"] || "undefined";
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
                
        this.pubsubEvent[0] = {
          [interpolateWithRegex(`Selected`,this._allMergeFields,this._regexPattern,"noparse")]: this.handleEventAction.bind(this, data.events[0],0),
[interpolateWithRegex(`clearselection`,this._allMergeFields,this._regexPattern,"noparse")]: this.handleEventAction.bind(this, data.events[1],1)
        };
        this.pubsubChannel0 = interpolateWithRegex(`valAddRelationshipTopicModal`,this._allMergeFields,this._regexPattern,"noparse");
        pubsub.register(this.pubsubChannel0,this.pubsubEvent[0]);

              }

              unregisterEvents(){
                pubsub.unregister(this.pubsubChannel0,this.pubsubEvent[0]);

              }
            
              renderedCallback() {
                super.renderedCallback();
                
              }
          }