public with sharing class GpsCanvasIntegrationController {
    @AuraEnabled(cacheable=true)
        public static String getSessionId() {
        return UserInfo.getSessionId();
    }
}