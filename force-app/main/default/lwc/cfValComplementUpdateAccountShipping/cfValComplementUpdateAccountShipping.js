import { FlexCardMixin } from "vlocity_cmt/flexCardMixin";
    import { CurrentPageReference } from 'lightning/navigation';
    import {interpolateWithRegex, interpolateKeyValue, loadCssFromStaticResource } from "vlocity_cmt/flexCardUtility";
    
          import { LightningElement, api, track, wire } from "lwc";
          import pubsub from "vlocity_cmt/pubsub";
          import { getRecord } from "lightning/uiRecordApi";
          import { OmniscriptBaseMixin } from "vlocity_cmt/omniscriptBaseMixin";
          import data from "./definition";
          
          import styleDef from "./styleDefinition";
              
          export default class cfValComplementUpdateAccountShipping extends FlexCardMixin(OmniscriptBaseMixin(LightningElement)){
              currentPageReference;        
              @wire(CurrentPageReference)
              setCurrentPageReference(currentPageReference) {
                this.currentPageReference = currentPageReference;
              }
              @api debug;
              @api recordId;
              @api objectApiName;
              @track _omniSupportKey = 'cfValComplementUpdateAccountShipping';
                  @api get omniSupportKey() {
                    return this._omniSupportKey;
                  }
                  set omniSupportKey(parentRecordKey) {
                    this._omniSupportKey = this._omniSupportKey  + '_' + parentRecordKey;
                  }
              @track record;
              @track _sessionApiVars = {};
        @api set cfMainComplementOne(val) {
          if(typeof val !== "undefined") {
            this._sessionApiVars["MainComplementOne"] = val;
          }
        } get cfMainComplementOne() {
          return this._sessionApiVars["MainComplementOne"] || "";
        }
      
        @api set cfMainComplementTwo(val) {
          if(typeof val !== "undefined") {
            this._sessionApiVars["MainComplementTwo"] = val;
          }
        } get cfMainComplementTwo() {
          return this._sessionApiVars["MainComplementTwo"] || "";
        }
      
        @api set cfMainComplementFour(val) {
          if(typeof val !== "undefined") {
            this._sessionApiVars["MainComplementFour"] = val;
          }
        } get cfMainComplementFour() {
          return this._sessionApiVars["MainComplementFour"] || "";
        }
      
        @api set cfMainComplementThree(val) {
          if(typeof val !== "undefined") {
            this._sessionApiVars["MainComplementThree"] = val;
          }
        } get cfMainComplementThree() {
          return this._sessionApiVars["MainComplementThree"] || "";
        }
      
        @api set cfMainComplementTypeOne(val) {
          if(typeof val !== "undefined") {
            this._sessionApiVars["MainComplementTypeOne"] = val;
          }
        } get cfMainComplementTypeOne() {
          return this._sessionApiVars["MainComplementTypeOne"] || "";
        }
      
        @api set cfMainComplementTypeTwo(val) {
          if(typeof val !== "undefined") {
            this._sessionApiVars["MainComplementTypeTwo"] = val;
          }
        } get cfMainComplementTypeTwo() {
          return this._sessionApiVars["MainComplementTypeTwo"] || "";
        }
      
        @api set cfMainComplementTypeThree(val) {
          if(typeof val !== "undefined") {
            this._sessionApiVars["MainComplementTypeThree"] = val;
          }
        } get cfMainComplementTypeThree() {
          return this._sessionApiVars["MainComplementTypeThree"] || "";
        }
      
        @api set cfMainComplementTypeFour(val) {
          if(typeof val !== "undefined") {
            this._sessionApiVars["MainComplementTypeFour"] = val;
          }
        } get cfMainComplementTypeFour() {
          return this._sessionApiVars["MainComplementTypeFour"] || "undefined";
        }
      
        @api set cfShow(val) {
          if(typeof val !== "undefined") {
            this._sessionApiVars["Show"] = val;
          }
        } get cfShow() {
          return this._sessionApiVars["Show"] || "undefined";
        }
      
        @api set cfId(val) {
          if(typeof val !== "undefined") {
            this._sessionApiVars["Id"] = val;
          }
        } get cfId() {
          return this._sessionApiVars["Id"] || "";
        }
      
        @api set cfName(val) {
          if(typeof val !== "undefined") {
            this._sessionApiVars["Name"] = val;
          }
        } get cfName() {
          return this._sessionApiVars["Name"] || "";
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
                
            this.customEventName0 = interpolateWithRegex(`reloadFlex`,this._allMergeFields,this._regexPattern,"noparse");
            this.customEvent[0] = this.handleEventAction.bind(this, data.events[0],0);

            this.template.addEventListener(this.customEventName0,this.customEvent[0]);

          
              }

              unregisterEvents(){
                
            this.template.removeEventListener(this.customEventName0,this.customEvent[0]);

              }
            
              renderedCallback() {
                super.renderedCallback();
                
              }
          }