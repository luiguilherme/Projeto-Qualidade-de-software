public with sharing class CanvasHybrisMigrationDAO {

    public static List<CanvasHybrisMigration__mdt> getAll(String userRole){
        return[
            SELECT 
                Id,
                OriginApiName__c,
                UserLicense__c,
                UserSegment__c,
                HasAccessToHybrisMigration__c
            FROM 
                CanvasHybrisMigration__mdt
            WHERE
                OriginApiName__c = :userRole
        ];
    }
    public static CanvasHybrisMigration__mdt getAccessToCanvas(String userRole){ 

        CanvasHybrisMigration__mdt chmObject = [
            SELECT
                HasAccessToHybrisMigration__c
            FROM 
                CanvasHybrisMigration__mdt
            WHERE
                OriginApiName__c = :userRole
            LIMIT 1 
        ];

    return chmObject !=null ? chmObject : null;

    }    
}