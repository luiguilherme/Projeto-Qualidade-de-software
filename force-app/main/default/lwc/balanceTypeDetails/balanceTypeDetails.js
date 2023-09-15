import {OmniscriptBaseMixin} from "vlocity_cmt/omniscriptBaseMixin"; 
import {LightningElement,track, api} from "lwc";
import allInclusivePNG_icon from '@salesforce/resourceUrl/all_inclusive';
          
export default class balanceTypeDetails extends OmniscriptBaseMixin(LightningElement) {
    @api endTime;
    @track balanceTypeDetails = false;
    allInclusiveIcon = allInclusivePNG_icon;

    connectedCallback() {
        console.log("TESTE CallBack " + this.endTime)
    }
    
    get formattedEndTime (){
        if( this.endTime != undefined) {
            const date = new Date(this.endTime);
            return date.toLocaleDateString('pt-BR');
        }else{
            return;
        }
    }
  
    handleClick(){  
        console.log("TESTE CallBack " + this.endTime)

        this.balanceTypeDetails = !this.balanceTypeDetails;
    }
}