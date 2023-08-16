import { LightningElement, track, api } from 'lwc';
import { OmniscriptBaseMixin } from "vlocity_cmt/omniscriptBaseMixin";
import { getNamespaceDotNotation } from "vlocity_cmt/omniscriptInternalUtils";
import pubsub from "vlocity_cmt/pubsub";

export default class GetSearchedPhoneNumber extends OmniscriptBaseMixin(LightningElement) {
    @track phoneNumber = '';
    @track digits = [];
    @track numberString='';
    @track selectedline = {};
    @track selectedNumber = {};
    @track options = [];
    @track optionsView = false;
    @track searchNumber = false;
    @track ResponseDataValICCID = {};
    @track idPesquisa;
    @track DDD;
    @track capacityDemandAmount;
    @api hasLinesAvailable = false;
    @api StepConfigureLine;
    @track numeroResultados;

    _ns = getNamespaceDotNotation();

    get getICCIDStatus (){
        if( this.validICCID != undefined) {
            return this.validICCID;
        } else{
            return;
        }
    }

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
        console.log('data.selectedNumber ' + JSON.stringify(data.selectedNumber))
        console.log('data ' + JSON.stringify(data))
        console.log('data.selectedNumber ' + JSON.stringify(data.selectedNumber.length))

        if(data.selectedNumber.length !== 0) {
            console.log('selectedNumber existe')
            this.options = data.selectedNumber.options;
            var obj = data.selectedNumber.options;
            this.optionsView = true;
        }
        else {
            this.optionsView = false;
        }

        this.idPesquisa           = data.idPesquisa;
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

    getCheckedValue(){
        if(this.omniJsonData !== undefined){            
            var jsonData = this.omniJsonData;
            if(jsonData.hasOwnProperty('StepConfigureLine')){
                jsonData = this.omniJsonData.StepConfigureLine;   
                if(jsonData.hasOwnProperty('selectedNumber')){
                    if(jsonData.selectedNumber == null) {
                        return ""
                    }
                    else {
                        var jsonDataLine = jsonData.selectedNumber.line;
                    }
                    return jsonDataLine;
                }
            }
        }
  
        return "";
    }

    handleGetMSISDN(event) {
        if(this.numberString=='_________' || this.numberString.length ===0){
            this.searchNumber = false;
            this.optionsView = true;
            this.options = [];
            this.ResponseDataValICCID = {optionsView: this.optionsView, searchNumber: this.searchNumber};
            this.omniUpdateDataJson(this.ResponseDataValICCID);
        } 
        else{
            this.searchNumber = true;
            this.isLoaded = false;

            this.omniJsonDataStr = {
                "DDD": this.DDD.toString()+this.numberString,
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

            console.log('omniJsonDataStr ' + JSON.stringify(this.omniJsonDataStr))
    
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
                this.options = this.options.filter(option => option.value !== "() -");
                console.log('Numero de resultados: ' + this.options.length)
                this.numeroResultados = this.options.length;
                if(this.options.length==0) {
                    this.optionsView = false;
                }else{
                    this.optionsView = true;
                }
                this.capacityDemandAmount = result.result.IPResult.capacityDemandAmount;
                this.hasLinesAvailable = (this.capacityDemandAmount > 0);
                this.selectedline = { line : null };
                this.ResponseDataValICCID = {options: result.result.IPResult.options, idPesquisa: result.result.IPResult.idPesquisa, optionsView: this.optionsView, searchNumber: this.searchNumber};
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

    }
 
    pushItemToView(event){
        const selectedOption = event.target.value;


        this.selectedline = { line : selectedOption };
        this.statusICCID = { statusICCID : 'Valid'};
        this.lastNumberSearch = {idPesquisa: this.idPesquisa.toString()};

        this.omniUpdateDataJson(this.lastNumberSearch);
        this.omniUpdateDataJson(this.selectedline);      
        this.omniUpdateDataJson(this.statusICCID);
    
    }

    handleDigitKeyPress(event) { //Responsável por não permitir digitar digitar teclas não numéricas.
        const allowedKeys = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
        if (!allowedKeys.includes(event.key)) {
            event.preventDefault();
        }
    }

    handleDigitChange(event) { //método para preenher com "_" nos campos que não foram definidos com valor numérico. Necessário pois, para pesquisa funcionar é preciso mais de 5 caracteres.
        const index = event.target.dataset.index;
        const digit = event.target.value;
        const maxLength = event.target.maxLength;
        const currentIndex = parseInt(event.target.dataset.index);
    
        this.digits[index] = digit;
        this.numberString = '';
        
        if (digit.length >= maxLength) {
            const nextIndex = currentIndex + 1;
            const nextInput = this.template.querySelector(`[data-index="${nextIndex}"]`);
            
            if (nextInput) {
                nextInput.focus();
            }
        }
    
        for (let i = 0; i < 9; i++) {
            const currentDigit = this.digits[i] || '_';
            this.numberString += currentDigit;
        }
        if (digit === '') {
            this.digits[index] = '';
        }
    }

    handleDigitKeyDown(event) { //responsável por avançar e recuar com as setas e o espaço do teclado e utilizar o backspace para apagar os inputs
        const currentTarget = event.currentTarget;
        const currentIndex = parseInt(currentTarget.dataset.index, 10);
        const nextIndex = event.key === 'ArrowRight' || event.key === ' ' ? currentIndex + 1 : event.key === 'ArrowLeft' ? currentIndex - 1 : null;

        if (nextIndex !== null) {
            event.preventDefault();
            const nextInput = this.template.querySelector(`lightning-input[data-index="${nextIndex}"]`);
            if (nextInput) {
                nextInput.focus();
            }
        } else if (event.key === 'Backspace' && currentTarget.value === '' && currentIndex > 0) {
            const previousIndex = currentIndex - 1;
            const previousInput = this.template.querySelector(`lightning-input[data-index="${previousIndex}"]`);
            if (previousInput) {
                previousInput.focus();
            }
            //this.digits[currentIndex] = null;
            //this.numberString = this.digits.filter(d => d !== null).join('');
        }
    }
    

    handleClear() {
        this.digits = [];
        this.numberString = '';
        this.template.querySelectorAll('lightning-input').forEach(input => input.value = '');
    }
}