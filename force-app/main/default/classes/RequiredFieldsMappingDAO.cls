public without sharing class RequiredFieldsMappingDAO {
    public static List<RequiredFieldsMapping__mdt> get(String objectName, String RecordtypeName, String usedIn){
        return [
            SELECT
                Id,
                ApiName__c,
                ErrorMessage__c,
                Name__c,
                Object__c,
                RecordType__c,
                UsedIn__c
            FROM
                RequiredFieldsMapping__mdt
            WHERE
                   Object__c =:objectName
            AND    RecordType__c=:RecordtypeName
            AND    UsedIn__c=:usedIn    
        ];
    }
}