import { LightningElement, api, track, wire } from 'lwc';
import { updateRecord, getRecord, getFieldValue } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { CloseActionScreenEvent } from "lightning/actions";
import hasAccess from '@salesforce/apex/ChangeOwnerHDEController.hasAccess';
import getUserByRole from '@salesforce/apex/ChangeOwnerHDEController.getUserByRole';
import updateOwnerCase from '@salesforce/apex/ChangeOwnerHDEController.updateOwnerCase';
import CASEID_FIELD from '@salesforce/schema/Case.Id';
import OWNERID_FIELD from '@salesforce/schema/Case.OwnerId';
import CASENUMBER_FIELD from '@salesforce/schema/Case.CaseNumber';
import { NavigationMixin } from "lightning/navigation";
import { RefreshEvent } from "lightning/refresh";


export default class ChangeOwnerHDE extends NavigationMixin(LightningElement) {
    
    @api recordId;
    @api value;
    selectedRecordId;
    @track userOptions = [];
    results = [];
    openChangeOwner = false;
    


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

    @wire(hasAccess)
    checkAccess(result){
        if(result){
            this.openChangeOwner = result.data;
            const currentUrl = window.location.href;
            var mySubString = currentUrl.substring(
            currentUrl.indexOf("/500") + 1, 
            currentUrl.lastIndexOf("/")
            );
            this.recordId = mySubString;
        }
    } 

    handleValueSelected(event) {
        console.log('erick ', event.detail.value);
        this.selectedRecordId = event.detail.value;
    }

    handleSave(){
        updateOwnerCase({caseId :  this.recordId, ownerId : this.selectedRecordId}).then((result) => {
            this.dispatchEvent(new CustomEvent('recordchange'));
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Proprietário do Caso atualizado com sucesso!',
                    variant: 'success'
                })
            );

        }).catch((error) => {
            console.log('error ', error);
        });
        
    }

    handleDialogClose(){
        this.dispatchEvent(new CloseActionScreenEvent());
    }

}