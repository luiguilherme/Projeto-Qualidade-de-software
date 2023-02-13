public with sharing class PermissionSetDAO {

    public static List<PermissionSetAssignment> getByUserIdAndPermissionSetName(Id userId, List<String> permissionSetName) {
        List<PermissionSetAssignment> lst = [
            SELECT 
                AssigneeId,
                PermissionSet.Name
            FROM 
                PermissionSetAssignment 
            WHERE 
                PermissionSet.Name IN :permissionSetName 
                AND AssigneeId = :userId
        ];
        return lst.isEmpty() ? new List<PermissionSetAssignment>() : lst;
    }
}