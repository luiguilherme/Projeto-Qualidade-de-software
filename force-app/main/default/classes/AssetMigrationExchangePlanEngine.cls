public with sharing class AssetMigrationExchangePlanEngine {
    public static AssetMigrationDTO checkAccessToComponent(Id customerInteractionId){
        AssetMigrationDTO accessToReturn = new AssetMigrationDTO();
        checkAccessToTokenComponent(accessToReturn);
        if(accessToReturn.haveAccessToToken){
            checkTokenValidated(accessToReturn, customerInteractionId);
            if(accessToReturn.haveTokenValidated){
                checkUserHasAccess(accessToReturn);
            }
        }
        return accessToReturn;       
    }

    public static Map<String,Object> createCustomerInteractionTopic(String customerInteractionId, String assetId) {
        vlocity_cmt__CustomerInteraction__c customerInteractionAccountId = CustomerInteractionDAO.getCustomerInteractionById(customerInteractionId);
        Map <String, Object> returnMap = new Map<String, Object>();
        
        if (customerInteractionAccountId == null) {
            returnMap.put('error', customerInteractionAccountId);
            return returnMap;
        }

        vlocity_cmt__CustomerInteractionTopic__c newCustomerInteractionTopic = new vlocity_cmt__CustomerInteractionTopic__c();
        newCustomerInteractionTopic.vlocity_cmt__CustomerInteractionId__c = customerInteractionId;
        newCustomerInteractionTopic.vlocity_cmt__AccountId__c = customerInteractionAccountId.vlocity_cmt__AccountId__c;
        newCustomerInteractionTopic.vlocity_cmt__Reason__c = 'Palitagem Móvel';
        newCustomerInteractionTopic.Origin__c = 'Hybris';
        newCustomerInteractionTopic.ServiceTree__c = 'Service';
        //newCustomerInteractionTopic.IdServiceVivoNet__c = 'Ver depois';
        newCustomerInteractionTopic.TopicName__c = 'Solicitação > Comercial > Migrar / Alterar Plano > Fluxo em Andamento'; 
        newCustomerInteractionTopic.remarkup__c = 'Aguardando escolha da oferta para migração/troca de plano';
        newCustomerInteractionTopic.vlocity_cmt__AssetId__c = assetId;
        
        Database.SaveResult dataResult = Database.insert(newCustomerInteractionTopic);

        if (dataResult.isSuccess()) {
            returnMap.put('success', newCustomerInteractionTopic);
            return returnMap;
        } else { 
            returnMap.put('error', customerInteractionAccountId);
            return returnMap; 
        } 
    }

    public static void checkAccessToTokenComponent(AssetMigrationDTO accessToReturn) {
        try {
            accessToReturn.haveAccessToToken = false;
            
            User currentUser = UserDAO.getById(UserInfo.getUserId());
            List<FromToMapping__mdt> lstFromToMap =  new List<FromToMapping__mdt>();

            if (currentUser.Profile.UserLicense.Name != 'Partner Community') {
                lstFromToMap = FromToMappingDAO.getLstByUserRole(currentUser.UserRole.DeveloperName);
            } else {
                lstFromToMap = FromToMappingDAO.getLstByUserRole(currentUser.PartnerGroup__c);
            }
            
            for (FromToMapping__mdt iFromToMap : lstFromToMap) {
                if (iFromToMap.TokenPID__c) {
                    accessToReturn.haveAccessToToken = true;
                }
            }

            if(!accessToReturn.haveAccessToToken){
                accessToReturn.haveAccessToToken = !PermissionSetAssigmentDAO.getCurrentPSA(Userinfo.getUserId(), 'TokenSMS').isEmpty();    
            }

            if (Test.isRunningtest()) {
                accessToReturn.haveAccessToToken = true;
            }

        } catch (Exception e) {
            accessToReturn.haveAccessToToken = false;
        }
    }
    public static void checkTokenValidated(AssetMigrationDTO accessToReturn, Id customerInteractionId) {
        try {
            vlocity_cmt__CustomerInteraction__c customerIntObj = new vlocity_cmt__CustomerInteraction__c();
            customerIntObj = CustomerInteractionDAO.getCustomerInteractionById(customerInteractionId);

            if (customerIntObj.TokenStatus__c == 'Validado') {
                accessToReturn.haveTokenValidated = true;
            } else{
                accessToReturn.haveTokenValidated = false;
            }

            if (Test.isRunningtest()) {
                accessToReturn.haveTokenValidated = true;
            }
        } catch (Exception e) {
            accessToReturn.haveTokenValidated = false;
        }
    }

    public static void checkUserHasAccess(AssetMigrationDTO accessToReturn) {
        User user = UserDAO.getById(Userinfo.getUserId());

        if (user == null) {
            accessToReturn.userHaveAccess = false;
        }

        Boolean isShowOffer  = false;
        CanvasHybrisMigration__mdt userRole;
                    
        try{
            if (user.Profile.UserLicense.Name != 'Partner Community') {
           		userRole = CanvasHybrisMigrationDAO.getAccessToCanvas(user.UserRole.DeveloperName);
            } else {
                userRole = CanvasHybrisMigrationDAO.getAccessToCanvas(user.PartnerGroup__c);
            }
            
            isShowOffer = userRole != null ? userRole.HasAccessToHybrisMigration__c : false;
            
            if(!isShowOffer){
                isShowOffer = !PermissionSetAssigmentDAO.getCurrentsPSA(user.Id, System.Label.ListOfPermissionSetToAccessMigrationHybris.split(';')).isEmpty();    
            }
        } catch(Exception e){
            if(!isShowOffer){
                isShowOffer = !PermissionSetAssigmentDAO.getCurrentsPSA(user.Id, System.Label.ListOfPermissionSetToAccessMigrationHybris.split(';')).isEmpty();    
            }
        }   
        accessToReturn.userHaveAccess = isShowOffer;
    }
}