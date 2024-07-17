import { FlexCardMixin } from "vlocity_cmt/flexCardMixin";
    import { CurrentPageReference } from 'lightning/navigation';
    import {interpolateWithRegex, interpolateKeyValue, loadCssFromStaticResource } from "vlocity_cmt/flexCardUtility";
    
          import { LightningElement, api, track, wire } from "lwc";
          import pubsub from "vlocity_cmt/pubsub";
          import { getRecord } from "lightning/uiRecordApi";
          import { OmniscriptBaseMixin } from "vlocity_cmt/omniscriptBaseMixin";
          import data from "./definition";
          
          import styleDef from "./styleDefinition";
              
          export default class cfValApprovalRequestsJourney extends FlexCardMixin(OmniscriptBaseMixin(LightningElement)){
              currentPageReference;        
              @wire(CurrentPageReference)
              setCurrentPageReference(currentPageReference) {
                this.currentPageReference = currentPageReference;
              }
              @api debug;
              @api recordId;
              @api objectApiName;
              @track _omniSupportKey = 'cfValApprovalRequestsJourney';
                  @api get omniSupportKey() {
                    return this._omniSupportKey;
                  }
                  set omniSupportKey(parentRecordKey) {
                    this._omniSupportKey = this._omniSupportKey  + '_' + parentRecordKey;
                  }
              @track record;
              @track _sessionApiVars = {};
        @api set cfApprovalRequestsLabel(val) {
          if(typeof val !== "undefined") {
            this._sessionApiVars["ApprovalRequestsLabel"] = val;
          }
        } get cfApprovalRequestsLabel() {
          return this._sessionApiVars["ApprovalRequestsLabel"] || "undefined";
        }
      
        @api set cfMessage(val) {
          if(typeof val !== "undefined") {
            this._sessionApiVars["Message"] = val;
          }
        } get cfMessage() {
          return this._sessionApiVars["Message"] || "";
        }
      
        @api set cfMessageHeader(val) {
          if(typeof val !== "undefined") {
            this._sessionApiVars["MessageHeader"] = val;
          }
        } get cfMessageHeader() {
          return this._sessionApiVars["MessageHeader"] || "";
        }
      
        @api set cfMessageFooter(val) {
          if(typeof val !== "undefined") {
            this._sessionApiVars["MessageFooter"] = val;
          }
        } get cfMessageFooter() {
          return this._sessionApiVars["MessageFooter"] || "";
        }
      
        @api set cfFirstMessage(val) {
          if(typeof val !== "undefined") {
            this._sessionApiVars["FirstMessage"] = val;
          }
        } get cfFirstMessage() {
          return this._sessionApiVars["FirstMessage"] || "";
        }
      
        @api set cfSecondMessage(val) {
          if(typeof val !== "undefined") {
            this._sessionApiVars["SecondMessage"] = val;
          }
        } get cfSecondMessage() {
          return this._sessionApiVars["SecondMessage"] || "";
        }
      
        @api set cfThirdMessage(val) {
          if(typeof val !== "undefined") {
            this._sessionApiVars["ThirdMessage"] = val;
          }
        } get cfThirdMessage() {
          return this._sessionApiVars["ThirdMessage"] || "";
        }
      
        @api set cfFourthMessage(val) {
          if(typeof val !== "undefined") {
            this._sessionApiVars["FourthMessage"] = val;
          }
        } get cfFourthMessage() {
          return this._sessionApiVars["FourthMessage"] || "";
        }
      
              
              pubsubEvent = [];
              customEvent = [];
              
              connectedCallback() {
                super.connectedCallback();
                this.setThemeClass(data);
                this.setStyleDefinition(styleDef);
                data.Session = {} //reinitialize on reload
                
                this.flexiPageWidthAwareCB = this.flexiPageWidthAware.bind(this);
                  window.addEventListener('resize', this.flexiPageWidthAwareCB);
                
                this.setDefinition(data);
 this.registerEvents();
                
                
              }
              
              disconnectedCallback(){
                super.disconnectedCallback();
                    this.omniSaveState(this.records,this.omniSupportKey,true);
                    window.removeEventListener('resize', this.flexiPageWidthAwareCB);

                  this.unregisterEvents();
              }

              registerEvents() {
                
              }

              unregisterEvents(){
                
              }
            
              renderedCallback() {
                super.renderedCallback();
                
                if(!this.containerWidthInitialised) {
                  this.containerWidthInitialised = true;
                  this.flexiPageWidthAware();
                }
              }
          }