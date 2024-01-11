global with sharing class FeatureFlagService {
    global static Boolean applicationIsActive(String appName) {
        return FeatureFlagEngine.applicationIsActive(appName);
    }
}