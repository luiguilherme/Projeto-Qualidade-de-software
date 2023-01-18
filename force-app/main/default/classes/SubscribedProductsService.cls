public Inherited Sharing class SubscribedProductsService {


   public static Boolean validateUserIdInformation(Id accountId){
      return Util.validateUserIdInformation(accountId);
   }

   public static SubscribedProductsTO.ReturnTO getSubscribedProducts(Id accountId){
   
    try {
         Account accountObj = AccountDAO.getByIds(accountId);
        
         if(accountObj == null || accountObj.UserId__c == null){
            throw new SubscribedProductsException('UserId não localizado!');
         }

         List<SubscribedProductsTO> ltResponseBody = new  List<SubscribedProductsTO>();
         ServiceResponse serviceResponseObj = SubscribedProductsEngine.callIntegration(accountObj.UserId__c);

         if(!serviceResponseObj.success){
            throw new SubscribedProductsException('SubscribedProducts não foi processada, ocorreu um problema com o retorno da integrção.');
         }
         
         ltResponseBody = SubscribedProductsEngine.deserializeSubscribedProducts(serviceResponseObj);
         Map<String,String> mapFromTo = SubscribedProductsEngine.createFromToMapping(null,'SubscribedProducts');
         List<Asset> ltExisingAssets = AssetDAO.getByAccountId(accountObj.Id);   
         Map<String,String> mapRecordTypeBillingAccountForName = SubscribedProductsEngine.getBillingAccountInformationResponse(ltResponseBody,ltExisingAssets, accountObj.DocumentNumber__c, mapFromTo);
         Map<String, Account> mapBillingAccountForName = SubscribedProductsEngine.billingAccountManager(mapRecordTypeBillingAccountForName, accountObj.Id);
         List<Asset> ltRecords = SubscribedProductsEngine.integrationResponseProcessing(ltResponseBody,mapBillingAccountForName,accountObj, mapFromTo);
         List<Asset> ltRemoveRecords = SubscribedProductsEngine.validateExistingRecords(accountObj.Id, ltExisingAssets, ltRecords);
         SubscribedProductsEngine.getAddedServiceByType(ltRecords,ltResponseBody,'incluso');
         List<FromToMapping__mdt> lstFromtoMapCustomerClient = FromToMappingDAO.getByObject('CustomerType');
         mapFromTo = SubscribedProductsEngine.createFromToMapping(mapFromTo,'CustomerType');
         String customerType = SubscribedProductsEngine.getClientType(ltResponseBody,mapFromTo,accountObj.Id);
         
         upsert ltRecords LegacyAssetId__c;

         if(!ltRemoveRecords.isEmpty()){
            delete ltRemoveRecords;
         }

         try {
            if(customerType != null){
               update new Account(Id = accountObj.Id);
            }   
         } catch (Exception ex) {
            return SubscribedProductsEngine.createObjectReturn('warning', 'Erro na atualizacao de tipo de cliente');
         }
         
         return SubscribedProductsEngine.createObjectReturn('success', null);
      } catch (SubscribedProductsException ex) {
         return SubscribedProductsEngine.createObjectReturn('warning', ex.getMessage());
      } 
   }
}