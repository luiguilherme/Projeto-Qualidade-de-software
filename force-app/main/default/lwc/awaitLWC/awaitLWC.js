import { LightningElement } from 'lwc';
    import { OmniscriptBaseMixin } from 'vlocity_cmt/omniscriptBaseMixin';
    export default class awaitLWC extends OmniscriptBaseMixin(LightningElement) {
      
connectedCallback() {
    (async () => {
        try {
            const value = await this.promiseFunc();
            console.log('await' + value);
        } catch (error) {
            this.error = error;
        } finally {
            this.isLoaded = true;
        }
    })();
}
    promiseFunc() {
        return new Promise((resolve, reject) => {
            setTimeout(() => {
                this.omniNextStep();
            }, 10000);
        });
    }
    
}