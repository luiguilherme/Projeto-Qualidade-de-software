import { LightningElement, api } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import { encodeDefaultFieldValues } from 'lightning/pageReferenceUtils';

export default class CreateCaseRecordLWC extends NavigationMixin(LightningElement) {
    @api recordId;
    @api param;
    AccountId;
    ContactId;
    CustomerInteractionId;
    CustomerInteractionTopicId;
    
    connectedCallback(){
        let forceParamObject = JSON.parse(JSON.stringify(this.param))[0];
        const { AccountId, vlocity_cmt__PrimaryContactId__c: ContactId, VarContextId:CustomerInteractionId, TopicId:CustomerInteractionTopicId} = forceParamObject;

        this.AccountId = (AccountId !== undefined && AccountId !== "") ? AccountId : null;
        this.ContactId = (ContactId !== undefined && ContactId !== "") ? ContactId : null;
        this.CustomerInteractionId = (CustomerInteractionId !== undefined && CustomerInteractionId !== "") ? CustomerInteractionId : null;
        this.CustomerInteractionTopicId = (CustomerInteractionTopicId !== undefined && CustomerInteractionTopicId !== "") ? CustomerInteractionTopicId : null;
    }

    createNewCase() {
        const defaultValueCase = encodeDefaultFieldValues({
            AccountId: this.AccountId,
            ContactId: this.ContactId,
            CustomerInteractionId__c: this.CustomerInteractionId,
            CustomerInteractionTopic__c: this.CustomerInteractionTopicId
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