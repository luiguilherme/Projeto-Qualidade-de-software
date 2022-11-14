/*
---------------------------------------------------
@authors -  Pedro Salles 
@company - Telefonica 
@date - 29/04/2020
@description - Classe Controller do componente SelectCart
---------------------------------------------------

Atualização
@author - Thiago Ribeiro Silva
@company - Everis 
@date - 31/08/2020
@description - Implementado validação dos templates por papeis e adicionado um campo novo no fixa (Tipo de Produto).

---------------------------------------------------
Changes
2020-09-30 @Alvaro - B2C7551-402 - Removido Asset__c do SOQL de Offer__c
*/
public without sharing class InsertCartController {
    @AuraEnabled
    public static Map<String, Object> setInsertOffer(String offerId, String ltCardProposal, Id accountId, Id selectedOfferAltaId, Id userId, String ltBillingAccountFixed, String ltBillingAccountMobile){
        return InsertCartService.setInsertOffer(offerId, ltCardProposal, accountId, selectedOfferAltaId, userId, ltBillingAccountFixed, ltBillingAccountMobile);
    }
    
    @AuraEnabled
    public static Boolean userHavePermissionSet(){
        return FeatureManagement.checkPermission('AcessRpaFlow');
    }

    @AuraEnabled
    public static Boolean accountHaveLimit(Id accountId){
        final String recordType = String.escapeSingleQuotes('UpSellMobileTotaled');
        return CartAccountDao.getCartOnTheDay(accountId, recordType) < 3;
    }
}