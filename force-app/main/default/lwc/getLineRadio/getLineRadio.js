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
    @track idPesquisa;
    @track DDD;
    @track capacityDemandAmount;
    @track numeroResultados;

    @api hasLinesAvailable = false;
    @api isLoaded = false;

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
        this.isLoaded = false;
        if(data.selectedLine.length != 0) {
            this.options = data.selectedLine.options;
            this.numeroResultados = this.options.length;
            var obj = data.selectedLine.options;
            this.idPesquisa = data.selectedLine.idPesquisa;
        }
        else{
            this.options              = data.phones;
            var obj                   = data.phones;
            this.idPesquisa           = data.idPesquisa;
        }
        
        this.numeroResultados = this.options.length;
        this.DDD                  = data.DDD;
        this.capacityDemandAmount = data.capacityDemandAmount;
        this.hasLinesAvailable    = (this.capacityDemandAmount > 0);

        var needle = this.getCheckedValue();

        for (var i = 0; i < obj.length; i++)
        {
            if (obj[i].value == needle){
               this.options[i]['checked'] = "true";
            }
        }
        this.isLoaded = true;
    }

    handleGetMSISDN(event)
    {
        this.isLoaded = false;

        this.omniJsonDataStr = {
            "DDD": this.DDD.toString(),            
            "@type": "phone number",
             "resourceCapacityDemand": {
                "capacityDemandAmount": 3,
                "characteristic": [
                    {
                        "name": "LAST_SEARCH",
                        "value": Number(this.idPesquisa)
                    }
                ],
                "place": {
                    "cnl": "11000"
                },
                "resourcePool": {
                    "resource": {
                        "value": this.DDD.toString(),
                        "@referredType": "number",
                        "relatedParty": [
                            {
                                "referredType": "APPLICATION",
                                "id": "Salesforce",
                                "role": "OWNER"
                            }
                        ],
                        "characteristic": [
                            {
                                "name": "CATEGORY",
                                "value": "Normal"
                            },
                            {
                                "name": "DDI",
                                "value": "55"
                            },
                            {
                                "name": "TYPE_NETWORK",
                                "value": "M"
                            }
                        ]
                    }
                }
            },
            "StepConfigureLine": {
                "StepConfigureLine": {
                    "selectedLine": {
                        "statusICCID": "Valid",
                        "idPesquisa": this.idPesquisa
                    }
                }
            }
        };

        const options = {};

        const params = {
            input: this.omniJsonDataStr,
            sClassName: `${this._ns}IntegrationProcedureService`,
            sMethodName: 'val_GetMSISDN',
            options: JSON.stringify(options),
        };

        this.omniRemoteCall(params, true).then(result => {
            this.lstReturn = result.result.IPResult.options;
            this.options = this.lstReturn;
            this.numeroResultados = this.options.length;

            this.capacityDemandAmount = result.result.IPResult.capacityDemandAmount;
            this.hasLinesAvailable = (this.capacityDemandAmount > 0);
            this.selectedline = { line : null };
            this.ResponseDataValICCID = {options: result.result.IPResult.options, idPesquisa: result.result.IPResult.idPesquisa};
            this.idPesquisa = result.result.IPResult.idPesquisa;
            this.statusICCID = { statusICCID : 'Valid'};

            this.omniUpdateDataJson(this.ResponseDataValICCID);
            this.omniUpdateDataJson(this.selectedline);
            this.omniUpdateDataJson(this.statusICCID);

            this.isLoaded = true;
        }).catch(error => {
            this.isLoaded = true;
            console.log('error: ' + error);
        })
        .finally(()=>{
        });

    }


    pushItemToView(event)
    {
        const selectedOption = event.target.value;

        this.selectedline = { line : selectedOption };
        this.statusICCID = { statusICCID : 'Valid'};
        this.lastNumberSearch = {idPesquisa: this.idPesquisa.toString()};
        this.ResponseDataValICCID = {options: this.options}

        this.omniUpdateDataJson(this.lastNumberSearch);
        this.omniUpdateDataJson(this.selectedline);
        this.omniUpdateDataJson(this.statusICCID);
        this.omniUpdateDataJson(this.ResponseDataValICCID);
    
    }    

    
    getCheckedValue(){
        if(this.omniJsonData !== undefined){
            var jsonData = this.omniJsonData;
            if(jsonData.hasOwnProperty('StepConfigureLine')){
                jsonData = this.omniJsonData.StepConfigureLine;   
                if(jsonData.hasOwnProperty('selectedLine')){
                    if(jsonData.selectedLine == null) {
                        return ""
                    }
                    else {
                        var jsonDataLine = jsonData.selectedLine.line;
                    }
                    return jsonDataLine;
                }
            }
        }
  
        return "";
    }
}