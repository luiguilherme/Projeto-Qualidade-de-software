public with sharing class SyncOrderWithHybrisButtonController {
    @AuraEnabled
    public static Map<String, Object> syncHybrisOrderStatus(String recordId){
        try {
            return OrderHybrisService.syncOrderStatusWithHybris(recordId);
        } catch (Exception e) {
            throw new AuraHandledException(System.Label.HybrisContactAdmin);
        }
    }
 }