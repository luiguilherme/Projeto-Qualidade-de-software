public with sharing class PermissionSetAssigmentDAO {
    public static List<PermissionSetAssignment> getCurrentPSA(Id userID, String permissionName) {
        return [SELECT 
                    Id, 
                    PermissionSetId 
                FROM 
                    PermissionSetAssignment 
                WHERE 
                    AssigneeId =: userID AND 
                    PermissionSet.Name =: permissionName
                ];
    }
    public static List<PermissionSetAssignment> getCurrentsPSA(Id userID, List<String> permissionName) {
        return [SELECT 
                    Id, 
                    PermissionSetId 
                FROM 
                    PermissionSetAssignment 
                WHERE 
                    AssigneeId =: userID AND 
                    PermissionSet.Name IN: permissionName
                ];
    }
}