import { LightningElement, wire, track } from "lwc";

// Ligthning Message Service and message channels
import { subscribe, MessageContext } from "lightning/messageService";
import OFFERS_FILTERED_MESSAGE from "@salesforce/messageChannel/OffersFiltered__c";

import getOffers from "@salesforce/apex/OfferController.getOffers";
import getAdditionalServices from "@salesforce/apex/OfferController.getAdditionalServices";

export default class OfferTable extends LightningElement {

  @track record = {};
  @track bShowModal = false;
  @track total = 0;

  /** JSON.stringified version of filters to pass to apex */
  filters = {
    isActive: true,
    servAdicionais: false
  };

  /** Current page in the product list. */
  pageNumber = 1;

  /** The number of items on a page. */
  pageSize;

  /** The total number of items matching the selection. */
  totalItemCount = 0;

  /** Load context for Ligthning Messaging Service */
  @wire(MessageContext) messageContext;

  /** Subscription for OffersFiltered Ligthning message */
  offerFilterSubscription;

  /**
   * Load the list of available products.
   */
  @wire(getOffers, { filters: "$filters", pageNumber: "$pageNumber" })
  offers;

  @track additionalServices;
  @wire(getAdditionalServices)
  getAddServices(result) {
    if(result.data){
      this.additionalServices = result.data.map(item => ({
        ...item,
        selected: false,
        labelPrice: item.FixedCampaignRTD__c + ' / ' + item.TotalPrice__c.toLocaleString('pt-br', { style: 'currency', currency: 'BRL' })
      }));
    }
  }

  connectedCallback() {
    // Subscribe to OffersFiltered message
    this.offerFilterSubscription = subscribe(
      this.messageContext,
      OFFERS_FILTERED_MESSAGE,
      (message) => this.handleFilterChange(message)
    );
  }

  handleFilterChange(message) {
    this.filters = { ...message.filters };
    this.pageNumber = 1;
  }

  handlePreviousPage() {
    this.pageNumber = this.pageNumber - 1;
  }

  handleNextPage() {
    this.pageNumber = this.pageNumber + 1;
  }
  
  handlePreview(event) {
    var row = event.detail.row;
    this.record = row;
    this.bShowModal = true;
    this.total = this.record.TotalPrice__c;
  }

  closeModal() {
    this.bShowModal = false;
    this.total = 0;
    this.additionalServices.map(item => {
      item.selected = false
    });
  }

  hadleAddServClick(event) {
    var price = event.target.dataset.price;
    var index = event.target.dataset.index;
    
    this.additionalServices[index].selected = !this.additionalServices[index].selected;
    if(this.additionalServices[index].selected) {
      this.total += Number(price);
    } else {
      this.total -= Number(price);
    }
  }

}