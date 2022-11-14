public with sharing class GroupDAO {
    public static List<Group> getGroupList(List<UserRole> userRoleList){
        return
            [
                SELECT 
                    Id, 
                    DeveloperName, 
                    Type, 
                    RelatedId 
                FROM 
                    Group 
                WHERE 
                    RelatedId IN :userRoleList
            ];
    }

    public static List<Group> getQueueByName(String name){
        return
            [
                SELECT
                    id
                FROM
                    Group
                WHERE
                    Type = 'Queue'
                AND DeveloperNAME =: name
            ];

    }
}