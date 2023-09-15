public without sharing class ChangeOwnerHDEController {
   
    @AuraEnabled(cacheable=true)
    public static List<User> getUserByRole(Id caseId){
        return ChangeOwnerHDEService.getUserByRole(caseId);
    }

    @AuraEnabled(cacheable=true)
    public static Boolean hasAccess(){
        return ChangeOwnerHDEService.hasAccess();
    }

    @AuraEnabled
    public static Boolean updateOwnerCase(Id caseId, Id ownerId){
        return ChangeOwnerHDEService.updateOwnerCase(caseId, ownerId);
    }

}