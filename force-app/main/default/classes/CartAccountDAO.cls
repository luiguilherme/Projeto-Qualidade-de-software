public with sharing class CartAccountDAO {

    public static CartAccount__c getCartByIdUserRecordTypeCreatedToday(Id accountId, Id userId, String recordType){
        List<CartAccount__c> lst = getListCartByIdUserRecordTypeCreatedToday(new Set<Id>{accountId}, userId, recordType);
        return lst.isEmpty() ? null : lst[0];
    }

    public static List<CartAccount__c> getListCartByIdUserRecordTypeCreatedToday(Set<Id> setAccountId, Id userId, String recordType){
        return[
            SELECT  Id, 
                    AccountId__c, 
                    OwnerId, 
                    CreatedDate, 
                    TotalPrice__c, 
                    Discount__c
            FROM 
                CartAccount__c 
            WHERE 
                AccountId__c IN: setAccountId 
                AND CreatedDate = TODAY 
                AND OwnerId =: userId
                AND RecordType.DeveloperName =: recordType 
        ];
    }

    public static Integer getCartOnTheDay(Id accountId, String recortType){
        return[
            SELECT 
                count()
            FROM
                CartAccount__c
            WHERE
                CreatedDate = TODAY
                AND AccountId__c =: accountId
                AND RecordType.DeveloperName =: recortType
        ];
    }
}