public with sharing class GroupMemberEngine {

    public static Set<String> getEnabledGroupsDevName(Id userRoleId) {
        Set<Id> userIdSet = new Set<Id>{userRoleId};
        Set<String> groupDeveloperNameSet = new Set<String>();
        groupDeveloperNameSet.addAll(getParentGroupDevNameSet(userIdSet));
        groupDeveloperNameSet.addAll(getChildsAndMyGroupDevNameSet(userIdSet, userRoleId));
        return groupDeveloperNameSet;
    }

    private static Set<String> getParentGroupDevNameSet(Set<Id> userIdSet) {
        Set<String> groupMemberToReturnList = new Set<String>();
        try {
            List<UserRole> userRoleList = UserRoleDAO.getUserRoleList(); 
            Set<ID> idParentUserRoleSet = getAllParentRoleId(userIdSet, userRoleList);
            List<UserRole> userRoleParentsList = obtainUserRoleList(idParentUserRoleSet, userRoleList);
            List<Group> groupParentList = GroupDAO.getGroupList(userRoleParentsList);
            List<GroupMember> groupMemberParentList = GroupMemberDAO.getGroupMemberList(groupParentList);
            groupMemberToReturnList = getAllParentsGroupMember(groupMemberParentList, groupParentList);
            return groupMemberToReturnList;
        } catch (Exception e) {
            return groupMemberToReturnList;
        }
    }

    private static Set<String> getChildsAndMyGroupDevNameSet(Set<Id> userIdSet, Id userRoleId) {
        Set<String> groupMemberToReturnList = new Set<String>();
        try {
            List<UserRole> userRoleWithoutParentList = UserRoleDAO.getUserRoleWithoutParentList();
            Set<ID> idUserRoleChildSet = getAllSubRoleIds(userIdSet, userRoleWithoutParentList);
            idUserRoleChildSet.add(userRoleId);
            List<UserRole> userRoleChildList = obtainUserRoleList(idUserRoleChildSet, userRoleWithoutParentList);
            List<Group> groupChildList = GroupDAO.getGroupList(userRoleChildList);
            List<GroupMember> groupMemberChildList = GroupMemberDAO.getGroupMemberList(groupChildList);
            groupMemberToReturnList = getMyAndChildGroupMember(groupMemberChildList, groupChildList, userRoleId);
            return groupMemberToReturnList;
        } catch (Exception e) {
            return groupMemberToReturnList;
        }
    }

    private static Set<ID> getAllSubRoleIds(Set<ID> roleIds, List<UserRole> userRoleWithoutParentList) {
        Set<ID> currentRoleIds = new Set<ID>();
        for(UserRole userRole : userRoleWithoutParentList) {
            if (roleIds.contains(userRole.ParentRoleId)) {
                currentRoleIds.add(userRole.Id);
            }
        }
    
        if(currentRoleIds.size() > 0) {
            currentRoleIds.addAll(getAllSubRoleIds(currentRoleIds, userRoleWithoutParentList));
        }
    
        return currentRoleIds;
    }

    private static Set<ID> getAllParentRoleId(Set<ID> roleIds, List<UserRole> userRoleList ) {
        Set<ID> currentRoleIds = new Set<ID>();
        for(UserRole ur :userRoleList) {
            if (roleIds.contains(ur.Id)) {
                currentRoleIds.add(ur.ParentRoleId);    
            }                
        }

        if(currentRoleIds.size() > 0) {
            currentRoleIds.addAll(getAllParentRoleId(currentRoleIds, userRoleList));
        }
    
        return currentRoleIds;
    }

    private static Set<String> getAllParentsGroupMember(List<GroupMember> groupMemberList, 
                                                             List<Group> groupList) {
        Set<String> groupMemberWithRoles = new Set<String>();
        for (GroupMember groupMemberItem : groupMemberList) {
            for (Group groupItem : groupList) {
                if (groupMemberItem.UserOrGroupId == groupItem.Id 
                        && (groupItem.Type == 'RoleAndSubordinates' 
                                || groupItem.Type == 'RoleAndSubordinatesInternal')) {
                    groupMemberWithRoles.add(groupMemberItem.Group.DeveloperName);
                }
            } 
        }

        return groupMemberWithRoles;
    }

    private static Set<String> getMyAndChildGroupMember(List<GroupMember> groupMemberList, 
                                                            List<Group> groupList, Id userRoleId) {
        Set<String> groupMemberWithRoles = new Set<String>();

        for (GroupMember groupMemberItem : groupMemberList) {
            for (Group groupItem : groupList) {
                if (groupMemberItem.UserOrGroupId == groupItem.Id 
                        || (groupItem.RelatedId == userRoleId)) {
                    groupMemberWithRoles.add(groupMemberItem.Group.DeveloperName);
                }
            } 
        }
        return groupMemberWithRoles;
    }

    private static List<UserRole> obtainUserRoleList(Set<Id> userRoleIdSet, List<UserRole> userRoleList) {
        List<UserRole> userRoleToReturnList = new List<UserRole>();
        for (UserRole userRoleItem : userRoleList) {
            for (Id idItem : userRoleIdSet) {
                if (userRoleItem.Id == idItem) {
                    userRoleToReturnList.add(userRoleItem);
                }
            }
        }

        return userRoleToReturnList;
    }
}