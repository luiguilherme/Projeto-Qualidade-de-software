import { masterLayout } from "vlocity_cmt/masterLayout";                                import { LightningElement, api, track } from "lwc";                                import data from "./definition";import { OmniscriptBaseMixin } from "vlocity_cmt/omniscriptBaseMixin";                                export default class cfSfiConsoleServices extends OmniscriptBaseMixin(masterLayout(LightningElement)) {@api recordId;@api theme = 'slds';@api debug;connectedCallback() {                            super.connectedCallback();                            this.definition = data;/* Call omniUpdateDataJson to update the omniscript                                 this.omniUpdateDataJson({"key":"value"});*/}}