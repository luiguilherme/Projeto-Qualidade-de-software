import { LightningElement, track, api, wire } from 'lwc';
import { OmniscriptBaseMixin } from "vlocity_cmt/omniscriptBaseMixin";
import { getNamespaceDotNotation } from "vlocity_cmt/omniscriptInternalUtils";
import { NavigationMixin } from "lightning/navigation";

export default class statementDetailVivo extends NavigationMixin(LightningElement) {

    @api linha;
    @api conta;
    @api plano;
    @api emissao;
    @api startDate;
    @api endDate;


    connectedCallback(){
        //window.open("apex/")
        console.log('url: ' + this.url);
    }


    handleClickSimplifiedStatement() {console.log(this.url);
        window.open('/apex/ExtractSimplifiedAsPdf?linenumber='+this.linha+'&conta=' + this.conta + '&plano=' + this.plano + '&emissao=' + this.emissao + '&periodo=' + this.startDate + ' A ' + this.endDate + '&startDate=' + this.startDate + '&endDate=' + this.endDate, '_blank');
    }

    handleClickDetailedStatement() {console.log(this.url);
        window.open('/apex/ExtractDetailedAsPdf?linenumber='+this.linha+'&conta=' + this.conta + '&plano=' + this.plano + '&emissao=' + this.emissao + '&periodo=' + this.startDate + ' A ' + this.endDate + '&startDate=' + this.startDate + '&endDate=' + this.endDate, '_blank');
    }


}