public without sharing class ChangeOwnerHDEService {
    
    public static List<User> getUserByRole(Id caseId) {
        return changeOwnerHDEEngine.getUserByRole(caseId);
    }

    public static Boolean hasAccess() {
        return changeOwnerHDEEngine.hasAccess();
    }

    public static Boolean updateOwnerCase(Id caseId, Id ownerId) {
        return changeOwnerHDEEngine.updateOwnerCase(caseId, ownerId);
    }
}