import { LightningElement } from "lwc";
    import b2cCmexAccountSubscriptions from "vlocity_cmt/b2cCmexAccountSubscriptions";
    import template from "./b2cCmexAccountSubscriptions_ext.html"
    export default class b2cCmexAccountSubscriptions_ext extends b2cCmexAccountSubscriptions{
        // your properties and methods here
        
        render()
          {
            return template;
          }
    }