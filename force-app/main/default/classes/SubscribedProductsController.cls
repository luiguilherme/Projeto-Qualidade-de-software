public without sharing class SubscribedProductsController {
    
    @AuraEnabled
    public static Boolean validateUserIdInformation(Id accountId){
        return SubscribedProductsService.validateUserIdInformation(accountId);
    }

     
    @AuraEnabled
    public static SubscribedProductsTO.ReturnTO getSubscribedProducts(Id accountId){
       return SubscribedProductsService.getSubscribedProducts(accountId);
    }
}