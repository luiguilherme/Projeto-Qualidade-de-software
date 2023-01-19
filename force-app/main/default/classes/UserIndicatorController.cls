/*
---------------------------------------------------
@authors -  Pedro Salles 
@company - Telefonica 
@date - 24/04/2020
@description - Classe Controller do componente
Indicadores de Utilização dos usuários
---------------------------------------------------

*/
public class UserIndicatorController {
    
    @AuraEnabled
    public static CartAccount__c insertIndicator (id accountId, Id userId) {
        CartAccount__c insertIndicator = new CartAccount__c();
        
        List<CartAccount__c> findIndicator = [SELECT  Id, AccountId__c, OwnerId, CreatedDate
                                              FROM CartAccount__c 
                                              WHERE AccountId__c =: accountId 
                                              AND CreatedDate = TODAY
                                              AND OwnerId =: userId
                                              AND RecordType.DeveloperName = 'UseIndicator'];
        system.debug(findIndicator);
        if (findIndicator.size() <= 0){
            insertIndicator.AccountId__c = accountId;
            insertIndicator.RecordTypeId = Schema.SObjectType.CartAccount__c.getRecordTypeInfosByDeveloperName().get('UseIndicator').getrecordTypeId();
            insert insertIndicator;
            
        }   
        
        return insertIndicator;
    }
    
}