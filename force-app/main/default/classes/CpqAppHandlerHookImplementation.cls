global with sharing class CpqAppHandlerHookImplementation implements vlocity_cmt.VlocityOpenInterface2
{
    global Boolean invokeMethod(String methodName, Map<String, Object> input, Map<String, Object> output, Map<String, Object> options)
    {
        try
        {
            //System.debug('DEBUG >> ____ CpqAppHandlerHookImplementation ' + methodName);

            if( methodName.equalsIgnoreCase('getCartsProducts.PostInvoke')) {
                getCartsProducts_PostInvoke(input, output,options);
                return true;
            } else if( methodName.equalsIgnoreCase('getOffersByCatalogCode.PostInvoke')) {
                getOffersByCatalogCode_PostInvoke(methodName, input, output, options);
                return true;
            } 

            return true;
        }
        catch (Exception ex)
        {
            System.debug('DEBUG >> Exception: ' + ex.getMessage());
            System.debug('DEBUG >> Stack Trace: ' + ex.getStackTraceString());
            
            throw ex;
            //return false;
        }
    }

    private void getCartsProducts_PostInvoke(Map<String, Object> input, Map<String, Object> output, Map<String, Object> options) {
        String JSON_KEY_NAME = 'ProductCode';
        String cartId = (String) input.get('cartId');

        String prodKey;
        Set<String> setProductCodes = new Set<String>();
        Order order = [SELECT Id, DDD__c FROM Order WHERE id = :cartId];
        String ddd = order.DDD__c;

        List<ProductEligibility__c> lstProdEle = [SELECT ProductId__r.ProductCode, DDD__c FROM ProductEligibility__c WHERE Active__c = true];
        Map<String, ProductEligibility__c> mapProdEle = new Map<String, ProductEligibility__c>();

        for (ProductEligibility__c prodEle : lstProdEle) {
            setProductCodes.add(prodEle.ProductId__r.ProductCode);

            List<String> lstDDD = prodEle.DDD__c.split(';');
            for (String prodEleDDD : lstDDD) {
                mapProdEle.put(prodEle.ProductId__r.ProductCode + prodEleDDD, prodEle);
            }
        } 

        List<vlocity_cmt.JSONRecord> records = new List<vlocity_cmt.JSONRecord>();        
        vlocity_cmt.JSONResult result = (vlocity_cmt.JSONResult) output.get('result');

        System.debug('DEBUG >> getCartsProducts_PostInvoke - result: ' + JSON.serializePretty(result));  
        
        List<vlocity_cmt.JSONRecord> recordsJson;
        Boolean remove;
        if (result != null) {
            recordsJson = result.records;

            for (vlocity_cmt.JSONRecord rec : recordsJson) {
                remove = true;

                Map<String, Object> mapProdCode = (Map<String, Object>) rec.fields.get(JSON_KEY_NAME);
                String productCode = (String) mapProdCode.get('value');

                if (!setProductCodes.contains(productCode)) {
                    remove = false;
                } else {
                    prodKey = productCode + ddd;
                    if (mapProdEle.get(prodKey) != null) {
                        remove = false;
                    }                    
                }

                if (remove != true) {
                    records.add(rec);
                }
            }
        
            vlocity_cmt.JSONResult outputResult = (vlocity_cmt.JSONResult) output.get('result');
            outputResult.records = records;   
        }  
    }

    private void getOffersByCatalogCode_PostInvoke(String methodName, Map<String, Object> input, Map<String, Object> output, Map<String, Object> options) {
        String context = (String) input.get('context');
        
        Map<String, String> valuesMap = (Map<String, String>) JSON.deserializeStrict(context, Map<String, String>.class);

        String ddd = (String) valuesMap.get('DDD');

        if (context != null) {
            List<Object> offers = (List<Object>) output.get('offers');
            System.debug('DEBUG >> getOffersByCatalogCode_PostInvoke - offers: ' + JSON.serializePretty(offers));  

            List<Object> filteredOffers = new List<Object>();
    
            String prodKey;
            Set<String> setProductCodes = new Set<String>();

            List<ProductEligibility__c> lstProdEle = [SELECT ProductId__r.ProductCode, DDD__c FROM ProductEligibility__c WHERE Active__c = true];
            Map<String, ProductEligibility__c> mapProdEle = new Map<String, ProductEligibility__c>();
    
            for (ProductEligibility__c prodEle : lstProdEle) {
                setProductCodes.add(prodEle.ProductId__r.ProductCode);
                
                List<String> lstDDD = prodEle.DDD__c.split(';');
                for (String prodEleDDD : lstDDD) {
                    mapProdEle.put(prodEle.ProductId__r.ProductCode + prodEleDDD, prodEle);
                }
            } 

            for (Integer i = 0; i < offers.size(); i++) {
                Boolean remove = true;

                Map<String, Object> offer = (Map<String, Object>) offers.get(i);
                String productCode = (String) offer.get('ProductCode');

                prodKey = productCode + ddd;

                if (!setProductCodes.contains(productCode)) {
                    remove = false;
                } else {
                    if (mapProdEle.get(prodKey) != null) {
                        remove = false;
                    }
                }

                if (remove != true) {
                    filteredOffers.add(offer);
                }                
            }

            output.put('offers', filteredOffers);            
        }
    }   
}