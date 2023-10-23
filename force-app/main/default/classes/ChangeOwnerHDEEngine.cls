public without sharing class ChangeOwnerHDEEngine {
    
    public static List<User> getUserByRole(Id caseId){

        Case caseFields = CaseDAO.getCasebyId(caseId);
        Map<String, FromToMapping__mdt> mappingRoles = FromToMapping__mdt.getAll();
        Set<String> caseRoles = new Set<String>();

        for(FromToMapping__mdt role : mappingRoles.values()){
            if((role.OperatorSegment__c == caseFields.Segment__c) && role.OriginApiName__c != null) {
                caseRoles.add(role.OriginApiName__c);
            }
        }

        Boolean userIsPartner = userIsPartner();
        List<User> allowedUsers = new List<User>();
        
        if(!userIsPartner){
            allowedUsers = UserDAO.getUserByRole(caseRoles);
        } else {
            allowedUsers = UserDAO.getUsersCommunityByRole(caseRoles);
        }

        return allowedUsers;

    }

    public static Boolean hasAccess() {
        Boolean userIsPartner = userIsPartner();
        if(!userIsPartner){
            return true;
        } else {
            Boolean hasGestaoPermission = false;
            Boolean hasAtLeastAHDEPermission = false;
            String permissionsWithoutAccess = System.Label.ChangeOwnerHDEPermissions;
            List<String> lstPermissionsWithoutAccess = permissionsWithoutAccess.split(',');
            List<PermissionSetAssignment> lstPermissionsAssigments = PermissionSetDAO.getAllPermissionSetByUserId(UserInfo.getUserId());
            Pattern regexPattern = Pattern.compile('\\bHDE.*Processos.*Escalonamento\\b'); //Padrão solicitado na hist PTI4367-7

            for(PermissionSetAssignment iPerm : lstPermissionsAssigments){
                if (hasGestaoPermission == false && (iPerm.PermissionSet.Name == 'HDETriageGuardianCommunity' || iPerm.PermissionSet.Name == 'HDEOperationsManagerCommunity')) {
                    hasGestaoPermission = true;
                } else if (lstPermissionsWithoutAccess.contains(iPerm.PermissionSet.Name)){
                    return false;
                }

                Matcher m = regexPattern.matcher(iPerm.PermissionSet.Label);
                if (m.find()) {
                    hasAtLeastAHDEPermission = true;
                }
            }

            return hasGestaoPermission && hasAtLeastAHDEPermission;
        }
    }

    public static Boolean updateOwnerCase(Id caseId, Id ownerId) {
        Case caseToUpdateOwner = new Case();
        caseToUpdateOwner.id = caseId;
        caseToUpdateOwner.OwnerId = ownerId;
        Database.SaveResult saveResult = Database.update(caseToUpdateOwner);

        if (saveResult.isSuccess()) {
            return true;
        } else {
            return false;
        } 
    }

    public static Boolean userIsPartner() {
        User userObj = UserDAO.getUserInfo()[0];
        List<User> allowedUsers = new List<User>();
        if(userObj.Profile.UserLicense.name != 'Partner Community'){
            return false;
        } else {
            return true;
        }
    }
}