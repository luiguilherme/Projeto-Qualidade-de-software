import { LightningElement } from "lwc";
    import b2cCmexSubscriberActions from "vlocity_cmt/b2cCmexSubscriberActions";
    import template from "./b2cCmexSubscriberActions_ext.html"
    export default class b2cCmexSubscriberActions_ext extends b2cCmexSubscriberActions{
        // your properties and methods here
        
        render()
          {
            return template;
          }
    }