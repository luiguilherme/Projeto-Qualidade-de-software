public with sharing class ServiceHistoryDAO {
    public static List<ServiceHistory__c> getByAccountId(Id accountId){
        return [
            SELECT    
                Id 
            FROM 
                ServiceHistory__c
            WHERE
            	Account__c =: accountId
        ];
    }
}