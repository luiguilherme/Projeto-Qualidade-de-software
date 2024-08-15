public class DisputedItemController {
    @AuraEnabled(cacheable=false)
    public static List<DisputedItem__c> getByCaseId(Id caseId) {
        return DisputedItemDAO.getByCaseId(caseId);
    }
}