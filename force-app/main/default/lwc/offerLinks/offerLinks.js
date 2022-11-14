import { LightningElement, wire } from 'lwc';

import getLinks from '@salesforce/apex/OfferLinksController.getLinks';

export default class OfferLinks extends LightningElement {

  @wire(getLinks, {})
  links;

  handleLink(event) {
    var url = event.target.dataset.url;
    window.open(url, '_blank');
  }
}