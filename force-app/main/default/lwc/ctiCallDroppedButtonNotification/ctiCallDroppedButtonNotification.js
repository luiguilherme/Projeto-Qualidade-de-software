import { api, track, LightningElement, wire } from 'lwc';
import {CurrentPageReference} from 'lightning/navigation';
import pubsub from 'vlocity_cmt/pubsub';
import { fireEvent , registerListener} from 'c/pubsub';
import { OmniscriptBaseMixin } from 'vlocity_cmt/omniscriptBaseMixin';
import { interpolateWithRegex } from "vlocity_cmt/flexCardUtility";
import { EnclosingTabId, getTabInfo, IsConsoleNavigation, getFocusedTabInfo } from 'lightning/platformWorkspaceApi';


export default class CtiCallDroppedButtonNotification extends  OmniscriptBaseMixin(LightningElement) {
    @wire(CurrentPageReference) pageRef;
    @track isNotWDE = window.external && Object.keys(window.external).length === 0;
    @wire(EnclosingTabId) tabId;
    @wire(IsConsoleNavigation) isConsoleNavigation;

	_regexPattern = /\{([a-zA-Z.0-9_]+)\}/g; //for {} fields by default
    pubsubEvents = {};
    _actionUtil;

	pubsubEvent = [];
    pubsubChannel0;
    pubsubChannel1;

    recoveryIds;

    @api customerinteractionid;
    @api producttype;
    @api line;
    @api productsourcesystem;
    @api serviceidentifier;
    @api caseid;

    payloadFromRegisterEvent = {};

    connectedCallback() {        
        this.recoveryIds = { "CustomerInteractionId__c" : this.customerinteractionid };                
        
        this.subscribeToEvent('Dispute', 'Open', this.setValuesFromEvent.bind(this));
        this.subscribeToEvent('ctiCallDroppedButtonChild', 'recoveryids', this.setValuesFromEventGPS.bind(this));
        // this.pubsubEvent[0] = {[interpolateWithRegex("recoveryids", this._allMergeFields, this._regexPattern, "noparse")]: this.getRecoveryIds.bind(this)};        
        // this.pubsubChannel0 = interpolateWithRegex("ctiCallDroppedButtonChild", this._allMergeFields, this._regexPattern, "noparse");
        // pubsub.register(this.pubsubChannel0, this.pubsubEvent[0]);
    }

    subscribeToEvent(channel, event, callback){
        const channelKey = interpolateWithRegex(channel, this._allMergeFields, this._regexPattern, 'noparse');
        if (!this.pubsubEvents[channelKey]) {
            this.pubsubEvents[channelKey] = {};
        }
 
        const eventKey = interpolateWithRegex(event, this._allMergeFields, this._regexPattern, 'noparse');
        this.pubsubEvents[channelKey][eventKey] = callback;
        pubsub.register(channelKey, this.pubsubEvents[channelKey]);
    }

    unsubscribeFromAllEvents(){
        Object.keys(this.pubsubEvents).forEach((channelKey) => {
            pubsub.unregister(channelKey, this.pubsubEvents[channelKey]);
        });
    }
    

    setValuesFromEventGPS(evt) {
        console.log("setValuesFromEventGPS", JSON.stringify(evt));
        this.payloadFromRegisterEvent = {
            "AccountId__c" : evt.AccountId__c,
            "CaseId__c": evt.CaseId__c,
            "CustomerInteractionId__c": evt.CustomerInteractionId__c,
            "ServiceIdentifier": evt.ServiceIdentifier,
            "selectedAssetId" : evt.selectedAssetId,
            "selectedTopicTreeId": evt.selectedTopicTreeId
        }
        console.log("this.payloadFromRegisterEvent", this.payloadFromRegisterEvent);
    }

    setValuesFromEvent(evt){
        console.log("setValuesFromEvent");        
        if(evt.InteractionId == this.customerinteractionid) {
            this.payloadFromRegisterEvent = {
                "AccountId" : evt.AccountId,
                "Line" : evt.AssetId,
                "ProductSourceSystem": evt.ProductSourceSystem,
                "ServiceIdentifier": evt.ServiceIdentifier,
                "ProductType": evt.ProductType,
                "CaseId__c": evt.CaseId,
                "CustomerInteractionId__c": evt.InteractionId,
                "CustomerInteractionTopicId__c": evt.InteractionTopicId,
                "type": "RelationshipEventBroker_CallDropped"
            }
        }
    }

    sendNotification() {
        console.log("sendNotification");
        if (this.isConsoleNavigation) {
            getTabInfo(this.tabId).then((tabInfo) => {
                let payload = this.craftPayload(tabInfo);
                console.log("isConsoleNavigation");
                this.setNotificationType(payload);
            });
        } else {
            let payload = this.craftPayload();
            console.log("isConsoleNavigation false");
            this.setNotificationType(payload);
        }
    }

    craftPayload(focusedTabInfo) {
                if(this.afterRegisterPayloadHasData()) {
                    console.log("getFocusedTabInfo then > has data");
                    this.payloadFromRegisterEvent.focusedTabInfo = focusedTabInfo;
                    return this.payloadFromRegisterEvent;
                }

                let payloadBeforeRegister = { 
                    "IsBeforeRegister" : true,
                    "CustomerInteractionId__c" : this.customerinteractionid,
                    "ProductType": this.producttype,
                    "Line": this.line,
                    "ProductSourceSystem": this.productsourcesystem,
                    "ServiceIdentifier": this.serviceidentifier,
                    "CaseId__c": this.caseid,
                    "type": "RelationshipEventBroker_CallDropped",
                    "focusedTabInfo": focusedTabInfo
                };

                return payloadBeforeRegister
    }

    setNotificationType(payload) {
        console.log("setNotificationType > payload");
        let isProductNextAndMobile = this.isProductNextAndMobile(payload);
        payload.isProductNextAndMobile = isProductNextAndMobile;
        if(isProductNextAndMobile) {
            console.log("setNotificationType > next");
            fireEvent(this.pageRef, 'calldroppedbuttonnotification', payload);
        } else {
            console.log("setNotificationType > fixa");
            fireEvent(this.pageRef, 'aplicationevent', payload);
        }
    }

    fireEventToCallDroppedNotification(event) {
        console.log("on fireEventToCallDroppedNotification");
        //increment payload with protocols ids
        fireEvent(this.pageRef, 'calldroppedbuttonnotification', event);
    }
    //helpers
    isProductNextAndMobile(payload) {
        return (payload.ProductSourceSystem && payload.ProductSourceSystem.toLowerCase() == 'next') && (payload.ProductType && payload.ProductType.toLowerCase() == "mobile")
    }
    afterRegisterPayloadHasData(){
        return Object.keys(this.payloadFromRegisterEvent).length > 0;
    }
    performCallDroppedIntegrations(payload) {
        fireEvent(this.pageRef, 'performintegrations', payload);
    }
    // disconnectedCallback(){
    //     this.unsubscribeFromAllEvents();
    // }
}