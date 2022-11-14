/*
* @description Controla a busca e criação do objeto User 
*/
public with sharing class UserDAO {
    
    public static User getById(Id userId){
        List<User> lst = getById(new Set<Id>{userId});
        return lst.isEmpty() ? null : lst[0];
    }

    public static List<User> getById(Set<Id> setUserId){
        return[
            SELECT 
                Id,
                Name,
                UserRoleId,
                UserRole.Name, 
                UserRole.DeveloperName, 
                PartnerGroup__c, 
                IsPortalEnabled,
                Profile.Name,
                Alias,
                Profile.UserLicense.name, 
                Login__c,
                Email                
            FROM 
                User 
            WHERE 
                Id IN :setUserId
        ];
    }
    public static List<User> getUserInfo() {
        return getUserinfo(new Set<String>{UserInfo.getUserId()}); 
    }

    public static List<User> getUserInfo(String param) {
        return getUserinfo(new Set<String>{param}); 
    }

    public static List<User> getUserInfo(Set<String> params) {
        return [SELECT 
                Id, 
                name, 
                UseRrole.name,
                Profile.UserLicense.name, 
                UserRole.DeveloperName, 
                ProfileId, 
                PartnerGroup__c,
                Login__c
                //IsPortalEnabled
            FROM 
                User 
            WHERE Id =:params]; 
    }
}