import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { OmniscriptBaseMixin } from 'vlocity_cmt/omniscriptBaseMixin';
import pubsub from "vlocity_cmt/pubsub";

export default class ValHandleTopicAuto extends OmniscriptBaseMixin(LightningElement) {
    connectedCallback() {
        pubsub.register("valtopicsauto",{["inactivate"]: this.handleInactivate.bind(this)});     
    }

    handleInactivate(data) {
        console.log('SAL >> data: ' + JSON.stringify(data));

        const params = {
            input: {"Status" : "Inativo",
                    "TopicsList" : data.inactivateList},
            sClassName: 'vlocity_cmt.IntegrationProcedureService',
            sMethodName: 'val_UpdateTopicsAutoStatus',
            options: '{}',
        };     

        this.omniRemoteCall(params, true).then(result => {
            console.log('SAL >> sucess');
            this.refreshPage(data);
        }).catch(error => {
            console.log('SAL >> error: ' + error);
        })
        .finally(()=>{
            
        });            
    } 
    
    refreshPage(data) {
        let topicInput;

        topicInput = data.topicInput != "{TopicInput}" ? data.topicInput : "";
        this.showToast("", data.message, data.variant);
        pubsub.fire("valtopicsauto", "inactivaterefresh", { "currentPage" : data.currentPage, "topicInput" : topicInput});
    }    
    
    showToast(title, message, variant) {
        const event = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant
        });

        this.dispatchEvent(event);
    }     
}