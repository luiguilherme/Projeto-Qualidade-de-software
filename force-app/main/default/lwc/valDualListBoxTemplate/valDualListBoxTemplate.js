import { LightningElement, api, track } from 'lwc';
import { OmniscriptBaseMixin } from 'vlocity_cmt/omniscriptBaseMixin';
import pubsub from 'vlocity_cmt/pubsub';
import { FlexCardMixin } from "vlocity_cmt/flexCardMixin";

export default class ValDualListBoxTemplate extends FlexCardMixin(OmniscriptBaseMixin(LightningElement)){
    @api cName; 
    @api title;
    @api labelList;
    @api sourceLabel;
    @api selectedLabel;
    @api fieldLevelHelp;
    @api registro;
    @api keyFieldOptions;   //campo chave no JSON que tem todas as opções(key/value)
    @api keyFieldSelecteds; //campo chave no JSON que tem opções selecionadas (lista delimitada por ';')
    
    @track lstallOptions = []; //render screen values
    @track lstSelectedItems = [];  //render screen values

    //variáveis de valores
    selectedOptions;
    allOptions;

    connectedCallback() {
        this.showMessage = false;
        
        if(this.registro!=undefined){
            this.loadListallOptions();
            this.handleSuccessallSelectedValues();
            this.handleSuccessallOptions();
        }
    }

    loadListallOptions() {
        let campos = JSON.stringify(this.registro)
        
        for (let levelOneKey in this.registro) {
            
            var levelTwoObj = this.registro[levelOneKey];
            for (let levelTwoKey in levelTwoObj ) {
                if(levelOneKey==this.keyFieldSelecteds && levelTwoKey==this.cName){
                    this.selectedOptions = levelTwoObj[levelTwoKey];
                }
                
                if(levelOneKey==this.keyFieldOptions && levelTwoKey==this.cName){
                    this.allOptions = levelTwoObj[levelTwoKey];
                }                
            }
        }
    }

    handleSuccessallSelectedValues() {
        this.lstSelectedItems = []; 
        
        let selected = this.selectedOptions;
        let channelsArray;
        
        if (selected != "" && selected!=undefined) {
            
            pubsub.fire("updatelistfilterparms",this.cName.toLowerCase(),{"data":selected});  
            
            channelsArray = selected.split(";");
            channelsArray.forEach(element => {
                this.lstSelectedItems.push(element);
            }); 
        }
    }

    handleSuccessallOptions() {
        this.allOptions.forEach(element => {
            this.lstallOptions.push({
                label: element.Key,
                value: element.Value
            });
        });
    }
     
    handleChangeItems(event) {
        let selectedItems;
        selectedItems = event.target.value;
        selectedItems = selectedItems.join(';'); 
        pubsub.fire("updatelistfilterparms",this.cName.toLowerCase(),{"data":selectedItems});
    }
}