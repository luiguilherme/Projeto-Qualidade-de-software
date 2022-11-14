public without sharing class InsertCartSelector {
    public static List<TemplateMessage__mdt> getListTemplateMessageByType(String type){
        List<TemplateMessage__mdt> ltTemplates = [
                                    SELECT 
                                        TemplateMessage__c, 
                                        Roles__c, 
                                        TemplateType__c 
                                    FROM
                                        TemplateMessage__mdt 
                                    WHERE 
                                        TemplateType__c =: type];
        return ltTemplates;
    }

    public static Offer__c getOfferAlta(Id selectedOfferAltaId){
        Offer__c returnOffer =  [
                            SELECT 
                                Id, 
                                MobilePlan__c,
                                TotalPrice__c, 
                                MobileDescription__c, 
                                MobileInternetDescription__c, 
                                MobilePriceDiscount__c 
                            FROM    
                                Offer__c 
                            WHERE 
                                RecordType.DeveloperName = 'AltaMovel' AND 
                                IsActive__c = true AND 
                                ID =: selectedOfferAltaId];
        return returnOffer;
    }
}