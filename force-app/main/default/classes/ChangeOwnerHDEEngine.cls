public with sharing class ChangeOwnerHDEEngine {
    
    public static List<User> getUserByRole(Id caseId){

        Case caseFields = CaseDAO.getCasebyId(caseId);
        Map<String, FromToMapping__mdt> mappingRoles = FromToMapping__mdt.getAll();
        Set<String> caseRoles = new Set<String>();

        for(FromToMapping__mdt role : mappingRoles.values()){
            if(role.OperatorSegment__c == caseFields.Segment__c){
                caseRoles.add(role.OriginApiName__c);
            }
        }

        List<User> allowedUsers = UserDAO.getUserByRole(caseRoles);

        return allowedUsers;

    }

}