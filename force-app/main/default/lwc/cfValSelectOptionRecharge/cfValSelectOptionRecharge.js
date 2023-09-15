import { FlexCardMixin } from "vlocity_cmt/flexCardMixin";
    import { CurrentPageReference } from 'lightning/navigation';
    import {interpolateWithRegex, interpolateKeyValue, loadCssFromStaticResource } from "vlocity_cmt/flexCardUtility";
    
          import { LightningElement, api, track, wire } from "lwc";
          import pubsub from "vlocity_cmt/pubsub";
          import { getRecord } from "lightning/uiRecordApi";
          import { OmniscriptBaseMixin } from "vlocity_cmt/omniscriptBaseMixin";
          import data from "./definition";
          
          import styleDef from "./styleDefinition";
              
          export default class cfValSelectOptionRecharge extends FlexCardMixin(OmniscriptBaseMixin(LightningElement)){
              currentPageReference;        
              @wire(CurrentPageReference)
              setCurrentPageReference(currentPageReference) {
                this.currentPageReference = currentPageReference;
              }
              @api debug;
              @api recordId;
              @api objectApiName;
              @track _omniSupportKey = 'cfValSelectOptionRecharge';
                  @api get omniSupportKey() {
                    return this._omniSupportKey;
                  }
                  set omniSupportKey(parentRecordKey) {
                    this._omniSupportKey = this._omniSupportKey  + '_' + parentRecordKey;
                  }
              @track record;
              @track _sessionApiVars = {};
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
          return this._sessionApiVars["AssetId"] || "undefined";
        }
      
        @api set cfAccountDetails(val) {
          if(typeof val !== "undefined") {
            this._sessionApiVars["AccountDetails"] = val;
          }
        } get cfAccountDetails() {
          return this._sessionApiVars["AccountDetails"] || "";
        }
      
        @api set cfInteractionId(val) {
          if(typeof val !== "undefined") {
            this._sessionApiVars["InteractionId"] = val;
          }
        } get cfInteractionId() {
          return this._sessionApiVars["InteractionId"] || "";
        }
      
        @api set cfInteractionNumber(val) {
          if(typeof val !== "undefined") {
            this._sessionApiVars["InteractionNumber"] = val;
          }
        } get cfInteractionNumber() {
          return this._sessionApiVars["InteractionNumber"] || "";
        }
      
        @api set cfChannelName(val) {
          if(typeof val !== "undefined") {
            this._sessionApiVars["ChannelName"] = val;
          }
        } get cfChannelName() {
          return this._sessionApiVars["ChannelName"] || "";
        }
      
        @api set cfDdd(val) {
          if(typeof val !== "undefined") {
            this._sessionApiVars["Ddd"] = val;
          }
        } get cfDdd() {
          return this._sessionApiVars["Ddd"] || "";
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
          [interpolateWithRegex(`return`,this._allMergeFields,this._regexPattern,"noparse")]: this.handleEventAction.bind(this, data.events[0],0),
[interpolateWithRegex(`topic`,this._allMergeFields,this._regexPattern,"noparse")]: this.handleEventAction.bind(this, data.events[1],1)
        };
        this.pubsubChannel0 = interpolateWithRegex(`valSelectOptionRecharge`,this._allMergeFields,this._regexPattern,"noparse");
        pubsub.register(this.pubsubChannel0,this.pubsubEvent[0]);

              }

              unregisterEvents(){
                pubsub.unregister(this.pubsubChannel0,this.pubsubEvent[0]);

              }
            
              renderedCallback() {
                super.renderedCallback();
                
              }
          }