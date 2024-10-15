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
    ComplainedAsset;
    HDEOtherProducts;
    SegmentProduct;
    
    connectedCallback(){
        let forceParamObject = JSON.parse(JSON.stringify(this.param))[0];
        const { AccountId, vlocity_cmt__PrimaryContactId__c: ContactId, VarContextId:CustomerInteractionId, TopicId:CustomerInteractionTopicId, OtherProduct:HDEOtherProducts, ProductType: SegmentProduct, AssetId:ComplainedAsset} = forceParamObject;

        this.AccountId = (AccountId !== undefined && AccountId !== "") ? AccountId : null;
        this.ContactId = (ContactId !== undefined && ContactId !== "") ? ContactId : null;
        this.CustomerInteractionId = (CustomerInteractionId !== undefined && CustomerInteractionId !== "") ? CustomerInteractionId : null;
        this.CustomerInteractionTopicId = (CustomerInteractionTopicId !== undefined && CustomerInteractionTopicId !== "") ? CustomerInteractionTopicId : null;
        this.HDEOtherProducts = (HDEOtherProducts !== undefined && HDEOtherProducts !== "") ? HDEOtherProducts : null;
        this.SegmentProduct = (SegmentProduct !== undefined && SegmentProduct !== "") ? SegmentProduct : null;
        this.ComplainedAsset = (ComplainedAsset !== undefined && ComplainedAsset !== "") ? ComplainedAsset : null;
    }

    createNewCase() {
        const defaultValueCase = encodeDefaultFieldValues({
            AccountId: this.AccountId,
            ContactId: this.ContactId,
            CustomerInteractionId__c: this.CustomerInteractionId,
            CustomerInteractionTopic__c: this.CustomerInteractionTopicId,
            HDEOtherProducts__c:this.HDEOtherProducts,
            SegmentProduct__c:this.SegmentProduct,
            ComplainedAsset__c:this.ComplainedAsset
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