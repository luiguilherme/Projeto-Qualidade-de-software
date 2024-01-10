public with sharing class FeatureFlagEngine {
    public static Boolean applicationIsActive(String appName) {
        FeatureFlag__c featureFlagObj = FeatureFlag__c.getValues(appName); 
        return featureFlagObj.Active__c;
    }
}