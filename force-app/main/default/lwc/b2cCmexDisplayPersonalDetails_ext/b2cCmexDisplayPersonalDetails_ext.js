import { LightningElement } from "lwc";
    import b2cCmexDisplayPersonalDetails from "vlocity_cmt/b2cCmexDisplayPersonalDetails";
    import template from "./b2cCmexDisplayPersonalDetails_ext.html"
    import { OmniscriptBaseMixin } from 'vlocity_cmt/omniscriptBaseMixin';
    export default class b2cCmexDisplayPersonalDetails_ext extends OmniscriptBaseMixin(b2cCmexDisplayPersonalDetails){
        // your properties and methods here
        
      connectedCallback() {
        // Call omniUpdateDataJson to update the omniscript
        // this.omniUpdateDataJson({'key':'value'});
      }
    
        render()
          {
            return template;
          }
    }