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

    public static List<FromToMapping__mdt> getServiceTreeOperatorSegmentIdentifier(String userRole) {
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
                OperatorSegment__c
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
    
    
    public static List<FromToMapping__mdt> getByObject(String objectName){
        return[
            SELECT 
                Id, 
                RecordType__c, 
                DestinyName__c, 
                OriginName__c, 
                DestinyApiName__c 
            FROM 
                FromToMapping__mdt 
            WHERE 
                Object__c = :objectName
        ];
    } 

    public static List<FromToMapping__mdt> getAll(){
        return[
            SELECT 
                Id,
                OriginApiName__c,
                DestinyName__c,
                UsedIn__c
            FROM 
                FromToMapping__mdt 
        ];
    } 
    public static List<FromToMapping__mdt> getServiceTreeIdentifierBy(String userRole) {
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
            	OperatorSegment__c
            FROM
            	FromToMapping__mdt
            WHERE
            	OriginApiName__c = :userRole
        ];
    }

    public static List<FromToMapping__mdt> getLstByUserRole(String userRole) {
        return [
            SELECT
                TokenPID__c
            FROM
            	FromToMapping__mdt
            WHERE
            	OriginApiName__c = :userRole
        ];
    }

    public static List<FromToMapping__mdt> getLstByUsersRole(Set<String> lstUserRole) {
        List<FromToMapping__mdt> lstReturn = [
            SELECT
            	OperatorSegment__c,
                OriginApiName__c
            FROM
            	FromToMapping__mdt
            WHERE
            	OriginApiName__c in :lstUserRole
        ];

        return lstReturn.isEmpty() ? new List<FromToMapping__mdt>() : lstReturn;
    }

    public static FromToMapping__mdt getRecordByUsersRoleAndUsedIn(String userRole, String usedIn) {
        return [
            SELECT
            	OperatorSegment__c,
                OriginApiName__c
            FROM
            	FromToMapping__mdt
            WHERE
            	OriginApiName__c = :userRole
            AND UsedIn__c = :usedIn
            LIMIT 1
        ];
    }

    public static List<FromToMapping__mdt> getByObjectAndOriginNameAndUsedIn(String objectName, String originName, String usedIn) {
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
            	OperatorSegment__c
            FROM
            	FromToMapping__mdt
            WHERE
                Object__c = :objectName AND 
            	OriginName__c = :originName AND 
                UsedIn__c = :usedIn
        ];
    }

    public static List<FromToMapping__mdt> getByObjectNameAndUsedIn(Set<String> objectNames, String usedIn) {
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
            	OperatorSegment__c
            FROM
            	FromToMapping__mdt
            WHERE
                Object__c IN :objectNames AND 
                UsedIn__c = :usedIn
        ];
    }
}
