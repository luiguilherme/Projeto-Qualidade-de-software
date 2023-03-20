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
}