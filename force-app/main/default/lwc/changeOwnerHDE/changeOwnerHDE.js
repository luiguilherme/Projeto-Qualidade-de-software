import { LightningElement, api, track, wire } from 'lwc';
import { updateRecord, getRecord, getFieldValue } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { CloseActionScreenEvent } from "lightning/actions";
import getUserByRole from '@salesforce/apex/ChangeOwnerHDEController.getUserByRole';
import CASEID_FIELD from '@salesforce/schema/Case.Id';
import OWNERID_FIELD from '@salesforce/schema/Case.OwnerId';
import CASENUMBER_FIELD from '@salesforce/schema/Case.CaseNumber';
import { NavigationMixin } from "lightning/navigation";

export default class ChangeOwnerHDE extends NavigationMixin(LightningElement) {
    
    @api recordId;
    @api value;
    @track selectedRecordId;
    @track userOptions = [];
    results = [];

    @wire(getRecord, { recordId: '$recordId', fields: [CASENUMBER_FIELD]})
    case;

    get caseNumber(){
        return getFieldValue(this.case.data, CASENUMBER_FIELD);
    }

    @wire(getUserByRole, {caseId: '$recordId'})
    getOptions(result){
       
        if(result.data){

            this.results = result.data;
            this.userOptions = this.results.map(item => ({
                value: item.Id,
                label: item.Name
            }));

        }
    }

    handleValueSelected(event) {
        this.selectedRecordId = event.detail.value;
    }

    handleSave(){
        const fields = {};
        fields[CASEID_FIELD.fieldApiName] = this.recordId;
        fields[OWNERID_FIELD.fieldApiName] = this.selectedRecordId;
        const recordInput = {fields};

        updateRecord(recordInput);

        this.dispatchEvent(new CloseActionScreenEvent());

        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Success',
                message: 'Proprietário do Caso atualizado com sucesso!',
                variant: 'success'
            })
        );
    }

    handleDialogClose(){
        this.dispatchEvent(new CloseActionScreenEvent());
    }

}