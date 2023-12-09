import { FlexCardMixin } from "vlocity_cmt/flexCardMixin";
    import { CurrentPageReference } from 'lightning/navigation';
    import {interpolateWithRegex, interpolateKeyValue, loadCssFromStaticResource } from "vlocity_cmt/flexCardUtility";
    
          import { LightningElement, api, track, wire } from "lwc";
          import pubsub from "vlocity_cmt/pubsub";
          import { getRecord } from "lightning/uiRecordApi";
          import { OmniscriptBaseMixin } from "vlocity_cmt/omniscriptBaseMixin";
          import data from "./definition";
          
          import styleDef from "./styleDefinition";
              
          export default class cfShowAssetResult extends FlexCardMixin(OmniscriptBaseMixin(LightningElement)){
              currentPageReference;        
              @wire(CurrentPageReference)
              setCurrentPageReference(currentPageReference) {
                this.currentPageReference = currentPageReference;
              }
              @api debug;
              @api recordId;
              @api objectApiName;
              @track _omniSupportKey = 'cfShowAssetResult';
                  @api get omniSupportKey() {
                    return this._omniSupportKey;
                  }
                  set omniSupportKey(parentRecordKey) {
                    this._omniSupportKey = this._omniSupportKey  + '_' + parentRecordKey;
                  }
              @track record;
              @track _sessionApiVars = {};
        @api set cfSubscriptionId(val) {
          if(typeof val !== "undefined") {
            this._sessionApiVars["SubscriptionId"] = val;
          }
        } get cfSubscriptionId() {
          return this._sessionApiVars["SubscriptionId"] || "";
        }
      
        @api set cfLineNumber(val) {
          if(typeof val !== "undefined") {
            this._sessionApiVars["LineNumber"] = val;
          }
        } get cfLineNumber() {
          return this._sessionApiVars["LineNumber"] || "";
        }
      
        @api set cfAssetId(val) {
          if(typeof val !== "undefined") {
            this._sessionApiVars["AssetId"] = val;
          }
        } get cfAssetId() {
          return this._sessionApiVars["AssetId"] || "";
        }
      
        @api set cfAccountId(val) {
          if(typeof val !== "undefined") {
            this._sessionApiVars["AccountId"] = val;
          }
        } get cfAccountId() {
          return this._sessionApiVars["AccountId"] || "";
        }
      
        @api set cfAssetPlatform(val) {
          if(typeof val !== "undefined") {
            this._sessionApiVars["AssetPlatform"] = val;
          }
        } get cfAssetPlatform() {
          return this._sessionApiVars["AssetPlatform"] || "";
        }
      
        @api set cfAccountName(val) {
          if(typeof val !== "undefined") {
            this._sessionApiVars["AccountName"] = val;
          }
        } get cfAccountName() {
          return this._sessionApiVars["AccountName"] || "";
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
          [interpolateWithRegex(`minimizeutilitybar`,this._allMergeFields,this._regexPattern,"noparse")]: this.handleEventAction.bind(this, data.events[0],0)
        };
        this.pubsubChannel0 = interpolateWithRegex(`showAccountResult`,this._allMergeFields,this._regexPattern,"noparse");
        pubsub.register(this.pubsubChannel0,this.pubsubEvent[0]);

              }

              unregisterEvents(){
                pubsub.unregister(this.pubsubChannel0,this.pubsubEvent[0]);

              }
            
              renderedCallback() {
                super.renderedCallback();
                
              }
          }