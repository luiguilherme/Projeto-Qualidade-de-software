import { LightningElement, api } from 'lwc';
import { OmniscriptBaseMixin } from 'vlocity_cmt/omniscriptBaseMixin';

export default class ValViewImage extends OmniscriptBaseMixin(LightningElement) {
    @api imageName;
    imageURL;

    connectedCallback() {
        this.imageURL = `/resource/${this.imageName}`;
    }
}