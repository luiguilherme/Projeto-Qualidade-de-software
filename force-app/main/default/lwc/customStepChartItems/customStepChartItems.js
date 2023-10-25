import OmnistudioStepChartItems from "vlocity_cmt/omniscriptStepChartItems";
import tmpl from "./customStepChartItems.html";

export default class CustomStepChartItems extends OmnistudioStepChartItems {

  render() {
    return tmpl;
  }

  computeClass(config) {
    let result = Object.keys(config)
    .filter((key) => config[key])
    .join(" ");
    return result ? result : null;
  };

  handleStepClick(e){
  }

  get computedStepClassName() {
    return this.computeClass({
      step: true,
      step_vertical: this.isVertical,
      step_horizontal: !this.isVertical
    });
  }

  get _currentStepIndexPlusOne() {
    return this.currentStepIndex + 1;
  }
}