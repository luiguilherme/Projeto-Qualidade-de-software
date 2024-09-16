/**
 * @description       : 
 * @author            : Kauan Cordeiro
 * @group             : 
 * @last modified on  : 02-08-2024
 * @last modified by  : Kauan Cordeiro
**/
import { LightningElement, api } from 'lwc';

import { OmniscriptBaseMixin } from "vlocity_cmt/omniscriptBaseMixin";

export default class CfPanSmartSIMServiceList extends OmniscriptBaseMixin(LightningElement) {
    @api serviceList;
    updatedServices = new Map();

    get options() {
        return [
            { label: 'Ativo', value: 'A' },
            { label: 'Cancelado', value: 'C' }
        ];
    }

    handleChange(event){
        this.updatedServices.set(
            event.target.name, 
            {
                id: event.target.name,
                name: event.target.label,
                status: event.target.value,
            }
        );
    }

    handleClick(){
        let updatedList = [];
        for (const x of this.updatedServices.values()) {
            updatedList.push(x);
        }

        const responseOS = {
            "updatedList": updatedList
        };

        this.omniApplyCallResp(responseOS);
        
        this.omniNextStep();
    }

    connectedCallback(){
        this.serviceList;
    }
}