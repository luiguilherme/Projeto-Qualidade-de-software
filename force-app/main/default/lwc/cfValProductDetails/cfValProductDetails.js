import { FlexCardMixin } from "vlocity_cmt/flexCardMixin";
    import { CurrentPageReference } from 'lightning/navigation';
    import {interpolateWithRegex, interpolateKeyValue, loadCssFromStaticResource } from "vlocity_cmt/flexCardUtility";
    
          import { LightningElement, api, track, wire } from "lwc";
          import pubsub from "vlocity_cmt/pubsub";
          import { getRecord } from "lightning/uiRecordApi";
          import { OmniscriptBaseMixin } from "vlocity_cmt/omniscriptBaseMixin";
          import data from "./definition";
          
          import styleDef from "./styleDefinition";
              
          export default class cfValProductDetails extends FlexCardMixin(OmniscriptBaseMixin(LightningElement)){
              currentPageReference;        
              @wire(CurrentPageReference)
              setCurrentPageReference(currentPageReference) {
                this.currentPageReference = currentPageReference;
              }
              @api debug;
              @api recordId;
              @api objectApiName;
              @track _omniSupportKey = 'cfValProductDetails';
                  @api get omniSupportKey() {
                    return this._omniSupportKey;
                  }
                  set omniSupportKey(parentRecordKey) {
                    this._omniSupportKey = this._omniSupportKey  + '_' + parentRecordKey;
                  }
              @track record;
              @track _sessionApiVars = {};
        @api set cfAssetId(val) {
          if(typeof val !== "undefined") {
            this._sessionApiVars["AssetId"] = val;
          }
        } get cfAssetId() {
          return this._sessionApiVars["AssetId"] || "";
        }
      
        @api set cfSourceComponent(val) {
          if(typeof val !== "undefined") {
            this._sessionApiVars["SourceComponent"] = val;
          }
        } get cfSourceComponent() {
          return this._sessionApiVars["SourceComponent"] || "";
        }
      
        @api set cfAccountId(val) {
          if(typeof val !== "undefined") {
            this._sessionApiVars["AccountId"] = val;
          }
        } get cfAccountId() {
          return this._sessionApiVars["AccountId"] || "";
        }
      
        @api set cfInteractionNumber(val) {
          if(typeof val !== "undefined") {
            this._sessionApiVars["InteractionNumber"] = val;
          }
        } get cfInteractionNumber() {
          return this._sessionApiVars["InteractionNumber"] || "";
        }
      
        @api set cfCustomerId(val) {
          if(typeof val !== "undefined") {
            this._sessionApiVars["CustomerId"] = val;
          }
        } get cfCustomerId() {
          return this._sessionApiVars["CustomerId"] || "";
        }
      
        @api set cfInteractionId(val) {
          if(typeof val !== "undefined") {
            this._sessionApiVars["InteractionId"] = val;
          }
        } get cfInteractionId() {
          return this._sessionApiVars["InteractionId"] || "";
        }
      
        @api set cfSearchSubscription(val) {
          if(typeof val !== "undefined") {
            this._sessionApiVars["SearchSubscription"] = val;
          }
        } get cfSearchSubscription() {
          return this._sessionApiVars["SearchSubscription"] || "";
        }
      
              
              pubsubEvent = [];
              customEvent = [];
              
              connectedCallback() {
                super.connectedCallback();
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