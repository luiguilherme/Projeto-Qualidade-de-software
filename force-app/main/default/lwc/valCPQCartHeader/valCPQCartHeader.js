import { LightningElement, api } from 'lwc';
import { OmniscriptBaseMixin } from "vlocity_cmt/omniscriptBaseMixin";

export default class valCPQCartHeader extends LightningElement {


    @api recordIdData;
    connectedCallback(){
        this.recordIdData = this.orderid;
        //dá para trocar para getter e setter, precisa testar
        
        
    }

    @api
    get orderid() {
        return this.auxVar;
    }
    set orderid(value) {
        if (value && value !== this.auxVar) {
            console.log('SAL >> teste: ' + value);
            this.auxVar = value;
        }
    }
}