public abstract class CanvasHybrisServices implements CanvasServiceInterface {
    
    private static final String TIPO_OFERTA = 'migration';
    
    public String getConnectedAppName() {
        return 'HybrisCanvas';
    }

    public Map<String,Object> getParameters(Id id){
        Asset context = query(id);
        
        return canvasResultParameters(context);
    }
    
    private Map<String,Object> canvasResultParameters(Asset context){

        Map<String,Object> parameters = new Map<String,Object>();
        User currentUser = UserDAO.getById(System.UserInfo.getUserId());
        String userRole = currentUser.Profile.UserLicense.Name != 'Partner Community' ? currentUser.UserRole.DeveloperName : currentUser.PartnerGroup__c;
        CanvasHybrisMigration__mdt hybrisMetadata = CanvasHybrisMigrationDAO.getByUserRole(userRole);
        
        parameters.put('documento',         context.account.DocumentNumber__c != null ? context.account.DocumentNumber__c : '');
        parameters.put('nomeConta',         context.account.Name != null ? context.account.Name : '');
        parameters.put('endereco',          getAddress(context));
        parameters.put('nomeMae',           context.account.vlocity_cmt__PrimaryContactId__r.MotherName__c  != null ? context.account.vlocity_cmt__PrimaryContactId__r.MotherName__c : '');
        parameters.put('email',             context.account.vlocity_cmt__PrimaryContactId__r.Email   != null ? context.account.vlocity_cmt__PrimaryContactId__r.Email : '');
        parameters.put('telefoneContato',   context.account.vlocity_cmt__PrimaryContactId__r.MobilePhone   != null ? context.account.vlocity_cmt__PrimaryContactId__r.MobilePhone : '');
        parameters.put('dataNascimento',    formatBirthDate(context.account));
        parameters.put('tipoOferta',        TIPO_OFERTA);
        parameters.put('nomeOperador',      currentUser.Name);
        parameters.put('emailOperador',     currentUser.Email);
        parameters.put('loginRede',         currentUser.Login__c);
        parameters.put('canalOperador',     hybrisMetadata.UserChannel__c != null ? hybrisMetadata.UserChannel__c : '');
        parameters.put('segmento',          getUserSegments(hybrisMetadata.UserSegment__c));
        parameters.put('posToPre',          hybrisMetadata.PosToPre__c);
        parameters.put('controleToPre',     hybrisMetadata.ControleToPre__c);
        parameters.put('adabas',            currentUser.Adabas__c != null ? currentUser.Adabas__c : '0');
        
        return parameters;
    }
    
    private Endereco getAddress (Asset context){
        Endereco enderecoReturn = new Endereco();

        if(context.ProductType__c != 'Pré-Pago'){
            enderecoReturn.cep = context.vlocity_cmt__BillingAccountId__r.BillingPostalCode != null ? context.vlocity_cmt__BillingAccountId__r.BillingPostalCode : '';
            enderecoReturn.numero = context.vlocity_cmt__BillingAccountId__r.BillingNumber__c != null ? context.vlocity_cmt__BillingAccountId__r.BillingNumber__c : '';
            enderecoReturn.complemento = context.vlocity_cmt__BillingAccountId__r.FullComplement__c != null ? context.vlocity_cmt__BillingAccountId__r.FullComplement__c : '';
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
            } else{
                List<Account> lstBillingAddress = [SELECT BillingAddress, BillingStreet, BillingPostalCode, BillingNumber__c, ShippingAddress, ShippingStreet, ShippingPostalCode, ShippingNumber__c, RecordTypeId, BillingAccountType__c, FullComplement__c  FROM Account WHERE ParentId = :context.AccountId AND RecordType.DeveloperName = 'Billing']; 
                if(lstBillingAddress == null){
                    enderecoReturn.cep ='';
                    enderecoReturn.numero = '';
                    enderecoReturn.complemento = '';
                } else {
                    Boolean haveBillingAddress = false;
                
                    for(Account iBillingAddress : lstBillingAddress){
                        if(iBillingAddress.BillingAddress != null){
                            haveBillingAddress = true;
                            enderecoReturn.cep = iBillingAddress.BillingPostalCode != null ? iBillingAddress.BillingPostalCode : '';
                            enderecoReturn.numero = iBillingAddress.BillingNumber__c != null ? iBillingAddress.BillingNumber__c : '';
                            enderecoReturn.complemento = iBillingAddress.FullComplement__c != null ? iBillingAddress.FullComplement__c : '';
                          break;
                        }
                    }
                    
                    if(!haveBillingAddress){
                        enderecoReturn.cep ='';
                        enderecoReturn.numero = '';
                        enderecoReturn.complemento = '';                    
                    }
                }
            }
        } 
        
        return enderecoReturn;
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
    }
    protected abstract Asset query(Id recordId);
}