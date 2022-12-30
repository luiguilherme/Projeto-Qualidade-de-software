public with sharing class OfferLinksController {
    
    @AuraEnabled(cacheable=true)
    public static List<LinksBook__c> getLinks() {
        List<LinksBook__c> links = LinksBook__c.getall().values();
        return links;
    }
}