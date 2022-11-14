public with sharing class FromToMappingDAO {
    public static list<FromToMapping__mdt> getFromOriginUsedIn(String param) {
        return getFromOriginUsedIn(new Set<String>{param});
    }
    
    public static list<FromToMapping__mdt> getFromOriginUsedIn(Set<String> params) {
        return[
            SELECT
                Id,
                OriginApiName__c,
                DestinyName__c,
                UsedIn__c
            FROM 
                FromToMapping__mdt 
            WHERE
                UsedIn__c = :params 
        ];
    }
   
    public static List<FromToMapping__mdt> getServiceTreeIdentifier(String userRole) {
        return [
            SELECT
            	QualifiedApiName,
            	DestinyApiName__c,
            	DestinyName__c,
            	OriginApiName__c,
            	OriginName__c,
            	Object__c,
            	RecordType__c,
            	UsedIn__c,
            	ServiceTree__c,
                CanvasHybris__c
            FROM
            	FromToMapping__mdt
            WHERE
            	OriginApiName__c = :userRole
        ];
    }
    
    public static List<FromToMapping__mdt> getUserPermission(String userRole, List<String> groupType){

        return [SELECT id FROM FromToMapping__mdt WHERE DestinyApiName__c in: groupType AND OriginApiName__c =: userRole];
    }

    public static List<FromToMapping__mdt> getGroupMap(String objectType, String offerLevel){

        return [SELECT id, OriginApiName__c, DestinyApiName__c  FROM FromToMapping__mdt WHERE Object__c =: objectType AND RecordType__c =: offerLevel];
    }
}