public with sharing class AccountDAO {
    public static Account getByIds(Id accountId) {
        List<Account> lstAccount = getByIds(new Set<Id>{accountId});

        return (lstAccount.isEmpty() ? null : lstAccount[0]);
    }

    public static List<Account> getByIds(Set<Id> accountId) {
        return [
            SELECT    
                Id,
                Name,
                DocumentNumber__c,
                UserId__c,
                RecordTypeId,
                vlocity_cmt__CustomerValue__c, 
                vlocity_cmt__CustomerClass__c, 
                WhiteListCharacteristic__c, 
                LastModifiedDate,
                ShippingAddress,
                BillingAddress,
                ShippingStreet,
                ShippingPostalCode,
                ShippingCity,
                ShippingState,
                ShippingNumber__c,
                BillingStreet,
                BillingPostalCode,
                BillingCity,
                BillingState,
                BillingNumber__c
            FROM 
                Account
            WHERE 
                Id IN :accountId
        ];
    }

    public static List<Account> getAccountById(String accountId) {
        return [
            SELECT    
                Id,
                Name,
                DocumentNumber__c,
                UserId__c,
                vlocity_cmt__CustomerValue__c,
                vlocity_cmt__PrimaryContactId__r.MotherName__c,
                vlocity_cmt__PrimaryContactId__r.Birthdate,
                CreditScoreDate__c,
                RecordTypeId,
                vlocity_cmt__CreditScore__c,
                OwnerId
            FROM 
                Account
            WHERE 
                Id = :accountId
        ];
    }

    public static List<Account> getActiveById(String accountId) {
        return [
            SELECT 
                Id, 
                vlocity_cmt__CustomerValue__c,
                vlocity_cmt__CustomerClass__c, 
                WhiteListCharacteristic__c, 
                LastModifiedDate,
                vlocity_cmt__CreditScore__c
            FROM 
                Account 
            WHERE 
                vlocity_cmt__Active__c = 'Yes' AND 
                Id = :accountId
        ];
    }

    public static List<Account> getAccountUserIdById(Id accountId) {
        return [
            SELECT    
                Id,
                DocumentNumber__c,
                UserId__c
            FROM 
                Account
            WHERE 
                Id = :accountId
        ];
    }

    public static Account getAccountByIdAndLastMod(Id accountId, Datetime dateOfLastMod) {
        List<Account> lstAccount = getAccountsByIdAndLastModifiedDate(new Set<Id>{accountId}, dateOfLastMod);

        return (lstAccount.isEmpty() ? null : lstAccount[0]);
    }


    public static List<Account> getAccountsByIdAndLastMod(Set<Id> accountId, Datetime dateOfLastMod) {
        return (getAccountsByIdAndLastModifiedDate(accountId, dateOfLastMod));
    }

    public static List<Account> getAccountsByIdAndLastModifiedDate(Set<Id> accountId, Datetime dateOfLastModified) {
        return [
            SELECT    
                Id,
                Name,
                vlocity_cmt__PrimaryContactId__r.MotherName__c,                                        
                (SELECT Email FROM Contacts)
            FROM 
                Account
            WHERE 
                Id IN :accountId AND 
                LastModifiedDate > :dateOfLastModified
        ];
    }

    public static Account getAccountByCNPJ(String cnpj) {
        return (getAccountByDocumentNumber(cnpj));
    }

    public static List<Account> getAccountListByCNPJ (Set<String> cnpj) {
        return (getAccountListByDocumentNumber(cnpj));
    }

    public static Account getAccountByDocumentNumber(String documentNumber) {
        List<Account> lstAccount = getAccountListByDocumentNumber(new Set<String>{documentNumber});

        return (lstAccount.isEmpty() ? null : lstAccount[0]);
    }

    public static List<Account> getAccountListByDocumentNumber(Set<String> documentNumber) {
        return [
            SELECT    
                Id,
                Name,
                DocumentNumber__c,
                UserId__c,
                vlocity_cmt__PrimaryContactId__r.MotherName__c,
                vlocity_cmt__PrimaryContactId__c,
                CreditScoreDate__c,
                RecordTypeId,
                vlocity_cmt__CreditScore__c,
                vlocity_cmt__CustomerValue__c,
                Phone
            FROM 
                Account
            WHERE 
                DocumentNumber__c = :documentNumber
            LIMIT 1
        ];
    }

    public static List<Account> getAccountByPhoneNumber(String phoneNumber) {
        return [
            SELECT 
                Id, 
                Name,
                DocumentNumber__c,
                vlocity_cmt__CustomerValue__c
            FROM 
                Account 
            WHERE 
                Phone = :phoneNumber
            LIMIT 1
        ];
    }
}