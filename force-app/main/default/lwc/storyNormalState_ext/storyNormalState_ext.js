import { LightningElement } from "lwc";
    import storyNormalState from "vlocity_cmt/storyNormalState";
    //import { BaseState } from "c/baseState";
    import template from "./storyNormalState_ext.html"
    export default class storyNormalState_ext extends storyNormalState{
//    export default class storyNormalState_ext extends BaseState(LightningElement) {
  get cardContainerClass() {
    return `gray-color custom-card slds-shadow ${
      this.hideFlyout ? "" : "card-active"
    }`;
  }
  get iconName() {
    let obj = this.obj;
    let iconName = "standard:default";
    iconName =
      obj && obj.objType ? `standard:${obj.objType.toLowerCase()}` : iconName;
    iconName =
      this.session && this.session.iconName ? this.session.iconName : iconName;
    return iconName;
  }

  get iconClass() {
    let iconClass = "slds-icon_container";
    if (this.session && this.session.iconName) {
      let iconSplit = this.session.iconName.split(":");
      iconClass += ` slds-icon-${iconSplit[0]}-${iconSplit[1].replace(
        /_/g,
        "-"
      )}`;
    } else if (this.obj && this.obj.objType) {
      iconClass += ` slds-icon-standard-${this.obj.objType.toLowerCase()}`;
    }
    return iconClass;
  }

  render() {
    return template;
  }
}