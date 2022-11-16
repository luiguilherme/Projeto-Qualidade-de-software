public with sharing class MassiveBillingAccountCaseService {
   
    public static AccountRetentionTO.BillingAccount getAccountRetentionFixed(Id accountId){
        
        GeneralParam__c generalParamObj = GeneralParam__c.getInstance();
        account accountObj = AccountDAO.getByIds(accountId);
        
        
        List<Account> lstBillingAccount = AccountRetentionEngine.getAccount(accountObj,generalParamObj, 'Fixa');
        List<Asset> lstAsset = AccountRetentionEngine.getAsset(accountObj,generalParamObj,'Fixa');

        return AccountRetentionEngine.createBillingAccount(lstBillingAccount,lstAsset, null);
    }

    public static Map<String, Object> getMassiveFixed(String assetInstance) {
        return MassiveBillingAccountCaseEngine.getMassiveFixed(assetInstance);
    }

    public static Map<String, Object> getMassiveSuspicion(String assetInstance) {
        return MassiveBillingAccountCaseEngine.getMassiveSuspicion(assetInstance);
    }
}