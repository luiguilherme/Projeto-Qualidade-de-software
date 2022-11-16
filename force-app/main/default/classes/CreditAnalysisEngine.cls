public without sharing class CreditAnalysisEngine {

    public static Map<String,Object> executeCreditAnalysis(Account accountContext){
        return executeCreditAnalysis(accountContext, 'CreditService' );
    }

    public static Map<String,Object> executeCreditAnalysis(Account accountContext, String UsedIn){
        Map<String, Object> mapResponse = new Map<String,Object>();
        String salesChannel, salesChannelName;
        User user;
        Map<String,FromToMapping__mdt> mapFromTo;

        GeneralParam__c param = GeneralParam__c.getInstance(); 
       
        //Validar a regra de refazer consulta de crédito
        checkValidCreditAnalysis(mapResponse, accountContext, param.CreditConsultationExpiration__c);
       
        if(mapResponse.containsKey('success')){
            return mapResponse;
        }


        //Validar campos obrigatórios
        RequiredFieldsValidator.validateFields(mapResponse, accountContext, UsedIn);
        
        if(!mapResponse.containsKey('success')){
            return mapResponse;
        }
    
        user = UserDAO.getUserInfo()[0]; 
        
        mapFromTo = new Map<String,FromToMapping__mdt>();

        CollectionUtil.loadMap(mapFromTo, 'OriginApiName__c',
                    FromToMappingDAO.getFromOriginUsedIn('CreditService'));

        //Recuperar o papel do usuario
        if(user.Profile.UserLicense.Name != 'Partner Community'){
            FromToMapping__mdt mapping = mapFromTo.get(User.UserRole.DeveloperName);
            salesChannelname = 'SF-'+User.UserRole.DeveloperName;
            if(mapping != null){
                salesChannel = mapping.DestinyName__c;
            }else{
                salesChannel = user.UserRole.Name;
            }  
        }else{
            fromToMapping__mdt mapping = mapFromTo.get(User.PartnerGroup__c);
            salesChannelname = 'SF-'+User.PartnerGroup__c;
            if(mapping != null){
                salesChannel = mapping.DestinyName__c;
            }else{
                salesChannel = User.PartnerGroup__c;
            }
        }
        
        CreditAnalysisCallout.execute(mapResponse, accountContext, salesChannel, salesChannelName, user.Login__c);
        Account accToUpdate = new Account(Id = accountContext.Id);
        
        if(!mapResponse.containsKey('error') && mapResponse.get('success') != null){
            
            CreditAnalysisResponse response = (CreditAnalysisResponse) mapResponse.get('success');
            accToUpdate.vlocity_cmt__CreditScore__c = response.performAnalysisCreditResponse.customerCreditProfile.creditScore;
            accToUpdate.CreditScoreResultDescription__c = response.performAnalysisCreditResponse.result.description;
            accToUpdate.CreditScoreDate__c = System.now();
        }else{
            accToUpdate.vlocity_cmt__CreditScore__c = null;
            accToUpdate.CreditScoreResultDescription__c = null;
            accToUpdate.CreditScoreDate__c = null;
        }
        update accToUpdate;
        return mapResponse;
    }

    static void checkValidCreditAnalysis(map<String, Object> mapResponse, Account accountContext, String expiratonTime){
        if(accountContext.CreditScoreDate__c != null 
        && accountContext.CreditScoreDate__c.addHours(Integer.valueOf(expiratonTime)) > System.now()){
            mapResponse.put('success', 'A análise de crédito ainda está válida');
        }
    }
}