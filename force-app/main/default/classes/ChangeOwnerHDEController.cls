public with sharing class ChangeOwnerHDEController {
   
    @AuraEnabled(cacheable=true)
    public static List<User> getUserByRole(Id caseId){
        return ChangeOwnerHDEService.getUserByRole(caseId);
    }
}