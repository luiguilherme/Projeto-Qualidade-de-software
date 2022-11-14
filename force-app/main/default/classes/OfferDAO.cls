public class OfferDAO {
    //trocar o whiteList por score de credito
    public static List<Offer__c> getOfferAltaMovelByCreditScore(String accountCreditScore) {
        return [
            SELECT Id, 
                MobilePlan__c,
                TotalPrice__c, 
                MobileDescription__c, 
                MobileInternetDescription__c, 
                MobilePriceDiscount__c, 
                WhiteListCharacteristicOffer__c, 
                SourceSystem__c 
            FROM 
                Offer__c 
            WHERE 
                RecordType.DeveloperName = 'AltaMovel' 
            AND IsActive__c = true 
            // AND WhiteListCharacteristicOffer__c INCLUDES (:whitelist) 
            AND CreditScoreCharacteristicOffer__c INCLUDES(:accountCreditScore)
            ORDER BY TotalPrice__c DESC];
    }  

    public static List<Offer__c> getOfferMovelITV(String offerType) {
        return [
            SELECT Id,
                TotalPrice__c, 
                MobileDescription__c,
                Instructions__c	
            FROM 
                Offer__c 
            WHERE 
                RecordType.DeveloperName =: offerType 
            AND IsActive__c = true 
            ORDER BY TotalPrice__c ASC];
    } 

    public static List<Offer__c> getEnabledFilteredOffers( List<String> setCityCategories, 
                            String accTechnology, List<String> setOfferLevel, List<Boolean> setCabinet, String offerType, String broadBand, String tvPlan, String fixedLineDesc, Boolean order){

        //System.assert(false, 'categories ' + setCityCategories + ' technology ' + accTechnology + ' Offer ' + setOfferLevel + ' Cabinet ' + setCabinet + ' offertype ' + offerType + 'broadband' + broadBand + ' tvPlan ' + tvPlan + ' linedesc ' + fixedLineDesc + ' order ' + order);
        if(order){
            return  [
            SELECT Id, 
            Cabinet__c, 
            FixedLineDiscount__c, 
            FixedCampaignRTD__c, 
            BroadBandDiscount__c, 
            TVDiscount__c,
            FixedLineDescription__c, 
            BroadbandDescription__c, 
            TVDescription__c,
            OfferCardDescription__c, 
            PlanTotalPrice__c,
            Technology__c, 
            BroadBandAttribute__c, 
            FixedLinePlanAttribute__c, 
            TvAttribute__c, 
            OfferCityCategory__c, 
            TotalPrice__c, 
            BroadbandDiscountDuration__c, 
            FixedLineDiscountDuration__c, 
            TVDiscountDuration__c,
            BroadbandPromoPrice__c,
            TVPromoPrice__c,
            FixedLinePromoPrice__c
        FROM Offer__c 
        WHERE IsActive__c = true 
            AND OfferCityCategory__c IN: setCityCategories 
            AND Technology__c =: accTechnology 
            AND BroadBandAttribute__c =: broadBand 
            AND Cabinet__c IN: setCabinet  
            AND RecordType.DeveloperName =: offerType 
            AND OfferLevel__c IN: setOfferLevel 
            AND TVAttribute__c =: tvPlan 
            AND FixedLineDescription__c =: fixedLineDesc 
            ORDER BY TotalPrice__c ASC
        /*AND StatusDW__c = true*/];
        }else{
            return  [
            SELECT Id, 
            Cabinet__c, 
            FixedLineDiscount__c, 
            FixedCampaignRTD__c, 
            BroadBandDiscount__c, 
            TVDiscount__c,
            FixedLineDescription__c, 
            BroadbandDescription__c, 
            TVDescription__c,
            OfferCardDescription__c, 
            PlanTotalPrice__c,
            Technology__c, 
            BroadBandAttribute__c, 
            FixedLinePlanAttribute__c, 
            TvAttribute__c, 
            OfferCityCategory__c, 
            TotalPrice__c, 
            BroadbandDiscountDuration__c, 
            FixedLineDiscountDuration__c, 
            TVDiscountDuration__c,
            BroadbandPromoPrice__c,
            TVPromoPrice__c,
            FixedLinePromoPrice__c
        FROM Offer__c 
        WHERE IsActive__c = true 
            AND OfferCityCategory__c IN: setCityCategories 
            AND Technology__c =: accTechnology 
            AND BroadBandAttribute__c =: broadBand 
            AND Cabinet__c IN: setCabinet  
            AND RecordType.DeveloperName =: offerType 
            AND OfferLevel__c IN: setOfferLevel 
            AND TVAttribute__c =: tvPlan 
            AND FixedLineDescription__c =: fixedLineDesc 
            ORDER BY TotalPrice__c DESC
        /*AND StatusDW__c = true*/];
        } 
    }
    
    public static List<Offer__c> getOffersById(Set<id> setOffers) {
        List<Offer__c> ltOffer = [
                        SELECT 
                            Id, 
                            FixedLineDescription__c, 
                            BroadbandDescription__c, 
                            RecordType.DeveloperName 
                        FROM
                            Offer__c 
                        WHERE 
                            Id IN :setOffers];
        return ltOffer;
    }
    


    public static List<Offer__c> getOfferMobileByOrder(Set<String> setMainProductDescription,String recordType, String accCustomerType){
        return [SELECT Id, MobilePlan__c,TotalPrice__c, MobileDescription__c, MobileInternetDescription__c, SourceSystem__c, DDDOferta__c 
            FROM Offer__c 
            WHERE IsActive__c = true 
            AND MobilePlan__c IN: setMainProductDescription 
            AND RecordType.DeveloperName = :recordType 
            AND CustomerType__c includes ( :accCustomerType )
            ORDER BY TotalPrice__c DESC];
    }
}