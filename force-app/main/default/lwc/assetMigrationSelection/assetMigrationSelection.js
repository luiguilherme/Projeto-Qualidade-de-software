import { LightningElement, wire, api, track } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import getAssetMigration from '@salesforce/apex/AssetDAO.getAssetMigration';

const FIELDS = [
    'vlocity_cmt__CustomerInteraction__c.vlocity_cmt__AccountId__c',
    'vlocity_cmt__CustomerInteraction__c.InteractionNumber__c'
];

const COLUMNS = [
    { label: 'Instância/Linha'      , fieldName: 'Name' },
    { label: 'Endereço'             , fieldName: 'endereco', wrapText:true },
    { label: 'Tipo'                 , fieldName: 'ProductType__c' },
    { label: 'Plano'                , fieldName: 'MainProductDescription__c' },
    { label: 'Código Oferta'        , fieldName: 'IdBundle__c' },
    { label: 'Sistema de Origem '   , fieldName: 'SourceSystem__c' }
];

const OPTIONS_TYPE = [
    { label: 'Vivo Total'   , value: 'vivoTotalMigration'   , variant: "slds-button slds-button_neutral button-spacing" },
    { label: 'Móvel'        , value: 'migration'            , variant: "slds-button slds-button_neutral button-spacing" },
    { label: 'Fixa'         , value: 'fixaMigration'        , variant: "slds-button slds-button_neutral button-spacing" },
];

export default class AssetMigrationSelection extends LightningElement {
    @track ltAssets = null;
    tipoInput = 'checkbox';
    pageNumber = 1;
    pageSize = 10;
    totalItemCount = 0;
    @track ltAssetsFull = [];
    errorMsg;
    columns = COLUMNS;
    optionsTypes = OPTIONS_TYPE;
    @api recordId;
    accountId;
    customerInteractionNumber;
    clickedButtonLabel;
    @track selectedRows = [];
    @track rowSelection;
    assetMigrationNumber = [];
    selectionTypeMigration = true;
    buttonAdvanceToListAssets = true;
    valueTypeMigrationSelected = '';
    messageTypeFluxo = '';
    msgError = false;
    itemselect;
    idselect;

    @wire(getRecord, { recordId: '$recordId', fields: FIELDS })
    customerInteraction({ error, data }) {
        if (data) {
            this.accountId = data.fields.vlocity_cmt__AccountId__c.value;
            this.customerInteractionNumber = data.fields.InteractionNumber__c.value;
        }
    }

    async changeValueTypeMigration(event){
        await this.backToSelectionTypeMigration();
         
        this.valueTypeMigrationSelected = event.target.value;  

        this.optionsTypes.forEach(item => {
            if (item.value == event.target.value ) {
                item.variant = "slds-button slds-button_brand button-spacing"
            } else {
                item.variant = "slds-button slds-button_neutral button-spacing"
            }
        });
                
        this.buttonAdvanceToListAssets = false;
    }

    callListAssets(){
        try {
            this.getAssetMigrations();
            this.selectionTypeMigration = false;

            this.optionsTypes.forEach(item => {
                item.variant = "slds-button slds-button_neutral button-spacing"
            });
        } catch (error) {
            console.log('ERROR callListAssets(): ' + error);
        }
    }

    backToSelectionTypeMigration(){
        this.modificarTitulo('Troca de Ofertas');
        this.selectionTypeMigration = true;
        this.ltAssets = false;
        this.msgError = false;
        this.buttonAdvanceToListAssets = true;
        this.optionsTypes.forEach(item => {
            item.variant = "slds-button slds-button_neutral button-spacing"
        });
    }

    getAssetMigrations(){
        getAssetMigration({ 
            accountId:this.accountId                
        }).then((result) => {
            this.ltAssetsFull = result;
            this.RemoveParesIdBundles(); // METODO ADICIONADO TEMPORARIAMENTE

            switch (this.valueTypeMigrationSelected) {
                case 'migration':
                    this.formatMovel();
                    break;
                case 'fixaMigration':
                    this.formatFixa();
                    break;
                case 'vivoTotalMigration':
                    this.formatVivoTotal();
                    break;
            }
        }).catch((error) => {
            this.errorMsg = 'Ocorreu um erro. Reinicie o fluxo';
            this.msgError = true;
            this.ltAssets = false;
            console.log('ERROR getAssetMigrations(): ' + error);
        });
    }

    formatMovel(){
        this.modificarTitulo('Troca de Ofertas - Móvel');
        this.tipoInput = 'radio';
        this.assetMigrationNumber = [];
        let ltAssetsCopy = this.ltAssetsFull;

        let cont = ltAssetsCopy.length;
        if (cont != 0) {
            this.ltAssetsFull = [];
            ltAssetsCopy.forEach(itemAsset => {
                let contBundle = ltAssetsCopy.filter(item => item.IdBundle__c == itemAsset.IdBundle__c && (item.IdBundle__c != null || item.IdBundle__c != undefined));

                if (contBundle.length == 1 && itemAsset.Type__c == 'Movel' && !itemAsset.OfferDescription__c.toUpperCase().includes('VIVO TOTAL')) {
                    itemAsset.endereco = (itemAsset.vlocity_cmt__BillingAccountId__r != null || itemAsset.vlocity_cmt__BillingAccountId__r != undefined) ? itemAsset.vlocity_cmt__BillingAccountId__r.FullAddress__c.replace('Rua,', '').replaceAll(',', ', ') : null;
                    itemAsset.disableCheckbox = false;
                    itemAsset.checked = false;
                    this.ltAssetsFull.push(itemAsset);
                }
            });
            
            this.ltAssets = this.ltAssetsFull.slice(
                (this.pageNumber - 1) * this.pageSize,
                this.pageNumber * this.pageSize,
                this.rowSelection = 1
            );

            this.totalItemCount = this.ltAssetsFull.length;
            this.messageTypeFluxo = 'Importante: Não é possível realizar trocas de ofertas de linhas móveis com dependentes.';
        }

        if (this.totalItemCount == 0){
            this.errorMsg = 'Não foi possível identificar um produto Fixa para realizar a troca de oferta. Por favor realize a transação no sistema legado.';
            this.msgError = true;
            this.ltAssets = false;
        }
    }

    formatFixa(){
        this.modificarTitulo('Troca de Ofertas - Fixa');
        this.tipoInput = 'radio';
        this.assetMigrationNumber = [];
        let ltAssetsCopy = this.ltAssetsFull;

        let cont = ltAssetsCopy.length;
        if (cont != 0) {
            this.ltAssetsFull = [];
            ltAssetsCopy.forEach(itemAsset => {
                if (itemAsset.Type__c == 'Fixa' && !itemAsset.OfferDescription__c.toUpperCase().includes('VIVO TOTAL')) {
                    itemAsset.endereco = (itemAsset.vlocity_cmt__ServiceAccountId__r != null || itemAsset.vlocity_cmt__ServiceAccountId__r != undefined) ? itemAsset.vlocity_cmt__ServiceAccountId__r.FullAddress__c.replace('Rua,', '').replaceAll(',', ', ') : null;
                    itemAsset.disableCheckbox = false;
                    itemAsset.checked = false;
                    this.ltAssetsFull.push(itemAsset);
                }
            });
            
            this.ltAssets = this.ltAssetsFull.slice(
                (this.pageNumber - 1) * this.pageSize,
                this.pageNumber * this.pageSize,
                this.rowSelection = 1
            );

            this.totalItemCount = this.ltAssetsFull.length;
            this.messageTypeFluxo = 'Importante: É possível apenas realizar trocas de ofertas 1P Banda Larga para 1P Banda Larga.';
        } 
        
        if (this.totalItemCount == 0){
            this.errorMsg = 'Não foi possível identificar um produto Fixa para realizar a troca de oferta. Por favor realize a transação no sistema legado.';
            this.msgError = true;
            this.ltAssets = false;
        }
    }

    formatVivoTotal(){
        this.modificarTitulo('Troca de Ofertas - Vivo Total');
        this.tipoInput = 'checkbox';
        this.assetMigrationNumber = [];

        let ltAssetsCopy = this.ltAssetsFull;
        let cont = ltAssetsCopy.length;
        if (cont != 0) {
            this.ltAssetsFull = [];
            ltAssetsCopy.forEach(item => {
                item.disableCheckbox = false;
                item.checked = false;
                switch (item.Type__c) {
                    case 'Fixa':
                        item.endereco = (item.vlocity_cmt__ServiceAccountId__r != null || item.vlocity_cmt__ServiceAccountId__r != undefined) ? item.vlocity_cmt__ServiceAccountId__r.FullAddress__c.replace('Rua,', '').replaceAll(',', ', ') : null;    
                        break;
                    case 'Movel':
                        item.endereco = (item.vlocity_cmt__BillingAccountId__r != null || item.vlocity_cmt__BillingAccountId__r != undefined) ? item.vlocity_cmt__BillingAccountId__r.FullAddress__c.replace('Rua,', '').replaceAll(',', ', ') : null;
                        break;
                }

                if (item.OfferDescription__c.toUpperCase().includes('VIVO TOTAL') || item.Type__c == 'Movel') {
                    this.ltAssetsFull.push(item);
                }           
            });
            
            this.ltAssets = this.ltAssetsFull.slice(
                (this.pageNumber - 1) * this.pageSize,
                this.pageNumber * this.pageSize,
                this.rowSelection = 1
            );

            this.totalItemCount = this.ltAssetsFull.length;
            this.messageTypeFluxo = 'Importante: É possível apenas realizar trocas de ofertas 1P Banda Larga, 1P Controle ou 1P Pós-Pago para Vivo Total.';
        } 
        
        if (this.totalItemCount == 0){
            this.errorMsg = 'Não foi possível identificar um produto Fixa para realizar a troca de oferta. Por favor realize a transação no sistema legado.';
            this.msgError = true;
            this.ltAssets = false;
        }
    }

    RemoveParesIdBundles(){
        let ltAssetsCopy = this.ltAssetsFull;
        this.ltAssetsFull = [];
        
        ltAssetsCopy.forEach(itemAsset => {
            let contBundle = ltAssetsCopy.filter(item => item.IdBundle__c == itemAsset.IdBundle__c && (item.IdBundle__c != null || item.IdBundle__c != undefined));
            
            switch (this.valueTypeMigrationSelected) {
                case 'migration':
                    this.ltAssetsFull.push(itemAsset);
                    break;
                case 'fixaMigration':
                    if (contBundle.length == 1 && itemAsset.ProductType__c == 'Banda Larga') {
                        this.ltAssetsFull.push(itemAsset);
                    }
                    break;
                case 'vivoTotalMigration':
                    if (contBundle.length == 1 && itemAsset.Type__c == 'Movel') {
                        this.ltAssetsFull.push(itemAsset);
                    }else if (contBundle.length > 1 && (itemAsset.ProductType__c == 'Banda Larga' || itemAsset.ProductType__c == 'Pós-Pago')) {
                        this.ltAssetsFull.push(itemAsset);
                    }
                    break;
            }

            /* if (contBundle.length == 1) {
                if (this.valueTypeMigrationSelected == 'fixaMigration' && contBundle[0].ProductType__c == 'Banda Larga' ) {
                    this.ltAssetsFull.push(contBundle[0]);
                }else if (this.valueTypeMigrationSelected == 'migration' ) {
                    this.ltAssetsFull.push(contBundle[0]);
                }
            } */

        });
    }
    
    getSelectedAsset(event) { 
        try {
            let checkBoxChecked = event.target.checked;
            let idSelecionado = event.target.value;
            
            if (this.valueTypeMigrationSelected == 'migration' || this.valueTypeMigrationSelected == 'fixaMigration') {
                this.ltAssetsFull.forEach(item=>{
                    item.checked = false;
                });
            }

            this.ltAssetsFull.forEach(item=>{
                if(idSelecionado == item.Id && !item.disableCheckbox){
                    item.checked = checkBoxChecked;

                    if (this.valueTypeMigrationSelected == 'vivoTotalMigration') {
                        this.validateLstAssets(checkBoxChecked, item);
                    }
                }
            });

        } catch (error) {
            this.errorMsg = 'Ocorreu um erro. Reinicie o fluxo';
            this.msgError = true;
            this.ltAssets = false;
            console.log('ERROR getSelectedAsset(): ' + error);
        }
    }

    validateLstAssets(checkBoxChecked, linhaSelected) {
        let movelSelected = false;
        let contBundleUnicoSelected = 0;
        let contMovel = this.ltAssetsFull.filter(item => item.Type__c == 'Movel' && this.valueTypeMigrationSelected == 'vivoTotalMigration').length;
        let contIdBundlesSelected = this.ltAssetsFull.filter(item => item.IdBundle__c == linhaSelected.IdBundle__c && (item.IdBundle__c != null || item.IdBundle__c != undefined)).length;

        this.ltAssetsFull.forEach(itemAsset => {
            // ######################################## Selecionar todos os registros com o mesmo IdBundle__c ########################################
            if (itemAsset.IdBundle__c == linhaSelected.IdBundle__c && linhaSelected.Id != itemAsset.Id && !itemAsset.disableCheckbox && (itemAsset.IdBundle__c != null || itemAsset.IdBundle__c != undefined)){
                itemAsset.checked = checkBoxChecked;
            }

            // Verificando de tem algum produto Móvel selecionado
            if (!movelSelected && this.valueTypeMigrationSelected == 'vivoTotalMigration' && itemAsset.Type__c == 'Movel') {
                movelSelected = itemAsset.checked;
            }
        });
        
        if (contIdBundlesSelected < 2) {
            // ######################################## No fluxo 'Vivo Total', só pode selecionar 1 produto móvel ########################################
            if (contMovel >= 2) {
                this.ltAssetsFull.forEach(itemAsset => {            
                    if (itemAsset.Type__c == 'Movel' && !itemAsset.checked) {
                        itemAsset.checked = false;

                        if (movelSelected) {
                            itemAsset.disableCheckbox = true;
                        }else{
                            itemAsset.disableCheckbox = false;
                        }
                    }
                });
            }

            // ######################################## Não selecionar dois registros com o mesmo ProductType__c ########################################
            this.ltAssetsFull.forEach(itemAsset => {
                this.ltAssetsFull.forEach(elementAsset => {              
                    if (elementAsset.ProductType__c == itemAsset.ProductType__c && elementAsset.Id != itemAsset.Id) {
                        elementAsset.disableCheckbox = itemAsset.checked;
                    }
                });
            });

            // ######################################## Se o registro selecionado NÃO tiver mais de um registro com o mesmo IdBundle__c, deixar selecionar apenas os itens de IdBundle__c único ########################################
            this.ltAssetsFull.forEach(itemAsset => {
                let contBundle = this.ltAssetsFull.filter(item => item.IdBundle__c == itemAsset.IdBundle__c && item.checked && (item.IdBundle__c != null || item.IdBundle__c != undefined));
                if (contBundle.length == 1) {
                    contBundleUnicoSelected++;
                }
            });
            this.ltAssetsFull.forEach(itemAsset => {
                let contBundle = this.ltAssetsFull.filter(item => item.IdBundle__c == itemAsset.IdBundle__c && (item.IdBundle__c != null || item.IdBundle__c != undefined));

                if (contBundleUnicoSelected >= 1 && contBundle.length >= 2) {
                    itemAsset.disableCheckbox = true;
                }else if (contBundleUnicoSelected == 0 && contBundle.length >= 2 && (linhaSelected.IdBundle__c == null || linhaSelected.IdBundle__c == undefined)) {
                    itemAsset.disableCheckbox = checkBoxChecked;
                }
                // Caso não tenha nenhum registro com IdBundle__c unico:
                else if (contBundleUnicoSelected == 0 && contBundle.length >= 2) {
                    let contProductSelected = this.ltAssetsFull.filter(elementAsset => elementAsset.ProductType__c == itemAsset.ProductType__c && elementAsset.Id != itemAsset.Id && elementAsset.checked);
                    let contBundleNull = this.ltAssetsFull.filter(item => item.checked && (item.IdBundle__c == null || item.IdBundle__c == undefined));

                    // Caso um produto móvel ja esteja desabilitado, mante-lo desabilitado
                    if (movelSelected && itemAsset.Type__c == 'Movel' && itemAsset.disableCheckbox) {
                        itemAsset.disableCheckbox = true;
                    }
                    // Caso um produto com o mesmo ProductType__c ja esteja desabilitado, mante-lo desabilitado
                    else if (contProductSelected.length == 1) {
                        this.ltAssetsFull.forEach(elementAsset => {
                            if (itemAsset.ProductType__c == elementAsset.ProductType__c && elementAsset.Id != itemAsset.Id) {
                                itemAsset.disableCheckbox = true;
                            }
                        });
                    }
                    // Caso tenha um registro com IdBundle__c vazio, manter os registros bloqueados
                    else if (contBundleNull.length > 0) {
                        itemAsset.disableCheckbox = true;
                    }
                    else{
                        itemAsset.disableCheckbox = false;
                    }
                }
            });
        } else{
            // ######################################## Se o registro selecionado tiver mais de um registro com o mesmo IdBundle__c, bloquear o restante dos itens ########################################
            this.ltAssetsFull.forEach(itemAsset => {
                if (itemAsset.IdBundle__c != linhaSelected.IdBundle__c) {
                    itemAsset.disableCheckbox = checkBoxChecked;
                } 
            });
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
        this.ltAssetsFull.forEach(item =>{
            if (item.checked) {
                item.tipoOferta = this.valueTypeMigrationSelected;
                this.assetMigrationNumber.push(item);
            }
        });
        let ev = new CustomEvent('callcanvashybris', {
                                detail : {
                                    data: JSON.stringify(this.assetMigrationNumber)
                                }
                            });
            this.dispatchEvent(ev);
    }

    modificarTitulo(title){
        let ev = new CustomEvent('modifytitle', {
            detail : {
                data: JSON.stringify(title)
            }
        });
        
        this.dispatchEvent(ev);
    }
}