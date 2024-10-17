public without sharing class UserDAO {
    
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
                Email, 
                StoreCode__c, 
                StoreName__c, 
                StoreSegment__c, 
                StoreConsultationDate__c,
                Adabas__c
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
                Login__c, 
                IsPortalEnabled 
            FROM 
                User 
            WHERE Id =:params]; 
    }

    public static List<User> getUserByRole(Set<String> roles){
        return [SELECT
                Id, 
                Name,
                PartnerGroup__c,
                UserRole.DeveloperName,
                Profile.UserLicense.name
            FROM 
                User 
            WHERE 
                IsActive = true
            AND
                (UserRole.DeveloperName IN :roles
            OR 
                PartnerGroup__c IN :roles)
            ORDER BY 
                Name
        ];
    }

    public static List<User> getUsersCommunityByRole(Set<String> roles){
        return [SELECT
                Id, 
                Name 
            FROM 
                User 
            WHERE 
                IsActive = true
            AND
                PartnerGroup__c IN :roles
            ORDER BY 
                Name
        ];
    }

    public static List<User> getByLogin(Set<String> logins){
        return [
            SELECT 
                Id, 
                Name, 
                UserRoleId, 
                UserRole.Name, 
                UserRole.DeveloperName, 
                ProfileId, 
                Profile.Name, 
                Profile.UserLicense.Name, 
                PartnerGroup__c, 
                IsPortalEnabled, 
                Alias, 
                Login__c, 
                Email, 
                StoreCode__c, 
                StoreName__c, 
                StoreSegment__c, 
                StoreConsultationDate__c, 
                Adabas__c, 
                ManagerId, 
                SupervisorId__c 
            FROM 
                User 
            WHERE 
                Login__c IN :logins
        ];
    }
}
