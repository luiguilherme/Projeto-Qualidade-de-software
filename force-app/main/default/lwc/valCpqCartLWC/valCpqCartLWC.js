import { LightningElement, api, track } from 'lwc';
import { OmniscriptBaseMixin } from "vlocity_cmt/omniscriptBaseMixin";
import * as cpqDataLayer from "vlocity_cmt/cpqDataLayerUtil";

export default class ValCpqCartLWC extends OmniscriptBaseMixin( LightningElement) {

    @track recordIdData;
    connectedCallback(){
        
        this.recordIdData = this.omniJsonData.OrderId;
        cpqDataLayer.updateWorkingCartId("");
        
        //dá para trocar para getter e setter, precisa testar
        console.log("sessionStorage: "+JSON.stringify(sessionStorage));
        console.log("omniJsonData"+ JSON.stringify(this.omniJsonData));
    }

      
    renderedCallBack()
    {
        setInterval(() => {
            setTimeout(() => {
            }, 36000);
            ;
            }, 36000);
    }
    
    nextButton(evt) {
        if (evt) {
            this.omniNextStep();
        }
    }

    prevButton(evt) {
        if (evt) {
            this.omniPrevStep();
        }
    }

}