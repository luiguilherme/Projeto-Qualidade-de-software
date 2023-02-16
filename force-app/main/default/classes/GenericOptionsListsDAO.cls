public with sharing class GenericOptionsListsDAO {
    public static List<GenericOptionsLists__c> getByAPIName(String apiName) {
        return (
            [
                SELECT 
                    Id, 
                    Name, 
                    Code__c, 
                    Description__c, 
                    Description2__c, 
                    APIName__c, 
                    APIDateTime__c,
                    UsedIn__c, 
                    Active__c 
                FROM 
                    GenericOptionsLists__c
                WHERE 
                    APIName__c = :apiName 
            ]
        );
    }

    public static List<GenericOptionsLists__c> getByAPINameUsedIn(String apiName, String usedIn) {
        return (
            [
                SELECT 
                    Id, 
                    Name, 
                    Code__c, 
                    Description__c, 
                    Description2__c, 
                    APIName__c, 
                    APIDateTime__c,
                    UsedIn__c, 
                    Active__c 
                FROM 
                    GenericOptionsLists__c
                WHERE 
                    APIName__c = :apiName AND 
                    UsedIn__c = :usedIn
            ]
        );
    }

    public static List<GenericOptionsLists__c> getByAPINameUsedInActive(String apiName, String usedIn) {
        return (getByAPINameUsedInActive(new Set<String>{apiName}, new Set<String>{usedIn}));
    }

    public static List<GenericOptionsLists__c> getByAPINameUsedInActive(Set<String> apiName, Set<String> usedIn) {
            return (
            [
                SELECT 
                    Id, 
                    Name, 
                    Code__c, 
                    Description__c, 
                    Description2__c, 
                    APIName__c, 
                    APIDateTime__c,
                    UsedIn__c, 
                    Active__c 
                FROM 
                    GenericOptionsLists__c
                WHERE 
                    APIName__c IN :apiName AND 
                    UsedIn__c IN :usedIn AND
                    Active__c = true
            ]
        );
    }

    public static List<GenericOptionsLists__c> getByAPINameUsedInCode(String apiName, String usedIn, String code) {
        return (
            [
                SELECT 
                    Id, 
                    Name, 
                    Code__c, 
                    Description__c, 
                    Description2__c, 
                    APIName__c, 
                    APIDateTime__c,
                    UsedIn__c, 
                    Active__c 
                FROM 
                    GenericOptionsLists__c
                WHERE 
                    APIName__c = :apiName AND 
                    UsedIn__c = :usedIn AND
                    Code__c = :code
            ]
        );
    }

    public static List<GenericOptionsLists__c> getByAPINameUsedInName(String apiName, String usedIn, String name) {
        return (
            [
                SELECT 
                    Id, 
                    Name, 
                    Code__c, 
                    Description__c, 
                    Description2__c, 
                    APIName__c, 
                    APIDateTime__c,
                    UsedIn__c, 
                    Active__c 
                FROM 
                    GenericOptionsLists__c
                WHERE 
                    APIName__c = :apiName AND 
                    UsedIn__c = :usedIn AND
                    Name = :name
            ]
        );
    }
    
    public static List<GenericOptionsLists__c> getByAPINameUsedInDescription(String apiName, String usedIn, String description) {
        return (
            [
                SELECT 
                    Id, 
                    Name, 
                    Code__c, 
                    Description__c, 
                    Description2__c, 
                    APIName__c, 
                    APIDateTime__c,
                    UsedIn__c, 
                    Active__c 
                FROM 
                    GenericOptionsLists__c
                WHERE 
                    APIName__c = :apiName AND 
                    UsedIn__c = :usedIn AND
                    Description__c = :description
            ]
        );
    }
    
    public static List<GenericOptionsLists__c> getByAPINameUsedInDescription2(String apiName, String usedIn, String description2) {
        return (
            [
                SELECT 
                    Id, 
                    Name, 
                    Code__c, 
                    Description__c, 
                    Description2__c, 
                    APIName__c, 
                    APIDateTime__c,
                    UsedIn__c, 
                    Active__c 
                FROM 
                    GenericOptionsLists__c
                WHERE 
                    APIName__c = :apiName AND 
                    UsedIn__c = :usedIn AND
                    Description2__c = :description2
            ]
        );
    }
}
