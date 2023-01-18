public with sharing class ChangeOwnerHDEService {
    
    public static List<User> getUserByRole(Id caseId) {
        return changeOwnerHDEEngine.getUserByRole(caseId);
    }

}