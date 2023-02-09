public with sharing class ServiceFlowGPSController {
    @AuraEnabled
    public static Map<String, Object> getServiceFlow(String pageReference) {
        return ServiceFlowGPSService.getServiceFlow(pageReference);
    }

    @AuraEnabled
    public static Map<String, Object> getActionGPS(String serviceFlowId, String assetInstance){
        return ServiceFlowGPSService.getActionGPS(serviceFlowId, assetInstance);
    }

    @AuraEnabled
    public static List<Asset> getAssetFixedByAccount(Id accountId) {
        return ServiceFlowGPSService.getAssetFixedByAccount(accountId);
    }

    @AuraEnabled
    public static Map<String, Object> getAccountInfo(Id accountId) {
        return ServiceFlowGPSService.getAccountInfo(accountId);
    }

    @AuraEnabled
    public static Map<String, Object> getNextGroup(String currentGroup) {
        return ServiceFlowGPSService.getNextGroup(currentGroup);
    }

    @AuraEnabled
    public static Map<String, Object> sendForm(String jsonMapForm, String currentGroup, String accountId, String assetInstance, Id serviceFlowId, String parentCaseId) {
        return ServiceFlowGPSService.sendForm(jsonMapForm, currentGroup, accountId, assetInstance, serviceFlowId, parentCaseId);
    }

    @AuraEnabled
    public static GPSProtocol getProtocol(String accountId, String assetInstance, String currentGroup, String serviceFlowId, String parentCaseId) {
        return ServiceFlowGPSService.getProtocol(accountId, assetInstance, currentGroup, serviceFlowId, parentCaseId);
    }

    @AuraEnabled
    public static Map<String, Object> getBase64(String jsonMapForm, String currentGroup, String accountId, String assetInstance, Id serviceFlowId) {
        return ServiceFlowGPSService.getBase64(jsonMapForm, currentGroup, accountId, assetInstance, serviceFlowId);
    }

    @AuraEnabled
    public static Boolean closeCase(Map<String, String> payload) {
        return ServiceFlowGPSService.closeCase(payload);
    }

    @AuraEnabled
    public static Map<String, Object> getURLToRedirect(String recordId){
        return ServiceFlowGPSService.getURLToRedirect(recordId);
    }
}