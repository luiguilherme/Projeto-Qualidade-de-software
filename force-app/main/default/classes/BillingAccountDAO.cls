public with sharing class BillingAccountDAO {
   
    public static List<Account> getByAccountIdDeveloperName(Id accountId, String accountType){
        return[
            SELECT 
                Id, 
                ParentId,  
                FullAddress__c,
                ExternalId__c,
                LastModifiedDate, 
                TotalAmount__c, 
                OfferReferenceValue__c 
            FROM 
                Account 
            WHERE 
                Id IN (SELECT vlocity_cmt__BillingAccountId__c FROM Asset WHERE AccountId =: accountId)
            AND 
              BillingAccountType__c = :accountType
        ];
    }

    public static List<Account> getByAccountIdDeveloperNameLastmodifiedDate(Id accountId, String accountType, Datetime lastModifiedDate){
        return[
            SELECT 
                Id, 
                ParentId,  
                ExternalId__c,
                LastModifiedDate, 
                TotalAmount__c, 
                OfferReferenceValue__c 
            FROM 
                Account 
            WHERE 
                Id IN (SELECT vlocity_cmt__BillingAccountId__c FROM Asset WHERE AccountId =: accountId) 
            AND 
                BillingAccountType__c = :accountType
            AND 
                LastModifiedDate > : lastModifiedDate
        ];
    }
    public static Account getByName(String billingAccountName){
        List<Account> lst = getByName(new Set<String>{billingAccountName});
        return lst.isEmpty() ? null : lst[0];
    }

    public static List<Account> getByName(Set<String> setBillingAccountName){
        return[
            SELECT 
                Id,
                Name, 
                ParentId,  
                ExternalId__c,
                LastModifiedDate, 
                TotalAmount__c, 
                OfferReferenceValue__c 
            FROM 
                Account 
            WHERE 
              Name IN :setBillingAccountName
        ];
    }

    public static List<Account> getByNameOrExternalId(Set<String> setBillingAccountName){
        return[
            SELECT 
                Id,
                Name, 
                ParentId,  
                ExternalId__c,
                LastModifiedDate, 
                TotalAmount__c, 
                OfferReferenceValue__c 
            FROM 
                Account 
            WHERE 
              Name IN :setBillingAccountName
              OR
              ExternalId__c IN :setBillingAccountName
        ];
    }

    public static List<Account> getBillingAccountWithoutAsset(Set<Id> setAccountId){
        return[
            SELECT 
                Id, 
                Name, 
                ParentId 
            FROM 
                Account 
            WHERE 
                    Id NOT IN (SELECT vlocity_cmt__BillingAccountId__c FROM Asset WHERE  AccountId IN :setAccountId) 
                AND 
                    ParentId IN :setAccountId
        ];
    }
}