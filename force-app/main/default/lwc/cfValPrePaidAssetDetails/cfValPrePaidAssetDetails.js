import { FlexCardMixin } from "vlocity_cmt/flexCardMixin";
    import { CurrentPageReference } from 'lightning/navigation';
    import {interpolateWithRegex, interpolateKeyValue, loadCssFromStaticResource } from "vlocity_cmt/flexCardUtility";
    
          import { LightningElement, api, track, wire } from "lwc";
          import pubsub from "vlocity_cmt/pubsub";
          import { getRecord } from "lightning/uiRecordApi";
          import { OmniscriptBaseMixin } from "vlocity_cmt/omniscriptBaseMixin";
          import data from "./definition";
          
          import styleDef from "./styleDefinition";
              
          export default class cfValPrePaidAssetDetails extends FlexCardMixin(OmniscriptBaseMixin(LightningElement)){
              currentPageReference;        
              @wire(CurrentPageReference)
              setCurrentPageReference(currentPageReference) {
                this.currentPageReference = currentPageReference;
              }
              @api debug;
              @api recordId;
              @api objectApiName;
              @track _omniSupportKey = 'cfValPrePaidAssetDetails';
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
      
        @api set cfSourceComponent(val) {
          if(typeof val !== "undefined") {
            this._sessionApiVars["SourceComponent"] = val;
          }
        } get cfSourceComponent() {
          return this._sessionApiVars["SourceComponent"] || "";
        }
      
        @api set cfCustomerId(val) {
          if(typeof val !== "undefined") {
            this._sessionApiVars["CustomerId"] = val;
          }
        } get cfCustomerId() {
          return this._sessionApiVars["CustomerId"] || "";
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
      
        @api set cfChannelName(val) {
          if(typeof val !== "undefined") {
            this._sessionApiVars["ChannelName"] = val;
          }
        } get cfChannelName() {
          return this._sessionApiVars["ChannelName"] || "";
        }
      
        @api set cfUserPermissionOnline(val) {
          if(typeof val !== "undefined") {
            this._sessionApiVars["UserPermissionOnline"] = val;
          }
        } get cfUserPermissionOnline() {
          return this._sessionApiVars["UserPermissionOnline"] || "";
        }
      
        @api set cfUserPermissionPhysical(val) {
          if(typeof val !== "undefined") {
            this._sessionApiVars["UserPermissionPhysical"] = val;
          }
        } get cfUserPermissionPhysical() {
          return this._sessionApiVars["UserPermissionPhysical"] || "";
        }
      
        @api set cfRechargeSubmitted(val) {
          if(typeof val !== "undefined") {
            this._sessionApiVars["RechargeSubmitted"] = val;
          }
        } get cfRechargeSubmitted() {
          return this._sessionApiVars["RechargeSubmitted"] || "";
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
                
        this.pubsubEvent[0] = {
          [interpolateWithRegex(`data`,this._allMergeFields,this._regexPattern,"noparse")]: this.handleEventAction.bind(this, data.events[0],0)
        };
        this.pubsubChannel0 = interpolateWithRegex(`omniscript_action`,this._allMergeFields,this._regexPattern,"noparse");
        pubsub.register(this.pubsubChannel0,this.pubsubEvent[0]);

              }

              unregisterEvents(){
                pubsub.unregister(this.pubsubChannel0,this.pubsubEvent[0]);

              }
            
              renderedCallback() {
                super.renderedCallback();
                
              }
          }