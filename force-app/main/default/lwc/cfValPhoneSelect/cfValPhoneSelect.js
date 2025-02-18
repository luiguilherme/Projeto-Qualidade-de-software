import { FlexCardMixin } from "vlocity_cmt/flexCardMixin";
    import { CurrentPageReference } from 'lightning/navigation';
    import {interpolateWithRegex, interpolateKeyValue, loadCssFromStaticResource } from "vlocity_cmt/flexCardUtility";
    
          import { LightningElement, api, track, wire } from "lwc";
          import pubsub from "vlocity_cmt/pubsub";
          import { getRecord } from "lightning/uiRecordApi";
          import { OmniscriptBaseMixin } from "vlocity_cmt/omniscriptBaseMixin";
          import data from "./definition";
          
          import styleDef from "./styleDefinition";
              
          export default class cfValPhoneSelect extends FlexCardMixin(OmniscriptBaseMixin(LightningElement)){
              currentPageReference;        
              @wire(CurrentPageReference)
              setCurrentPageReference(currentPageReference) {
                this.currentPageReference = currentPageReference;
              }
              @api debug;
              @api recordId;
              @api objectApiName;
              @track _omniSupportKey = 'cfValPhoneSelect';
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
      
        @api set cfHomePhone(val) {
          if(typeof val !== "undefined") {
            this._sessionApiVars["HomePhone"] = val;
          }
        } get cfHomePhone() {
          return this._sessionApiVars["HomePhone"] || "";
        }
      
        @api set cfOtherPhone(val) {
          if(typeof val !== "undefined") {
            this._sessionApiVars["OtherPhone"] = val;
          }
        } get cfOtherPhone() {
          return this._sessionApiVars["OtherPhone"] || "";
        }
      
        @api set cfEmail(val) {
          if(typeof val !== "undefined") {
            this._sessionApiVars["Email"] = val;
          }
        } get cfEmail() {
          return this._sessionApiVars["Email"] || "";
        }
      
        @api set cfMobilePhoneToggle(val) {
          if(typeof val !== "undefined") {
            this._sessionApiVars["MobilePhoneToggle"] = val;
          }
        } get cfMobilePhoneToggle() {
          return this._sessionApiVars["MobilePhoneToggle"] || "";
        }
      
        @api set cfHomePhoneToggle(val) {
          if(typeof val !== "undefined") {
            this._sessionApiVars["HomePhoneToggle"] = val;
          }
        } get cfHomePhoneToggle() {
          return this._sessionApiVars["HomePhoneToggle"] || "";
        }
      
        @api set cfOtherPhoneToggle(val) {
          if(typeof val !== "undefined") {
            this._sessionApiVars["OtherPhoneToggle"] = val;
          }
        } get cfOtherPhoneToggle() {
          return this._sessionApiVars["OtherPhoneToggle"] || "";
        }
      
              @track Label={OmniValidationMaskIncomplete:"This field is incomplete."
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
          [interpolateWithRegex(`basetypeaheadinputchange`,this._allMergeFields,this._regexPattern,"noparse")]: this.handleEventAction.bind(this, data.events[0],0)
        };
        this.pubsubChannel0 = interpolateWithRegex(`Email`,this._allMergeFields,this._regexPattern,"noparse");
        pubsub.register(this.pubsubChannel0,this.pubsubEvent[0]);

              }

              unregisterEvents(){
                pubsub.unregister(this.pubsubChannel0,this.pubsubEvent[0]);

              }
            
              renderedCallback() {
                super.renderedCallback();
                
              }
          }