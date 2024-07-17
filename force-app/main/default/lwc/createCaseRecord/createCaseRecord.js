import { LightningElement, wire } from 'lwc';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import CASE_OBJECT from '@salesforce/schema/Case';
import USER_ID from '@salesforce/user/Id';
import { NavigationMixin } from 'lightning/navigation';

const USER_FIELDS = ['User.ProfileId'];

export default class createCaseRecord extends NavigationMixin(LightningElement) {
    selectedRecordTypeId;
    userInfo;
    recordTypes;

    @wire(getRecord, { recordId: USER_ID, fields: USER_FIELDS })
    user({ data, error }) {
        if (data) {
            console.log('usuario', JSON.stringify(data));
            console.log('sucesso no usuário 3');
            //const profileId = getFieldValue(data, 'ProfileId');
            this.userInfo = data.fields.ProfileId.value;
           //this.fetchRecordType(profileId);
        }else if (error) {
            console.log('An error has occurred:');
            console.log(error);
            // handle your error.
        }
    }

    @wire(getObjectInfo, { objectApiName: CASE_OBJECT })
    caseObjectInfo({ error, data }) {
        if (data) {
            console.log('sucesso no caso');
            console.log('print ',this.userInfo );
            this.recordTypes = data.recordTypeInfos;
            console.log('recordtype', JSON.stringify(this.recordTypes));

            for (const recordType in this.recordTypes) {
                if (this.recordTypes.hasOwnProperty(recordType)) {
                    const rtInfo = this.recordTypes[recordType];
                    if (rtInfo.available && rtInfo.profileId === this.userInfo) {
                        this.selectedRecordTypeId = rtInfo.recordTypeId;
                        this.createNewCase();
                        break;
                    }
                }
            }

        } else if (error) {
            console.log('An error has occurred: no CASO');
            console.log(error);
            // handle your error.
        }
    }

    connectedCallback(){
        console.log('connectCallback recTYpes', this.recordTypes);
        console.log('connectCallback userInfor', this.userInfo);
        for (const recordType in this.recordTypes) {
            console.log('iRecType ', recordType);

            if (this.recordTypes.hasOwnProperty(recordType)) {
                const rtInfo = this.recordTypes[recordType];
                console.log('iRecInfo ', rtInfo);

                // if (rtInfo.available && rtInfo.profileId === this.userInfo.data.fields.ProfileId.value) {
                //     this.selectedRecordTypeId = rtInfo.recordTypeId;
                //     break;
                // }
                if (rtInfo.available && rtInfo.profileId === this.userInfo) {
                    this.selectedRecordTypeId = rtInfo.recordTypeId;
                    console.log('selecrec', this.selectedRecordTypeId);
                    break;
                }
            }
        }
  
  }
    fetchRecordType(profileId) {
        this.userInfo = { data: { fields: { ProfileId: { value: profileId } } } };
        //this.userInfo.data.fields.ProfileId.value = profileId;
    }

    createNewCase() {
        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                objectApiName: 'Case',
                actionName: 'new',
                //recordTypeId: this.selectedRecordTypeId
            },
            state: {
                useRecordTypeCheck: '1',
                doRecordTypeCheck: '1'
            }
        });
    }
}