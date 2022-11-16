public with sharing class MassiveBillingAccountCaseEngine {
    
    public static Map<String, Object> getMassiveFixed(String assetInstance) {
        Map<String, Object> mapResponse = new Map<String,Object>();

        mapResponse = MassiveFixedCaseCallout.execute(mapResponse, assetInstance);
        
        return mapResponse;
    }

    public static Map<String, Object> getMassiveSuspicion(String assetInstance){
        Map<String, Object> mapResponse = new Map<String,Object>();

        mapResponse = MassiveSuspicionCaseCallout.execute(mapResponse, assetInstance);
        
        return mapResponse;
    }
}