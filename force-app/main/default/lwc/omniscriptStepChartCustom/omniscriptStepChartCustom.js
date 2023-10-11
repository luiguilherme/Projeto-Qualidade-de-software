import { api } from "lwc";
import OmniscriptStepChart from "vlocity_cmt/omniscriptStepChart";
import tmpl from "./omniscriptStepChartCustom.html";

export default class omniscriptStepChartCustom extends OmniscriptStepChart {

    step;
    of;

    render() {
        return tmpl;
    }


    @api get jsonDef() {
        return super.jsonDef;
    }

    set jsonDef(value) {
        let steps = value.children.filter((item) => item.isStep);
        this.of = steps.length;
        let stepIndex = steps.findIndex(
        (item) => item.indexInParent === value.asIndex
        );
        this.step = stepIndex + 1;
        super.jsonDef = value;
    }
}