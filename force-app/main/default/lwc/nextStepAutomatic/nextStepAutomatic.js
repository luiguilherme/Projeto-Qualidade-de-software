import { LightningElement } from 'lwc';
import { OmniscriptBaseMixin } from 'vlocity_cmt/omniscriptBaseMixin';

export default class nextStepAutomatic extends OmniscriptBaseMixin(LightningElement) {

    connectedCallback() {
        let jsonstepsPassedAuto = this.omniJsonData.stepsPassedAuto;
        let stepName = this.omniScriptHeaderDef.asName;

        if (!jsonstepsPassedAuto || !jsonstepsPassedAuto[stepName]) {
            this.omniApplyCallResp({ stepsPassedAuto: { [stepName]: true } });
            setTimeout(()=> {
                this.omniNextStep();
            }, 1);
        }
    }
}
