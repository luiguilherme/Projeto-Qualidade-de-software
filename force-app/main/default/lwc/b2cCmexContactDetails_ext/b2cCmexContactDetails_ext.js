import { LightningElement } from "lwc";
    import b2cCmexContactDetails from "vlocity_cmt/b2cCmexContactDetails";
    import template from "./b2cCmexContactDetails_ext.html"
    export default class b2cCmexContactDetails_ext extends b2cCmexContactDetails{
        // your properties and methods here
        
        render()
          {
            return template;
          }
    }