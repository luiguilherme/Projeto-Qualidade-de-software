import { LightningElement, wire, api } from 'lwc';
import {CurrentPageReference} from 'lightning/navigation';
import { fireEvent } from 'c/pubsub';
import { OmniscriptBaseMixin } from 'vlocity_cmt/omniscriptBaseMixin';

export default class MinimizeInteractionLauncher extends OmniscriptBaseMixin(LightningElement) {
    @wire(CurrentPageReference) pageRef;
    
    lineNumber=""; 

    @api get linenumber() {
        return this.lineNumber;
    }
    set linenumber(value) {
        this.lineNumber = value;
    }
    
    connectedCallback() {
        console.log('InteractionLauncherNotification sendMinimizeUtilityBarToAura', this.lineNumber);
        fireEvent(this.pageRef, 'minimizeutilitybar', {});
window.location.replace("https://valentinatelefonica--uat.sandbox.lightning.force.com/lightning/cmp/vlocity_cmt__vlocityLWCOmniWrapper?c__target=c:valCreateAssociateRegistrationPortugueseBrazil&c__layout=lightning&c__tabIcon=custom:custom18&c__tabLabel=Associação de Cadastro&c__lineNumber="+ this.lineNumber +"");
    }
}