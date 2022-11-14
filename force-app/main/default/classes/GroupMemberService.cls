/*
    *
    *   Description: Classe de referência para consulta de Grupos
    *
    *   Author: Erick Yamamoto
    *   Date:   16/09/2021
    *
*/
public with sharing class GroupMemberService {

    public static Set<String> getEnabledGroupsDevName(Id userRoleId) {
        return GroupMemberEngine.getEnabledGroupsDevName(userRoleId);
    }
}