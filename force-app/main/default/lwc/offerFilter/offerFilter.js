import { LightningElement, track, wire, api } from 'lwc';
import { getObjectInfo, getPicklistValues } from 'lightning/uiObjectInfoApi';

// Product schema
import TECHNOLOGY_FIELD from '@salesforce/schema/Offer__c.Technology__c';
import OFFER_GROUP_FIELD from '@salesforce/schema/Offer__c.OfferGroup__c';
import BUNDLE_TYPE_FIELD from '@salesforce/schema/Offer__c.BundleType__c';
import VELOCITY_FIELD from '@salesforce/schema/Offer__c.BroadBandAttribute__c';
import TV_PLAN_FIELD from '@salesforce/schema/Offer__c.TVAttribute__c';
import PROMOTION_GROUP_FIELD from '@salesforce/schema/Offer__c.PromotionGroup__c';

import OFFER_OBJ from '@salesforce/schema/Offer__c';

// Ligthning Message Service and a message channel
import { publish, MessageContext } from 'lightning/messageService';
import OFFERS_FILTERED_MESSAGE from '@salesforce/messageChannel/OffersFiltered__c';

// The delay used when debouncing event handlers before firing the event
const DELAY = 350;

/**
 * Displays a filter panel to search for Product__c[].
 */
export default class ProductFilter extends LightningElement {


    homeAssistValues = [
        { label: ' ', value: '' },
        { label: 'Sim', value: 'y' },
        { label: 'Não', value: 'n' }
    ];

    @api objectApiName;

    @track objectRecIdInfo;
    @wire(getObjectInfo, { objectApiName: OFFER_OBJ })
    getInfos(result) {
        if(result.data) {
            for (var key in result.data.recordTypeInfos) {
                if(result.data.recordTypeInfos[key].name == 'Book de Ofertas') {
                  this.objectRecIdInfo = result.data.recordTypeInfos[key].recordTypeId;
                }
            }
        }
    }

    filters = {
        searchKey: null,
        isActive: true,
        offerGroup: null,
        technology: null,
        bundleType: null,
        broadBand: null,
        tvAttribute: null,
        promotionGroup: null,
        homeAssist: null,
        servAdicionais: false
    };

    @wire(MessageContext)
    messageContext;

    @track technologies;
    @wire(getPicklistValues, {
        recordTypeId: '$objectRecIdInfo',
        fieldApiName: TECHNOLOGY_FIELD
    })
    getTechnologies(result) {
        if(result.data) {
            this.technologies = [ 
                { label: ' ', value: '', selected: true },
                ...result.data.values
            ]
        } else if (result.error) {
            this.technologies = [{ label: ' ', value: '', selected: true }]
        }
    }

    @track offerGroups;
    @wire(getPicklistValues, {
        recordTypeId: '$objectRecIdInfo',
        fieldApiName: OFFER_GROUP_FIELD
    })
    getOfferGroups(result) {
        if(result.data) {
            this.offerGroups = [ 
                { label: ' ', value: '', selected: true },
                ...result.data.values
            ]
        } else if (result.error) {
            this.offerGroups = [{ label: ' ', value: '', selected: true }]
        }
    }

    @track bundleTypes;
    @wire(getPicklistValues, {
        recordTypeId: '$objectRecIdInfo',
        fieldApiName: BUNDLE_TYPE_FIELD
    })
    getBundleTypes(result) {
        if(result.data) {
            this.bundleTypes = [ 
                { label: ' ', value: '', selected: true },
                ...result.data.values
            ]
        } else if (result.error) {
            this.bundleTypes = [{ label: ' ', value: '', selected: true }]
        }
    }

    @track velComplete;
    @track velocities;
    @wire(getPicklistValues, {
        recordTypeId: '$objectRecIdInfo',
        fieldApiName: VELOCITY_FIELD
    })
    getVelocities(result) {
        if(result.data) {
            this.velocities = [ 
                { label: ' ', value: '', selected: true },
                ...result.data.values
            ]
            this.velComplete = result
        } else if (result.error) {
            this.velocities = [{ label: ' ', value: '', selected: true }]
        }
    }

    @track tvPlans;
    @wire(getPicklistValues, {
        recordTypeId: '$objectRecIdInfo',
        fieldApiName: TV_PLAN_FIELD
    })
    getTvPlans(result){
        if(result.data) {
            this.tvPlans = [ 
                { label: ' ', value: '', selected: true },
                ...result.data.values
            ]
        } else if (result.error) {
            this.tvPlans = [{ label: ' ', value: '', selected: true }]
        }
    }

    @track promotionGroups;
    @wire(getPicklistValues, {
        recordTypeId: '$objectRecIdInfo',
        fieldApiName: PROMOTION_GROUP_FIELD
    })
    getPromotionGroups(result) {
        if(result.data) {
            this.promotionGroups = [ 
                { label: ' ', value: '', selected: true },
                ...result.data.values
            ]
        } else if (result.error) {
            this.promotionGroups = [{ label: ' ', value: '', selected: true }]
        }
    }

    handleSearchKeyChange(event) {
        this.filters.searchKey = event.target.value;
        this.delayedFireFilterChangeEvent();
    }

    delayedFireFilterChangeEvent() {
        // Debouncing this method: Do not actually fire the event as long as this function is
        // being called within a delay of DELAY. This is to avoid a very large number of Apex
        // method calls in components listening to this event.
        window.clearTimeout(this.delayTimeout);
        // eslint-disable-next-line @lwc/lwc/no-async-operation
        this.delayTimeout = setTimeout(() => {
            // Published OffersFiltered message
            publish(this.messageContext, OFFERS_FILTERED_MESSAGE, {
                filters: this.filters
            });
        }, DELAY);
    }

    handleClick() {
        this.filters.isActive = !this.filters.isActive;
        this.delayedFireFilterChangeEvent();
    }

    handleOfferGroupChange(event) {
        this.filters.offerGroup = event.detail.value;
        this.delayedFireFilterChangeEvent();
    }

    handleTechnologyChange(event) {
        this.filters.technology = event.detail.value;

        if(event.detail.value == '') {
            this.velocities = [ 
                { label: ' ', value: '', selected: true },
                ...this.velComplete.data.values
            ];
        } else {
            let key  = this.velComplete.data.controllerValues[event.detail.value];
            this.velocities = [ 
                { label: ' ', value: '', selected: true },
                ...this.velComplete.data.values.filter(o => o.validFor.includes(key))
            ];
            this.template.querySelectorAll('lightning-combobox').forEach(el => {
                if(el.name == 'velocity') {
                    el.value = null;
                }
            });
            this.filters.broadBand = null;
        }

        this.delayedFireFilterChangeEvent();
    }

    handleBundleTypeChange(event) {
        this.filters.bundleType = event.detail.value;
        this.delayedFireFilterChangeEvent();
    }

    handleTVPlanChange(event) {
        this.filters.tvAttribute = event.detail.value;
        this.delayedFireFilterChangeEvent();
    }

    handleVelocityChange(event) {
        this.filters.broadBand = event.detail.value;
        this.delayedFireFilterChangeEvent();
    }

    handlePromotionGroupChange(event) {
        this.filters.promotionGroup = event.detail.value;
        this.delayedFireFilterChangeEvent();
    }

    handleHomeAssistClick(event) {
        this.filters.homeAssist = event.detail.value;
        this.delayedFireFilterChangeEvent();
    }

    handleServAdicionaisClick() {
        this.filters.servAdicionais = !this.filters.servAdicionais;
        this.delayedFireFilterChangeEvent();
    }
}