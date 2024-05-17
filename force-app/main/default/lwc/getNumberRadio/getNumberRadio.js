import { LightningElement, api, track} from 'lwc';
import { OmniscriptBaseMixin } from "vlocity_cmt/omniscriptBaseMixin";
import { getNamespaceDotNotation } from "vlocity_cmt/omniscriptInternalUtils";
import { OmniscriptActionCommonUtil } from "vlocity_cmt/omniscriptActionUtils";
import pubsub from "vlocity_cmt/pubsub";
export default class getNumberRadio extends OmniscriptBaseMixin( LightningElement) {
//your lwc code here for radio group as shown above


    @track options = [];
    @track DDD;
    @track AccountId;
    @track optionsSize;

    @api showResults = false;

    data = [];

    _ns = getNamespaceDotNotation();

    connectedCallback()
    {           
        pubsub.register('omniscript_action', {
            data: this.handleOmniAction.bind(this),
        });

        pubsub.register('omniscript_step', {
            data: this.handleOmniAction.bind(this),
        });
    }    


    handleOmniAction(data)
    {       
        this.options              = data.options;
        this.optionsSize          = data.optionsSize;
        var obj                   = data.options.value;
        this.AccountId            = data.AccountId;
        this.numeroResultados     = this.options.length;        
        this.showResults          = Boolean(this.optionsSize > 0);
        console.log('showResults' + this.showResults);

        var needle = this.getCheckedValue();

        for (var i = 0; i < obj.length; i++)
        {
            if (obj[i].value == needle){
               this.options[i]['checked'] = "true";
            }
        }
    }


    pushItemToView(event)
    {

        var selectedOption = event.target.value;

        console.log(selectedOption);

        this.getNumberRadio = { selectedNumber : selectedOption };

        this.omniUpdateDataJson(this.getNumberRadio);

    }    

    

    
    getCheckedValue(){
        if(this.omniJsonData !== undefined){
            var jsonData = this.omniJsonData;
            if(jsonData.hasOwnProperty('numeroOrigem')){
                jsonData = this.omniJsonData.numeroOrigem;   
                if(jsonData.hasOwnProperty('getNumberRadio')){
                    if(jsonData.getNumberRadio == null) {
                        return ""
                    }
                    else {
                        var jsonDataLine = jsonData.getNumberRadio.selectedNumber;
                    }
                    return jsonDataLine;
                }
            }
        }
  
        return "";
    }
}