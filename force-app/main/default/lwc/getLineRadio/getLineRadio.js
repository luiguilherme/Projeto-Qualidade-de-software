import { LightningElement, api, track} from 'lwc';
import { OmniscriptBaseMixin } from "vlocity_cmt/omniscriptBaseMixin";
import { getNamespaceDotNotation } from "vlocity_cmt/omniscriptInternalUtils";
import { OmniscriptActionCommonUtil } from "vlocity_cmt/omniscriptActionUtils";
import pubsub from "vlocity_cmt/pubsub";
export default class GetLineRadio extends OmniscriptBaseMixin( LightningElement) {
//your lwc code here for radio group as shown above



    @track options = [];
    @track selectedline = {};
    @track ResponseDataValICCID = {};

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
        this.options = data.phones;

        var obj = data.phones;

        var needle = this.getCheckedValue();

        for (var i = 0; i < obj.length; i++)
        {
            if (obj[i].value == needle){
               this.options[i]['checked'] = "true";
            }
        }
    }

    handleGetMSISDN(event)
    {
        this.omniJsonDataStr = {};
        
        const params = {
            input: this.omniJsonDataStr,
            sClassName: `${this._ns}IntegrationProcedureService`,
            sMethodName: 'val_GetMSISDN',
            options: '{}',
        };

        this.omniRemoteCall(params, true).then(result => {
            this.lstReturn = result.result.IPResult.options;
            this.options = this.lstReturn;

            this.selectedline = { line : null };
            this.ResponseDataValICCID = {options: result.result.IPResult.options};

            this.omniUpdateDataJson(this.ResponseDataValICCID);
            this.omniUpdateDataJson(this.selectedline);
            

        }).catch(error => {
            console.log('error: ' + error);
        })
        .finally(()=>{
        });

    }


    pushItemToView(event)
    {
        const selectedOption = event.target.value;
        
        this.selectedline = { line : selectedOption };
        
        this.omniUpdateDataJson(this.selectedline);        
    
    }    

    
    
    getCheckedValue(){
        if(this.omniJsonData !== undefined){            
            var jsonData = this.omniJsonData; 
            if(jsonData.hasOwnProperty('StepConfigureLine')){
                jsonData = this.omniJsonData.StepConfigureLine;   
                if(jsonData.hasOwnProperty('selectedLine')){
                    var jsonDataLine = jsonData.selectedLine.line;

                    return jsonDataLine;
                }
            }
        }
  
        return "";
    }
}