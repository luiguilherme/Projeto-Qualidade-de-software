import { FlexCardMixin } from "vlocity_cmt/flexCardMixin";
    import { CurrentPageReference } from 'lightning/navigation';
    import {interpolateWithRegex, interpolateKeyValue, loadCssFromStaticResource } from "vlocity_cmt/flexCardUtility";
    
          import { LightningElement, api, track, wire } from "lwc";
          import pubsub from "vlocity_cmt/pubsub";
          import { getRecord } from "lightning/uiRecordApi";
          import { OmniscriptBaseMixin } from "vlocity_cmt/omniscriptBaseMixin";
          import data from "./definition";
          
          import styleDef from "./styleDefinition";
              
          export default class cfValPrePaidAssetDetails_49_Telefonica extends FlexCardMixin(OmniscriptBaseMixin(LightningElement)){
              currentPageReference;        
              @wire(CurrentPageReference)
              setCurrentPageReference(currentPageReference) {
                this.currentPageReference = currentPageReference;
              }
              @api debug;
              @api recordId;
              @api objectApiName;
              @track _omniSupportKey = 'cfValPrePaidAssetDetails_49_Telefonica';
                  @api get omniSupportKey() {
                    return this._omniSupportKey;
                  }
                  set omniSupportKey(parentRecordKey) {
                    this._omniSupportKey = this._omniSupportKey  + '_' + parentRecordKey;
                  }
              @track record;
              @track _sessionApiVars = {};
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
          [interpolateWithRegex(`Reload`,this._allMergeFields,this._regexPattern,"noparse")]: this.handleEventAction.bind(this, data.events[0],0),
[interpolateWithRegex(`updateState_{recordId}`,this._allMergeFields,this._regexPattern,"noparse")]: this.handleEventAction.bind(this, data.events[1],1),
[interpolateWithRegex(`returnState_{recordId}`,this._allMergeFields,this._regexPattern,"noparse")]: this.handleEventAction.bind(this, data.events[2],2),
[interpolateWithRegex(`skipAddress`,this._allMergeFields,this._regexPattern,"noparse")]: this.handleEventAction.bind(this, data.events[7],7)
        };
        this.pubsubChannel0 = interpolateWithRegex(`valPrePaidAssetDetails`,this._allMergeFields,this._regexPattern,"noparse");
        pubsub.register(this.pubsubChannel0,this.pubsubEvent[0]);

        this.pubsubEvent[1] = {
          [interpolateWithRegex(`{recordId}`,this._allMergeFields,this._regexPattern,"noparse")]: this.handleEventAction.bind(this, data.events[3],3)
        };
        this.pubsubChannel1 = interpolateWithRegex(`valUpdateLineAddress`,this._allMergeFields,this._regexPattern,"noparse");
        pubsub.register(this.pubsubChannel1,this.pubsubEvent[1]);

        this.pubsubEvent[2] = {
          [interpolateWithRegex(`data`,this._allMergeFields,this._regexPattern,"noparse")]: this.handleEventAction.bind(this, data.events[6],6)
        };
        this.pubsubChannel2 = interpolateWithRegex(`omniscript_action`,this._allMergeFields,this._regexPattern,"noparse");
        pubsub.register(this.pubsubChannel2,this.pubsubEvent[2]);

            this.customEventName0 = interpolateWithRegex(`SetOptInOptOut`,this._allMergeFields,this._regexPattern,"noparse");
            this.customEvent[0] = this.handleEventAction.bind(this, data.events[4],4);

            this.template.addEventListener(this.customEventName0,this.customEvent[0]);

          
            this.customEventName1 = interpolateWithRegex(`valUpdateAcceptPromotion`,this._allMergeFields,this._regexPattern,"noparse");
            this.customEvent[1] = this.handleEventAction.bind(this, data.events[5],5);

            this.template.addEventListener(this.customEventName1,this.customEvent[1]);

          
              }

              unregisterEvents(){
                pubsub.unregister(this.pubsubChannel0,this.pubsubEvent[0]);
pubsub.unregister(this.pubsubChannel1,this.pubsubEvent[1]);
pubsub.unregister(this.pubsubChannel2,this.pubsubEvent[2]);

            this.template.removeEventListener(this.customEventName0,this.customEvent[0]);

            this.template.removeEventListener(this.customEventName1,this.customEvent[1]);

              }
            
              renderedCallback() {
                super.renderedCallback();
                
              }
          }