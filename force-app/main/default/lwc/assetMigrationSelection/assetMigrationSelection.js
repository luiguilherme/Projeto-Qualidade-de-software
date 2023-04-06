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
    pageNumber = 1;
    pageSize = 5;
    totalItemCount = 0
    @track ltAssetsFull;
    errorMsg;
    columns = COLUMNS;
    @api recordId;
    accountId;
    clickedButtonLabel;
    assetMigrationNumber;

    @wire(getRecord, { recordId: '$recordId', fields: FIELDS })
    customerInteraction({ error, data }) {
        if (data) {
            this.accountId = data.fields.vlocity_cmt__AccountId__c.value;
            getAssetMobileMigration({ accountId:this.accountId })
            .then((result) => {
                if (result != 0) {
                    this.totalItemCount = result.length;
                    this.ltAssets = result.slice(
                        (this.pageNumber - 1) * this.pageSize,
                        this.pageNumber * this.pageSize
                    );
                    this.ltAssetsFull = result;
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
            this.assetMigrationNumber = selectedRows[i].PhoneNumber__c;
        }
    }

    handlePreviousPage() {
        this.pageNumber = this.pageNumber - 1;
        this.ltAssets = this.ltAssetsFull.slice(
            (this.pageNumber - 1) * this.pageSize,
            this.pageNumber * this.pageSize
        );
    }
    
    handleNextPage() {
        this.pageNumber = this.pageNumber + 1;
        this.ltAssets = this.ltAssetsFull.slice(
            (this.pageNumber - 1) * this.pageSize,
            this.pageNumber * this.pageSize
        );
    }

    callCanvas(event) {
        let ev = new CustomEvent('callcanvashybris', {
                                detail : {
                                    data: JSON.stringify(this.assetMigrationNumber)
                                }
                            });
            this.dispatchEvent(ev);
    }

}