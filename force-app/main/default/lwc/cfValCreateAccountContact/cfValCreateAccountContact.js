import { FlexCardMixin } from "vlocity_cmt/flexCardMixin";
    import { CurrentPageReference } from 'lightning/navigation';
    import {interpolateWithRegex, interpolateKeyValue, loadCssFromStaticResource } from "vlocity_cmt/flexCardUtility";
    
          import { LightningElement, api, track, wire } from "lwc";
          import pubsub from "vlocity_cmt/pubsub";
          import { getRecord } from "lightning/uiRecordApi";
          import { OmniscriptBaseMixin } from "vlocity_cmt/omniscriptBaseMixin";
          import data from "./definition";
          
          import styleDef from "./styleDefinition";
              
          export default class cfValCreateAccountContact extends FlexCardMixin(OmniscriptBaseMixin(LightningElement)){
              currentPageReference;        
              @wire(CurrentPageReference)
              setCurrentPageReference(currentPageReference) {
                this.currentPageReference = currentPageReference;
              }
              @api debug;
              @api recordId;
              @api objectApiName;
              @track _omniSupportKey = 'cfValCreateAccountContact';
                  @api get omniSupportKey() {
                    return this._omniSupportKey;
                  }
                  set omniSupportKey(parentRecordKey) {
                    this._omniSupportKey = this._omniSupportKey  + '_' + parentRecordKey;
                  }
              @track record;
              @track _sessionApiVars = {};
        @api set cfMobilePhone(val) {
          if(typeof val !== "undefined") {
            this._sessionApiVars["MobilePhone"] = val;
          }
        } get cfMobilePhone() {
          return this._sessionApiVars["MobilePhone"] || "undefined";
        }
      
        @api set cfResidentialPhone(val) {
          if(typeof val !== "undefined") {
            this._sessionApiVars["ResidentialPhone"] = val;
          }
        } get cfResidentialPhone() {
          return this._sessionApiVars["ResidentialPhone"] || "undefined";
        }
      
        @api set cfComercialPhone(val) {
          if(typeof val !== "undefined") {
            this._sessionApiVars["ComercialPhone"] = val;
          }
        } get cfComercialPhone() {
          return this._sessionApiVars["ComercialPhone"] || "undefined";
        }
      
        @api set cfEmail(val) {
          if(typeof val !== "undefined") {
            this._sessionApiVars["Email"] = val;
          }
        } get cfEmail() {
          return this._sessionApiVars["Email"] || "undefined";
        }
      
        @api set cfResidentialPhonePrincipal(val) {
          if(typeof val !== "undefined") {
            this._sessionApiVars["ResidentialPhonePrincipal"] = val;
          }
        } get cfResidentialPhonePrincipal() {
          return this._sessionApiVars["ResidentialPhonePrincipal"] || "false";
        }
      
        @api set cfMobilePhonePrincipal(val) {
          if(typeof val !== "undefined") {
            this._sessionApiVars["MobilePhonePrincipal"] = val;
          }
        } get cfMobilePhonePrincipal() {
          return this._sessionApiVars["MobilePhonePrincipal"] || "false";
        }
      
        @api set cfComercialPhonePrincipal(val) {
          if(typeof val !== "undefined") {
            this._sessionApiVars["ComercialPhonePrincipal"] = val;
          }
        } get cfComercialPhonePrincipal() {
          return this._sessionApiVars["ComercialPhonePrincipal"] || "false";
        }
      
        @api set cfResidentialPhonePrincipalDisable(val) {
          if(typeof val !== "undefined") {
            this._sessionApiVars["ResidentialPhonePrincipalDisable"] = val;
          }
        } get cfResidentialPhonePrincipalDisable() {
          return this._sessionApiVars["ResidentialPhonePrincipalDisable"] || "true";
        }
      
        @api set cfMobilePhonePrincipalDisable(val) {
          if(typeof val !== "undefined") {
            this._sessionApiVars["MobilePhonePrincipalDisable"] = val;
          }
        } get cfMobilePhonePrincipalDisable() {
          return this._sessionApiVars["MobilePhonePrincipalDisable"] || "true";
        }
      
        @api set cfComercialPhonePrincipalDisable(val) {
          if(typeof val !== "undefined") {
            this._sessionApiVars["ComercialPhonePrincipalDisable"] = val;
          }
        } get cfComercialPhonePrincipalDisable() {
          return this._sessionApiVars["ComercialPhonePrincipalDisable"] || "true";
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
          [interpolateWithRegex(`basetypeaheadinputchange`,this._allMergeFields,this._regexPattern,"noparse")]: this.handleEventAction.bind(this, data.events[0],0)
        };
        this.pubsubChannel0 = interpolateWithRegex(`Email`,this._allMergeFields,this._regexPattern,"noparse");
        pubsub.register(this.pubsubChannel0,this.pubsubEvent[0]);

        this.pubsubEvent[1] = {
          [interpolateWithRegex(`MobilePhonePrincipal`,this._allMergeFields,this._regexPattern,"noparse")]: this.handleEventAction.bind(this, data.events[1],1),
[interpolateWithRegex(`ResidentialPhonePrincipal`,this._allMergeFields,this._regexPattern,"noparse")]: this.handleEventAction.bind(this, data.events[2],2),
[interpolateWithRegex(`ComercialPhonePrincipal`,this._allMergeFields,this._regexPattern,"noparse")]: this.handleEventAction.bind(this, data.events[3],3),
[interpolateWithRegex(`enableMobilePrincipal`,this._allMergeFields,this._regexPattern,"noparse")]: this.handleEventAction.bind(this, data.events[4],4)
        };
        this.pubsubChannel1 = interpolateWithRegex(`valCreateAccountContact`,this._allMergeFields,this._regexPattern,"noparse");
        pubsub.register(this.pubsubChannel1,this.pubsubEvent[1]);

        this.pubsubEvent[2] = {
          [interpolateWithRegex(`data`,this._allMergeFields,this._regexPattern,"noparse")]: this.handleEventAction.bind(this, data.events[5],5)
        };
        this.pubsubChannel2 = interpolateWithRegex(`omniscript_step`,this._allMergeFields,this._regexPattern,"noparse");
        pubsub.register(this.pubsubChannel2,this.pubsubEvent[2]);

              }

              unregisterEvents(){
                pubsub.unregister(this.pubsubChannel0,this.pubsubEvent[0]);
pubsub.unregister(this.pubsubChannel1,this.pubsubEvent[1]);
pubsub.unregister(this.pubsubChannel2,this.pubsubEvent[2]);

              }
            
              renderedCallback() {
                super.renderedCallback();
                
              }
          }