public with sharing class PublicGroupDAO {
    public static List<PublicGroup__mdt> getPublicsGroups(String userRole) {
        return [SELECT id, SimplifiedPublicGroups__c FROM PublicGroup__mdt WHERE PartnerGroup__c =: userRole];
    }

}