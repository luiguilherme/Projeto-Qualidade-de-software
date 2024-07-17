import { LightningElement, api, track } from 'lwc';
import { OmniscriptBaseMixin } from 'vlocity_cmt/omniscriptBaseMixin';
import pubsub from "vlocity_cmt/pubsub";

export default class OmniPreviousStepGenericButton extends OmniscriptBaseMixin(LightningElement) {
    
    @api label;

    handlePreviousStepOmni() {
        if (this.label == "Voltar ao início") {
            this.omniUpdateDataJson("Restart");
            this.omniNextStep();
        } else {
            this.omniPrevStep();
        }
    }
}