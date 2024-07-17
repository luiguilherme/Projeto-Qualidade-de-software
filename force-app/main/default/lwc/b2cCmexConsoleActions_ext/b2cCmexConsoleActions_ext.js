import { LightningElement } from "lwc";
    import b2cCmexConsoleActions from "vlocity_cmt/b2cCmexConsoleActions";
    import template from "./b2cCmexConsoleActions_ext.html"
    export default class b2cCmexConsoleActions_ext extends b2cCmexConsoleActions{
        // your properties and methods here
        
        render()
          {
            return template;
          }
    }