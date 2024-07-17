import {OmniscriptBaseMixin} from "vlocity_cmt/omniscriptBaseMixin"; 
import {LightningElement, api} from "lwc";
          
export default class BalanceDetailsCard extends OmniscriptBaseMixin(LightningElement) {

    @api horizontalBarProperties;

    // get horizontalBarPropertiesList (){
    //     if( this.horizontalBarProperties != undefined) {
    //         // Create a new filtered list without null and && item.width 0 elements
    //         const filteredAttributesList = this.horizontalBarProperties.attributesList.filter(item => item !== null && item.width !== 0);

    //         return filteredAttributesList
    //     } else{
    //         return [];
    //     }
    // }

    get horizontalBarPropertiesList() {
        if (this.horizontalBarProperties && this.horizontalBarProperties.attributesList) {
            const filteredAttributesList = this.horizontalBarProperties.attributesList.filter(item => item !== null && item.width !== 0);
            return filteredAttributesList;
        } else {
            return [];
        }
    }

    renderedCallback() {
        console.log("renderedCallback " + JSON.stringify(this.horizontalBarProperties))
        if (this.horizontalBarProperties !== undefined) {
            this.buildHorizontalBar(this.horizontalBarPropertiesList);
        }
    }
    
    buildHorizontalBar(attributesList) {
        console.log('attributesList ' + JSON.stringify(attributesList))
        if (attributesList && attributesList.length > 0) {
            const bars = this.template.querySelectorAll('.item');
            for (let index = 0; index < bars.length && index < attributesList.length; index++) {
                bars[index].style.width = attributesList[index].width + '%'; 
                bars[index].style.background = attributesList[index].background;
            }
        } else {
            console.log('No valid attributesList to build the horizontal bar.');
        }
    }
}