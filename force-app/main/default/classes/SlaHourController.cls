public with sharing class SlaHourController {
    
    @AuraEnabled
    public static Long getBusinessHourDiff(String BusinessHourId,  Datetime startDate, Datetime endDate){
        return BusinessHours.diff(BusinessHourId, startDate,  endDate);
    }
}