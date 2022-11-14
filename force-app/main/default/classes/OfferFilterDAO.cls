public with sharing class OfferFilterDAO {
    public static List<OfferFilter__c> getAllCitiesCategories(String CityCategoryAndCabinet) {

        return[
            SELECT 
                Id, 
                IsActive__c, 
                Cabinet__c, 
                City__c, 
                FilterCode__c, 
                Technology__c, 
                StateCode__c 
            FROM 
                OfferFilter__c 
            WHERE 
                IsActive__c = true 
            AND 
                RecordType.DeveloperName =: CityCategoryAndCabinet];
    }
}