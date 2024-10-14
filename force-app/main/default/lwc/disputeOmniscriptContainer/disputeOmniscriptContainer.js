import { LightningElement, api, track } from 'lwc';
import { OmniscriptBaseMixin } from "vlocity_cmt/omniscriptBaseMixin";
import pubsub from 'vlocity_cmt/pubsub';
import { interpolateWithRegex } from 'vlocity_cmt/flexCardUtility';
import {FlowNavigationNextEvent} from 'lightning/flowSupport';

export default class DisputeOmniscriptContainer extends OmniscriptBaseMixin(LightningElement) {
    _regexPattern = /\{([a-zA-Z.0-9_]+)\}/g;
    pubsubEvents = {};
    currentOmni;
    
    //Variáveis de entrada
    @api omniVisible;
    @api case;
    @api disputedInvoice;
    
    //Prefill com informações para rodar Omnscripts
    @track prefill;


    hasHiringAdditionalLooseService = false;
    isReload = false;

    omniscriptsMap = {
        'disputeMobileIncreaseInvoiceValue': 'c-dispute-mobile-increase-invoice-value-portuguese-brazil',
        'disputeConcession': 'c-dispute-concession-english',
        'disputeDuplicateBilling': 'c-dispute-duplicate-billing-english',
        'disputeSubscriptionCancellation': 'c-dispute-subscription-cancellation-english',
        'disputeNoRecognizeQualificationOrPlanChange': 'c-dispute-not-recognize-qualification-or-plan-change-english',
        'disputeAmountDifferentFromNegotiated':'c-dispute-amount-different-from-negotiated-english'
    };

    connectedCallback() {
        this.createPrefill();
        console.log('Prefill:',JSON.stringify(this.prefill));
        console.log('omniVisible:',JSON.stringify(this.omniVisible));
        this.subscribeToEvent('omniscript_action', 'data', this.handleOmniEventFromOS.bind(this));
        this.subscribeToEvent('Dispute', 'omniEvent', this.handleOmniEventFromAction.bind(this));
        console.log('this.omniscriptsMap[this.omniVisible];', this.omniscriptsMap[this.omniVisible]);
        this.currentOmni = this.omniscriptsMap[this.omniVisible];
    }

    createPrefill(){
        console.log(this.disputedInvoice.Prefill__c)
        this.prefill = JSON.parse(this.disputedInvoice.Prefill__c);
        this.prefill.CaseId = this.case.Id;
        this.prefill.AssetId = this.case.ComplainedAsset__c;
        this.prefill.AccountId = this.case.AccountId;
        this.prefill.calledByFlow = true;
        console.log('prefillCreated', this.prefill);
        if(this.omniVisible == 'disputeDuplicateBilling'){
            this.prefill.hasHiringAdditionalLooseService = this.hasHiringAdditionalLooseService;
        }
    }

    handleOmniEventFromAction(event) {
        const { name } = event;
        if (name) this.omniVisible = name; 
        this.currentOmni = this.omniscriptsMap[this.omniVisible];
    }

    handleOmniEventFromOS(event) {
        const { omniVisible, isReload, hasHiringAdditionalLooseService, nameServiceDefinitionConcession } = event;
        console.log('Evento de Loop Capturado:', JSON.stringify(event));

        if (isReload) this.isReload = isReload;
        if (omniVisible) this.omniVisible = omniVisible;
        if (hasHiringAdditionalLooseService) this.hasHiringAdditionalLooseService = hasHiringAdditionalLooseService;
        if (nameServiceDefinitionConcession) this.prefill.nameServiceDefinitionConcession = nameServiceDefinitionConcession;
        
        if(omniVisible == 'backToFlow'){
          this.handleGoNext();
          return
        }

        this.prefill.hasHiringAdditionalLooseService = this.hasHiringAdditionalLooseService;
        console.log('this.prefill', JSON.stringify(this.prefill));
        this.currentOmni = this.omniscriptsMap[this.omniVisible];
    }

    get isOmniVisible() {
        return !!this.currentOmni;
    }

    get isDisputeMobileIncreaseInvoiceValuePortugueseBrazil() {
        return this.currentOmni === 'c-dispute-mobile-increase-invoice-value-portuguese-brazil';
    }

    get isDisputeConcessionEnglish() {
        return this.currentOmni === 'c-dispute-concession-english';
    }

    get isDisputeDuplicateBillingEnglish() {
        return this.currentOmni === 'c-dispute-duplicate-billing-english';
    }

    get isDisputeSubscriptionCancellationEnglish() {
        return this.currentOmni === 'c-dispute-subscription-cancellation-english';
    }

    get isDisputeNoRecognizeQualificationOrPlanChangeEnglish() {
        return this.currentOmni === 'c-dispute-not-recognize-qualification-or-plan-change-english';
    }

    get isDisputeAmountDifferentFromNegotiatedEnglish() {
        return this.currentOmni === 'c-dispute-amount-different-from-negotiated-english';
    }

    disconnectedCallback() {
        this.unsubscribeFromAllEvents();
    }

    subscribeToEvent(channel, event, callback) {
        const channelKey = interpolateWithRegex(channel, this._allMergeFields, this._regexPattern, 'noparse');
        if (!this.pubsubEvents[channelKey]) {
            this.pubsubEvents[channelKey] = {};
        }

        const eventKey = interpolateWithRegex(event, this._allMergeFields, this._regexPattern, 'noparse');
        this.pubsubEvents[channelKey][eventKey] = callback;
        pubsub.register(channelKey, this.pubsubEvents[channelKey]);
    }

    unsubscribeFromAllEvents() {
        Object.keys(this.pubsubEvents).forEach((channelKey) => {
            pubsub.unregister(channelKey, this.pubsubEvents[channelKey]);
        });
    }

    handleGoNext() {
        const navigateNextEvent = new FlowNavigationNextEvent();
        this.dispatchEvent(navigateNextEvent);

    }
}