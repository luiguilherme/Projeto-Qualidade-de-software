public abstract class CanvasHybrisServices implements CanvasServiceInterface {
    
    // private static final String TIPO_OFERTA = 'migration'; // movel
    // private static final String TIPO_OFERTA = 'fixaMigration'; fixa
    // private static final String TIPO_OFERTA = 'vivoTotalMigration'; Vivo Total
    
    public String getConnectedAppName() {
        System.debug('AQUI');
        return 'HybrisCanvas';
    }

    public Map<String,Object> getParameters(List<String> ListId,String tipoOferta ){
        List<Asset> context = query(ListId);
        
        return canvasResultParameters(context,tipoOferta);
    }
    
    private Map<String,Object> canvasResultParameters(List<Asset> context, string tipoOferta){
        Map<String,Object> parameters = new Map<String,Object>();
        User currentUser = UserDAO.getById(System.UserInfo.getUserId());
        String userRole = currentUser.Profile.UserLicense.Name != 'Partner Community' ? currentUser.UserRole.DeveloperName : currentUser.PartnerGroup__c;
        CanvasHybrisMigration__mdt hybrisMetadata = CanvasHybrisMigrationDAO.getByUserRole(userRole);
        
        Endereco endereco = getAddress(context[0]);
        List<produtosMigracao> listProdutos = getProdutos(context);
        List<Asset> listNext = AssetDAO.getAssetNext(context[0].AccountId);

        parameters.put('documento',         context[0].account.DocumentNumber__c != null ? context[0].account.DocumentNumber__c : '');
        parameters.put('nomeConta',         context[0].account.Name != null ? context[0].account.Name : '');
        parameters.put('nomeMae',           context[0].account.vlocity_cmt__PrimaryContactId__r.MotherName__c  != null ? context[0].account.vlocity_cmt__PrimaryContactId__r.MotherName__c : '');
        parameters.put('email',             context[0].account.vlocity_cmt__PrimaryContactId__r.Email   != null ? context[0].account.vlocity_cmt__PrimaryContactId__r.Email : '');
        parameters.put('telefoneContato',   context[0].account.vlocity_cmt__PrimaryContactId__r.MobilePhone   != null ? context[0].account.vlocity_cmt__PrimaryContactId__r.MobilePhone : '');
        parameters.put('dataNascimento',    formatBirthDate(context[0].account));
        parameters.put('endereco',          endereco);
        parameters.put('tipoOferta',        tipoOferta);
        parameters.put('nomeOperador',      currentUser.Name);
        parameters.put('emailOperador',     currentUser.Email);
        parameters.put('loginRede',         currentUser.Login__c);
        parameters.put('canalOperador',     hybrisMetadata.UserChannel__c != null ? hybrisMetadata.UserChannel__c : '');
        parameters.put('segmento',          getUserSegments(hybrisMetadata.UserSegment__c));
        parameters.put('posToPre',          hybrisMetadata.PosToPre__c);
        parameters.put('controleToPre',     hybrisMetadata.ControleToPre__c);
        parameters.put('ofertasRetencao',   hybrisMetadata.RetentionOffers__c);
        parameters.put('adabas',            currentUser.Adabas__c != null ? currentUser.Adabas__c : '0');
        parameters.put('clienteNext',       listNext.size() == 0 ? false : true);
        parameters.put('produtosMigracao',  listProdutos);
        
        return parameters;
    }
        
    private Endereco getAddress (Asset context){
        Endereco enderecoReturn = new Endereco();
        
        // FLUXO FIXA
        if(context.Type__c == 'Fixa'){
            enderecoReturn.cep = context.vlocity_cmt__ServiceAccountId__r.ShippingPostalCode != null ? context.vlocity_cmt__ServiceAccountId__r.ShippingPostalCode : '';
            enderecoReturn.numero = context.vlocity_cmt__ServiceAccountId__r.ShippingNumber__c != null ? context.vlocity_cmt__ServiceAccountId__r.ShippingNumber__c : '';
            enderecoReturn.complemento = context.vlocity_cmt__ServiceAccountId__r.FullComplement__c != null ? context.vlocity_cmt__ServiceAccountId__r.FullComplement__c : '';
            enderecoReturn.cidade = context.vlocity_cmt__ServiceAccountId__r.ShippingCity != null ? context.vlocity_cmt__ServiceAccountId__r.ShippingCity : '';
            enderecoReturn.bairro = context.vlocity_cmt__ServiceAccountId__r.ShippingNeighborhood__c != null ? context.vlocity_cmt__ServiceAccountId__r.ShippingNeighborhood__c : '';
            enderecoReturn.estado = context.vlocity_cmt__ServiceAccountId__r.ShippingState != null ? context.vlocity_cmt__ServiceAccountId__r.ShippingState : '';
            enderecoReturn.rua = context.vlocity_cmt__ServiceAccountId__r.ShippingStreet != null ? context.vlocity_cmt__ServiceAccountId__r.ShippingStreet : '';
            
            return enderecoReturn;
        }
        
        // FLUXO MÓVEL
        if(context.ProductType__c != 'Pré-Pago') {
            enderecoReturn.cep = context.vlocity_cmt__BillingAccountId__r.BillingPostalCode != null ? context.vlocity_cmt__BillingAccountId__r.BillingPostalCode : '';
            enderecoReturn.numero = context.vlocity_cmt__BillingAccountId__r.BillingNumber__c != null ? context.vlocity_cmt__BillingAccountId__r.BillingNumber__c : '';
            enderecoReturn.complemento = context.vlocity_cmt__BillingAccountId__r.FullComplement__c != null ? context.vlocity_cmt__BillingAccountId__r.FullComplement__c : '';
            enderecoReturn.cidade = context.vlocity_cmt__BillingAccountId__r.ShippingCity != null ? context.vlocity_cmt__BillingAccountId__r.ShippingCity : '';
            enderecoReturn.bairro = context.vlocity_cmt__BillingAccountId__r.ShippingNeighborhood__c != null ? context.vlocity_cmt__BillingAccountId__r.ShippingNeighborhood__c : '';
            enderecoReturn.estado = context.vlocity_cmt__BillingAccountId__r.ShippingState != null ? context.vlocity_cmt__BillingAccountId__r.ShippingState : '';
            enderecoReturn.rua = context.vlocity_cmt__BillingAccountId__r.ShippingStreet != null ? context.vlocity_cmt__BillingAccountId__r.ShippingStreet : '';
        } else{
            List<Asset> lstAllAssets = AssetDAO.getAssetMobileByAccount(context.AccountId);
            Boolean onlyPrePaid = true;
            for(Asset iAsset : lstAllAssets){
                if (iAsset.ProductType__c != 'Pré-Pago'){
                    onlyPrePaid = false;
                    break;
                }
            }
            
            if(onlyPrePaid){
                enderecoReturn.cep ='';
                enderecoReturn.numero = '';
                enderecoReturn.complemento = '';
                enderecoReturn.cidade = '';
                enderecoReturn.bairro = '';
                enderecoReturn.estado = '';
                enderecoReturn.rua = '';
            } else{
                List<Account> lstBillingAddress = [SELECT BillingAddress, BillingStreet, BillingPostalCode, BillingNumber__c, ShippingAddress, ShippingStreet, ShippingPostalCode, ShippingNumber__c, RecordTypeId, BillingAccountType__c, FullComplement__c  FROM Account WHERE ParentId = :context.AccountId AND RecordType.DeveloperName  = 'Billing']; 
                if(lstBillingAddress == null){
                    enderecoReturn.cep ='';
                    enderecoReturn.numero = '';
                    enderecoReturn.complemento = '';
                    enderecoReturn.cidade = '';
                    enderecoReturn.bairro = '';
                    enderecoReturn.estado = '';
                    enderecoReturn.rua = '';
                } else {
                    Boolean haveBillingAddress = false;
                
                    for(Account iBillingAddress : lstBillingAddress){
                        if(iBillingAddress.BillingAddress != null){
                            haveBillingAddress = true;
                            enderecoReturn.cep = iBillingAddress.BillingPostalCode != null ? iBillingAddress.BillingPostalCode : '';
                            enderecoReturn.numero = iBillingAddress.BillingNumber__c != null ? iBillingAddress.BillingNumber__c : '';
                            enderecoReturn.complemento = iBillingAddress.FullComplement__c != null ? iBillingAddress.FullComplement__c : '';
                            enderecoReturn.complemento = iBillingAddress.ShippingCity != null ? iBillingAddress.ShippingCity : '';
                            enderecoReturn.complemento = iBillingAddress.ShippingNeighborhood__c != null ? iBillingAddress.ShippingNeighborhood__c : '';
                            enderecoReturn.complemento = iBillingAddress.ShippingState != null ? iBillingAddress.ShippingState : '';
                            enderecoReturn.complemento = iBillingAddress.ShippingStreet != null ? iBillingAddress.ShippingStreet : '';
                            
                            break;
                        }
                    }
                    
                    if(!haveBillingAddress){
                        enderecoReturn.cep ='';
                        enderecoReturn.numero = '';
                        enderecoReturn.complemento = '';
                        enderecoReturn.cidade = '';
                        enderecoReturn.bairro = '';
                        enderecoReturn.estado = '';
                        enderecoReturn.rua = '';
                    }
                }
            }
        } 
        return enderecoReturn;
    }
    
    private List<produtosMigracao> getProdutos(List<Asset> context){
        List<produtosMigracao> listProdutos = new List<produtosMigracao>();
        
        for (Asset item: context) {
            produtosMigracao ptMig = new produtosMigracao();
            ptMig.instancia             = item.Name                                 == null ? '' : item.Name;
            ptMig.sistemaOrigem         = item.SourceSystem__c                      == null ? '' : item.SourceSystem__c;
            ptMig.descricaoProduto      = item.MainProductDescription__c            == null ? '' : item.MainProductDescription__c;
            ptMig.tipoProduto           = item.ProductType__c                       == null ? '' : item.ProductType__c;
            ptMig.idOferta              = item.IdBundle__c                          == null ? '' : item.IdBundle__c;
            ptMig.armarioInstalacao     = item.Cabinet__c                           == null ? '' : item.Cabinet__c;
            ptMig.preco                 = String.valueOf(item.PriceCurrent__c)      == null ? '': String.valueOf(item.PriceCurrent__c);
            ptMig.endereco              = getAddress(item);
            
            listProdutos.add(ptMig);
        }

        return listProdutos;
    }

    private String formatBirthDate (Account context) {
        if (context.vlocity_cmt__PrimaryContactId__r.Birthdate != null) {
            String dateString = String.valueof(context.vlocity_cmt__PrimaryContactId__r.Birthdate);
            return dateString;
        } else {
            return '';
        }
    } 
   
    private List<String> getUserSegments(String userSegment) {
        List<String> lstSegment = userSegment.split(',');
        for (String segment : lstSegment) {
            segment = segment.trim();
        }
        return lstSegment;
    }

    private class Endereco {
        @AuraEnabled public string cep {get; set;}
        @AuraEnabled public string numero {get; set;}
        @AuraEnabled public string complemento {get; set;}
        @AuraEnabled public string cidade {get; set;}
        @AuraEnabled public string bairro {get; set;}
        @AuraEnabled public string estado {get; set;}
        @AuraEnabled public string rua {get; set;}
    }
     

    private class produtosMigracao{
        @AuraEnabled 
        public String instancia {get; set;}
        @AuraEnabled 
        public String sistemaOrigem {get; set;}
        @AuraEnabled 
        public String descricaoProduto {get; set;}
        @AuraEnabled 
        public String tipoProduto {get; set;}
        @AuraEnabled 
        public String idOferta {get; set;}
        @AuraEnabled 
        public String armarioInstalacao {get; set;}
        @AuraEnabled 
        public String preco {get; set;}
        @AuraEnabled 
        public Endereco endereco {get; set;}
    }

    protected abstract List<Asset> query(List<String> listRecordId);
}