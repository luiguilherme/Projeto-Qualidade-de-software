import { LightningElement, wire, api, track } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import getAssetMobileMigration from '@salesforce/apex/AssetDAO.getAssetMobileMigration';

const FIELDS = ['vlocity_cmt__CustomerInteraction__c.vlocity_cmt__AccountId__c'];

const COLUMNS = [
    { label: 'Telefone', fieldName: 'PhoneNumber__c' },
    { label: 'Conta Faturamento', fieldName: 'vlocity_cmt__BillingAccountId__c' },
    { label: 'Tipo do Produto', fieldName: 'ProductType__c' },
    { label: 'Plano ', fieldName: 'MainProductDescription__c' },
    { label: 'Sistema de Origem ', fieldName: 'SourceSystem__c' }
];

export default class AssetMigrationSelection extends LightningElement {
    @track ltAssets = null;
    errorMsg;
    columns = COLUMNS;
    @api recordId;
    accountId;
    clickedButtonLabel;

    @wire(getRecord, { recordId: '$recordId', fields: FIELDS })
    customerInteraction({ error, data }) {
        if (data) {
            this.accountId = data.fields.vlocity_cmt__AccountId__c.value;
            getAssetMobileMigration({ accountId:this.accountId })
            .then((result) => {
                if (result != 0) {
                    this.ltAssets = result;
                } else {
                    this.errorMsg = 'Não foi possível identificar uma linha móvel para realizar a troca de oferta. Por favor realize a transação no sistema legado.';
                }
            })
            .catch((error) => {
                this.errorMsg = 'Ocorreu um erro. Reinicie o fluxo';
            });
        }
    }
    
    getSelectedAsset(event) {
        const selectedRows = event.detail.selectedRows;
        for (let i = 0; i < selectedRows.length; i++) {
            this.ltAssets[selectedRows[i].id] = selectedRows[i];
            //alert('A linha selecionada agora foi: ' + selectedRows[i].PhoneNumber__c);
        }
    }
}