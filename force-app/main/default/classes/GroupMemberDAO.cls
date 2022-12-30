public with sharing class GroupMemberDAO {
    public static List<GroupMember> getGroupMemberList(List<Group> groupList){
        return
            [
                SELECT 
                    Id, 
                    GroupId, 
                    Group.DeveloperName, 
                    UserOrGroupId 
                FROM 
                    GroupMember 
                WHERE 
                    UserOrGroupId IN :groupList
            ];
    }
}