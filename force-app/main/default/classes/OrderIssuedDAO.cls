public with sharing class OrderIssuedDAO {
    public static OrderIssued__c getById (Id orderIssuedId){
        List<OrderIssued__c> ltOrderIssued = getById(new Set<Id>{orderIssuedId});
        return ltOrderIssued.isEmpty() ? null : ltOrderIssued[0];
    }

    public static List<OrderIssued__c> getById (Set<Id> setOrderIssuedId) {
        return [
            SELECT 
                Id, 
                Name, 
                AccountId__c, 
                HybrisOrder__c, 
                AmdocsOrder__c, 
                Status__c 
            FROM 
                OrderIssued__c 
            WHERE
                Id IN :setOrderIssuedId
        ];
    }
}