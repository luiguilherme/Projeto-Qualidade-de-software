import { FlexCardMixin } from "vlocity_cmt/flexCardMixin";
    import { CurrentPageReference } from 'lightning/navigation';
    import {interpolateWithRegex, interpolateKeyValue, loadCssFromStaticResource } from "vlocity_cmt/flexCardUtility";
    
          import { LightningElement, api, track, wire } from "lwc";
          import pubsub from "vlocity_cmt/pubsub";
          import { getRecord } from "lightning/uiRecordApi";
          import { OmniscriptBaseMixin } from "vlocity_cmt/omniscriptBaseMixin";
          import data from "./definition";
          
          import styleDef from "./styleDefinition";
              
          export default class cfValReviewTopicsDetails extends FlexCardMixin(OmniscriptBaseMixin(LightningElement)){
              currentPageReference;        
              @wire(CurrentPageReference)
              setCurrentPageReference(currentPageReference) {
                this.currentPageReference = currentPageReference;
              }
              @api debug;
              @api recordId;
              @api objectApiName;
              @track _omniSupportKey = 'cfValReviewTopicsDetails';
                  @api get omniSupportKey() {
                    return this._omniSupportKey;
                  }
                  set omniSupportKey(parentRecordKey) {
                    this._omniSupportKey = this._omniSupportKey  + '_' + parentRecordKey;
                  }
              @track record;
              @track _sessionApiVars = {};
        @api set cfProtocolNumber(val) {
          if(typeof val !== "undefined") {
            this._sessionApiVars["ProtocolNumber"] = val;
          }
        } get cfProtocolNumber() {
          return this._sessionApiVars["ProtocolNumber"] || "";
        }
      
        @api set cfOpeningDate(val) {
          if(typeof val !== "undefined") {
            this._sessionApiVars["OpeningDate"] = val;
          }
        } get cfOpeningDate() {
          return this._sessionApiVars["OpeningDate"] || "";
        }
      
        @api set cfClosingDate(val) {
          if(typeof val !== "undefined") {
            this._sessionApiVars["ClosingDate"] = val;
          }
        } get cfClosingDate() {
          return this._sessionApiVars["ClosingDate"] || "";
        }
      
        @api set cfDescription(val) {
          if(typeof val !== "undefined") {
            this._sessionApiVars["Description"] = val;
          }
        } get cfDescription() {
          return this._sessionApiVars["Description"] || "";
        }
      
        @api set cfStatus(val) {
          if(typeof val !== "undefined") {
            this._sessionApiVars["Status"] = val;
          }
        } get cfStatus() {
          return this._sessionApiVars["Status"] || "";
        }
      
        @api set cfSystemName(val) {
          if(typeof val !== "undefined") {
            this._sessionApiVars["SystemName"] = val;
          }
        } get cfSystemName() {
          return this._sessionApiVars["SystemName"] || "";
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