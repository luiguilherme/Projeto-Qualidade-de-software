public with sharing class AssetMigrationExchangePlanEngine {
    public static Boolean showOffer(Id userId){
        User user = UserDAO.getById(userId);

        if (user == null) {
            return false;
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
        
        return isShowOffer;       
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
}