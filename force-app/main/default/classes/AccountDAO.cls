/** 
 * @author Diego Costa @ Deloitte
 * @date 02/06/2022
 * @description Controla a busca e criação do objeto Account
 */
public with sharing class AccountDAO {
    
    public static Account getByIds(Id accountId){
        List<Account> lst = getByIds(new Set<Id>{accountId});
        return lst.isEmpty() ? null : lst[0];
    }

    public static Account getAccountByIdAndLastMod(Id accountId, Datetime dateOfLastMod){
        List<Account> lst = getAccountsByIdAndLastMod(new Set<Id>{accountId}, dateOfLastMod);
        return lst.isEmpty() ? null : lst[0];
    }
    
    public static List<Account> getByIds(Set<Id> setAccountId){
        return [SELECT    
               	 Id,
                 Name,
                 DocumentNumber__c,
                 UserId__c,
                 RecordTypeId,
              //   CustomerSegment__c, 
                 vlocity_cmt__CustomerClass__c, 
                 WhiteListCharacteristic__c, 
                 LastModifiedDate
                FROM 
                  Account
                WHERE 
                  Id IN :setAccountId
               ];
    }

    public static List<Account> getAccountById(Id accountId){
        return [
            SELECT    
                Id,
                Name,
                DocumentNumber__c,
                UserId__c,
        //        CustomerSegment__c,
                vlocity_cmt__PrimaryContactId__r.MotherName__c,                
                CreditScoreDate__c,
                RecordTypeId,
                vlocity_cmt__CreditScore__c
            FROM 
                Account
            WHERE 
                Id =: accountId];
        
    }

    public static List<Account> getActiveById(String accountId){
        return [
            SELECT Id, 
          //      CustomerSegment__c, 
                vlocity_cmt__CustomerClass__c, 
                WhiteListCharacteristic__c, 
                LastModifiedDate,
                vlocity_cmt__CreditScore__c
            FROM 
                Account 
            WHERE 
                vlocity_cmt__Active__c = 'Yes' 
            AND Id = :accountId];
    }
    
    public static List<Account> getAccountUserIdById(Id accountId){
        List<Account> lstAccount = new List<Account>();

        lstAccount = [SELECT    
                            Id,
                      		DocumentNumber__c,
                            UserId__c
                        FROM 
                            Account
                        WHERE 
                            Id =: accountId];
        return lstAccount;
    }

    public static List<Account> getAccountsByIdAndLastMod(Set<Id> setAccountId, Datetime dateOfLastMod){
        List<Account> ltAccount = [SELECT    
                                        Id,
                                        Name,
                                        vlocity_cmt__PrimaryContactId__r.MotherName__c,                                        
          //                              EmailPersonAccount__c,
                                        (SELECT Email FROM Contacts)
                                    FROM 
                                        Account
                                    WHERE 
                                        Id IN: setAccountId
                                        AND LastModifiedDate >: dateOfLastMod
                                        ];
        return ltAccount;
    }

    public static Account getAccountByCNPJ(String cnpj){
        List<Account> lst = getAccountListByCNPJ(new Set<String>{cnpj});
        return lst.isEmpty() ? null : lst[0];
    }


    public static List<Account> getAccountListByCNPJ (Set<String> cnpjSet) {
        return [
                SELECT    
                    Id,
                    Name,
                    DocumentNumber__c,
                    UserId__c,
                    vlocity_cmt__PrimaryContactId__r.MotherName__c,                    
                    CreditScoreDate__c,
                    RecordTypeId,
                    vlocity_cmt__CreditScore__c
                FROM 
                    Account
                WHERE 
                    DocumentNumber__c =: cnpjSet
                LIMIT 1
            ];
    }
}