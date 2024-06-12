public with sharing class GeneralSettingDAO {
    public static GeneralSetting__c getGeneralSettingbyName(String name, String recordTypeName) {
        return [
            SELECT    
                Id, 
                Name,
                OperatorSegment__c 
            FROM 
                GeneralSetting__c
            WHERE   
                Name = :name
            AND RecordType.DeveloperName = :recordTypeName    
        ];
    }
}