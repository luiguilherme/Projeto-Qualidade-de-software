public with sharing class AccountRetentionEngine {
    
    public static List<Account> getAccount(Account accountObj, GeneralParam__c generalParamObj, String developerName){	
        List<String> ltCustomerSegment = CollectionUtil.stringForList(generalParamObj.CustomerSegment__c);
        List<String> ltCustomerType = CollectionUtil.stringForList(generalParamObj.CustomerType__c);
        List<Account> ltAccount = new List<Account>();

        if(accountObj == null || (ltCustomerSegment.contains(accountObj.vlocity_cmt__CustomerValue__c) && ltCustomerType.contains(accountObj.vlocity_cmt__CustomerClass__c) && accountObj.LastModifiedDate < generalParamObj.AccountLoadDate__c) ){
            return ltAccount;
        }

        
        if(ltCustomerSegment.contains(accountObj.vlocity_cmt__CustomerValue__c) && ltCustomerType.contains(accountObj.vlocity_cmt__CustomerClass__c)){    
            ltAccount = BillingAccountDAO.getByAccountIdDeveloperNameLastmodifiedDate(accountObj.Id, developerName, generalParamObj.BillingAccountLoadDate__c);
        }else{
            ltAccount = BillingAccountDAO.getByAccountIdDeveloperName(accountObj.Id, developerName);
        }   
        
        return ltAccount;
    }

    public static List<Asset> getAsset(Account accountObj, GeneralParam__c generalParamObj, String developerName){
	
        List<String> ltCustomerSegment = CollectionUtil.stringForList(generalParamObj.CustomerSegment__c);
        List<String> ltCustomerType = CollectionUtil.stringForList(generalParamObj.CustomerType__c);
        List<Asset> ltAsset = new List<Asset>();

        if(ltCustomerSegment.contains(accountObj.vlocity_cmt__CustomerValue__c) && ltCustomerType.contains(accountObj.vlocity_cmt__CustomerClass__c)){  
            ltAsset = AssetDAO.getByAccountIdRecordtypeDeveloperNameLastModifiedDate(accountObj.Id,developerName,generalParamObj.AssetLoadDate__c);
        }else{
            ltAsset = AssetDAO.getByAccountIdRecordtypeDeveloperName(accountObj.Id, developerName);
        }

        return ltAsset;
    }

    public static AccountRetentionTO.BillingAccount createBillingAccount(List<Account> lstAccount, List<Asset> lstAsset, List<Offer__c> ltOffer){
        AccountRetentionTO.BillingAccount billingAccountTOObj = new AccountRetentionTO.BillingAccount();        
        //Ordernar as contas de faturamento com os asset
        Map<Id,List<Asset>> mapAssetForBillintAccount;                
        CollectionUtil.loadMap(mapAssetForBillintAccount = new Map<Id,List<Asset>>(),'vlocity_cmt__BillingAccountId__c',lstAsset);
        
        for(Account billingAccountObj :lstAccount){            
            billingAccountTOObj.ltAsset = new List<Asset>();
            billingAccountTOObj.idBilling = billingAccountObj.Id;
            billingAccountTOObj.name = 'Conta Faturamento: ' + billingAccountObj.ExternalId__c; 
            billingAccountTOObj.totalPrice = billingAccountObj.OfferReferenceValue__c;
            billingAccountTOObj.hasMultipleAssets = false;

            List<Asset> lstAssetInteration = mapAssetForBillintAccount.containsKey(billingAccountObj.Id) != null ? mapAssetForBillintAccount.get(billingAccountObj.Id) : null ; 
            
            if(lstAssetInteration != null){
                Set<String> setProductType = new Set<String>();
                Set<String> setAddress = new Set<String>();
                
                billingAccountTOObj.hasAsset = true;

                for(Asset assetObj : lstAssetInteration){
                    
                    billingAccountTOObj.ltAsset.add(assetObj);
					
                    if(!setProductType.contains(assetObj.ProductType__c)){                        
                        setAddress.add(assetObj.vlocity_cmt__ServiceAccountId__r.FullAddress__c);
                        setProductType.add(assetObj.ProductType__c);
                    }else{
                        billingAccountTOObj.hasMultipleAssets = true;
                    }
                }				
                if(setAddress.isEmpty() || setAddress.size() > 1){
                    billingAccountTOObj.hasAsset = false;
                }   
            }            
        }		
        return billingAccountTOObj;    
    }
}