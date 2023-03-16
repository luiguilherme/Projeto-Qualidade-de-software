public with sharing class AssetMigrationExchangePlanEngine {
    public static Boolean showOffer(Id userId){
        User user = UserDAO.getById(userId);

        if (user == null) {
            return false;
        }

        Boolean isShowOffer  = false;
        CanvasHybrisMigration__mdt userRole;

        if (user.Profile.UserLicense.Name != 'Partner Community') {
            userRole = CanvasHybrisMigrationDAO.getAccessToCanvas(user.UserRole.DeveloperName);
        } else {
            userRole = CanvasHybrisMigrationDAO.getAccessToCanvas(user.PartnerGroup__c);
        }
        
        isShowOffer = userRole == null ? false : userRole.HasAccessToHybrisMigration__c;

        if (!isShowOffer) {
            isShowOffer = !PermissionSetAssigmentDAO.getCurrentsPSA(user.Id, System.Label.ListOfPermissionSetToAccessMigrationHybris.split(';')).isEmpty();
        }

        return isShowOffer;
    }
}