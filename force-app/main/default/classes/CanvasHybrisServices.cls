public abstract class CanvasHybrisServices implements CanvasServiceInterface {
    
    private static final String TIPO_OFERTA = 'migration';
    
    public String getConnectedAppName() {
        return 'HybrisCanvas';
    }

    public Map<String,Object> getParameters(Id id){
        Account context = query(id);
        
        return canvasResultParameters(context);
    }
    
    private Map<String,Object> canvasResultParameters(Account context){

        Map<String,Object> parameters = new Map<String,Object>();
        User currentUser = UserDAO.getById(System.UserInfo.getUserId());
        String userRole = currentUser.Profile.UserLicense.Name != 'Partner Community' ? currentUser.UserRole.DeveloperName : currentUser.PartnerGroup__c;
        CanvasHybrisMigration__mdt hybrisMetadata = CanvasHybrisMigrationDAO.getByUserRole(userRole);
        
        parameters.put('documento',         context.DocumentNumber__c != null ? context.DocumentNumber__c : '');
        parameters.put('nomeConta',         context.Name != null ? context.Name : '');
        parameters.put('endereco',          getAddress(context));
        parameters.put('nomeMae',           context.vlocity_cmt__PrimaryContactId__r.MotherName__c  != null ? context.vlocity_cmt__PrimaryContactId__r.MotherName__c : '');
        parameters.put('email',             context.vlocity_cmt__PrimaryContactId__r.Email   != null ? context.vlocity_cmt__PrimaryContactId__r.Email : '');
        parameters.put('telefoneContato',   context.vlocity_cmt__PrimaryContactId__r.MobilePhone   != null ? context.vlocity_cmt__PrimaryContactId__r.MobilePhone : '');
        parameters.put('dataNascimento',    formatBirthDate2(context));
        parameters.put('tipoOferta',        TIPO_OFERTA);
        parameters.put('nomeOperador',      currentUser.Name);
        parameters.put('emailOperador',     currentUser.Email);
        parameters.put('loginRede',         currentUser.Login__c);
        parameters.put('canalOperador',     hybrisMetadata.UserChannel__c != null ? hybrisMetadata.UserChannel__c : '');
        parameters.put('segmento',          getUserSegments(hybrisMetadata.UserSegment__c));
        parameters.put('posToPre',          hybrisMetadata.PosToPre__c);
        parameters.put('controleToPre',     hybrisMetadata.ControleToPre__c);
        parameters.put('adabas',            currentUser.Adabas__c != null ? currentUser.Adabas__c : '');
        
        return parameters;
    }
    
    private Endereco getAddress (Account context){
        Endereco enderecoReturn = new Endereco();
        enderecoReturn.cep = context.ShippingPostalCode != null ? context.ShippingPostalCode : '';
        enderecoReturn.numero = context.ShippingNumber__c != null ? context.ShippingNumber__c : '';
        enderecoReturn.complemento = context.FullComplement__c != null ? context.FullComplement__c : '';
        return enderecoReturn;
    }

    // private String formatBirthDate (Account context) {
    //     if (context.vlocity_cmt__PrimaryContactId__r.Birthdate != null) {
    //         String dateString = context.vlocity_cmt__PrimaryContactId__r.Birthdate.day() + '/' + context.vlocity_cmt__PrimaryContactId__r.Birthdate.month() + '/' + context.vlocity_cmt__PrimaryContactId__r.Birthdate.year();
    //         return dateString;
    //     } else {
    //         return '';
    //     }
    // }
		//Teste Data AAAA/MM/DD
    private String formatBirthDate2 (Account context) {
        if (context.vlocity_cmt__PrimaryContactId__r.Birthdate != null) {
            String dateString = context.vlocity_cmt__PrimaryContactId__r.Birthdate.year() + '-' + context.vlocity_cmt__PrimaryContactId__r.Birthdate.month() + '-' + context.vlocity_cmt__PrimaryContactId__r.Birthdate.day();
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
    
    protected abstract Account query(Id recordId);
}