public with sharing class SuggestedSpeedDAO {
    public static List<SuggestedSpeed__c> getSuggestedSpeed() {
        return [SELECT Id, SuggestedSpeed__c, CurrentSpeed__c 
                FROM SuggestedSpeed__c 
                ORDER BY SuggestedSpeed__c ASC];
    }
}