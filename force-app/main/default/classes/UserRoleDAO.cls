public with sharing class UserRoleDAO {
    public static List<UserRole> getUserRoleList(){
        return
            [
                SELECT 
                    Id, 
                    ParentRoleId 
                FROM 
                    UserRole
            ];
    }

    public static List<UserRole> getUserRoleWithoutParentList(){
        return
            [
                SELECT 
                    Id, 
                    ParentRoleId 
                FROM 
                    UserRole 
                WHERE 
                    ParentRoleID != null
            ];
    }

    public static List<UserRole> getUserRoleByIdSet(Set<Id> userRoleIdSet){
        return
            [
                SELECT 
                    Id 
                FROM 
                    UserRole 
                WHERE 
                    Id IN: userRoleIdSet
            ];
    }

}