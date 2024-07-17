import { LightningElement } from "lwc";
    import b2cCmexSubscriptionsDetailsCard from "vlocity_cmt/b2cCmexSubscriptionsDetailsCard";
    import template from "./b2cCmexSubscriptionsDetailsCard_ext.html"
    export default class b2cCmexSubscriptionsDetailsCard_ext extends b2cCmexSubscriptionsDetailsCard{
        // your properties and methods here
        
        render()
          {
            return template;
          }
    }