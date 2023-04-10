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
        
        parameters.put('documento',         context.DocumentNumber__c);
        parameters.put('nomeConta',         context.Name);
        parameters.put('score',             context.vlocity_cmt__CreditScore__c);
        parameters.put('nomeMae',           context.vlocity_cmt__PrimaryContactId__r.MotherName__c);
        parameters.put('email',             context.vlocity_cmt__PrimaryContactId__r.Email);
        parameters.put('telefone',          context.vlocity_cmt__PrimaryContactId__r.MobilePhone); 
        parameters.put('dataNascimento',    context.vlocity_cmt__PrimaryContactId__r.Birthdate);
        parameters.put('cep',               filterZipCodeList(context)); 
        parameters.put('nomeConta',         context.Name);
        parameters.put('tipoOferta',    TIPO_OFERTA);
        parameters.put('nomeOperador',      currentUser.Name);
        parameters.put('emailOperador',     currentUser.Email);
        parameters.put('loginRede',         currentUser.Login__c);
        parameters.put('canalOperador',     getDestinyAPIName(currentUser));
        
        return parameters;
    }
    
    private List<String> filterZipCodeList(Account context){
        List<String> ltZipCode = new List<String>();
        
            ltZipCode.add(context.BillingPostalCode);
        

        return ltZipCode;
    }

    private String getDestinyAPIName (User currentUser){ 
        String userType = currentUser.Profile.UserLicense.Name != 'Partner Community' ? currentUser.UserRole.DeveloperName : currentUser.PartnerGroup__c;
        List<FromToMapping__mdt> ltRole = FromToMappingDAO.getServiceTreeIdentifier(userType);
        String destinyApiName = '';
        
        try {
            destinyApiName = ltRole[0].DestinyApiName__c;

        } catch (Exception e) {

        }

        return destinyApiName; 
    }

    protected abstract Account query(Id recordId);
}