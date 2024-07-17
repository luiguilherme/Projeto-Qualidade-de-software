import { LightningElement, api } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import {encodeDefaultFieldValues} from 'lightning/pageReferenceUtils';

export default class CreateCaseRecordLWC extends NavigationMixin(LightningElement) {
    @api recordId;
    @api param;
    AccountId;
    ContactId;
    
    connectedCallback(){
        let forceParamObject = JSON.parse(JSON.stringify(this.param))[0];
        const { AccountId, vlocity_cmt__PrimaryContactId__c: ContactId} = forceParamObject;

        this.AccountId = (AccountId !== undefined && AccountId !== "") ? AccountId : null;
        this.ContactId = (ContactId !== undefined && ContactId !== "") ? ContactId : null;
    }

    createNewCase() {
        const defaultValueCase = encodeDefaultFieldValues({
            AccountId: this.AccountId,
            ContactId: this.ContactId
        })
        
        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                objectApiName: 'Case',
                actionName: 'new',
            },
            state: {
                nooverride: '1',
                defaultFieldValues: defaultValueCase,
                useRecordTypeCheck: '1',
                doRecordTypeCheck: '1'
            }
        });
    }
}