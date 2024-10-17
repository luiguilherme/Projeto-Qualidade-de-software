public with sharing class CustomerInteractionTopicService {
    public static void updateRelatedInteractionTopicWithCaseId(List<Case> ltNewCases) {
        Map<Id, vlocity_cmt__CustomerInteractionTopic__c> mapSourceTopics = 
            new Map<Id, vlocity_cmt__CustomerInteractionTopic__c>();
        
        for (Case newCase : ltNewCases) {
            if (newCase.CustomerInteractionTopic__c != null) {
                mapSourceTopics.put(
                    newCase.CustomerInteractionTopic__c,
                    new vlocity_cmt__CustomerInteractionTopic__c(
                        Id = newCase.CustomerInteractionTopic__c,
                        vlocity_cmt__CaseId__c = newCase.Id
                    )
                );
            }
        }
        
        if (!mapSourceTopics.isEmpty()) {
           List<vlocity_cmt__CustomerInteractionTopic__c> ltSourceTopics = 
                CustomerInteractionTopicDAO.getByIdWithoutCaseId(new Set<Id>(mapSourceTopics.keySet())); 
        
            if (!ltSourceTopics.isEmpty()) {
                List<vlocity_cmt__CustomerInteractionTopic__c> ltInteractionTopicsToUpdate = 
                    new List<vlocity_cmt__CustomerInteractionTopic__c>();
                
                for (vlocity_cmt__CustomerInteractionTopic__c topic : ltSourceTopics) {
                    ltInteractionTopicsToUpdate.add(mapSourceTopics.get(topic.Id));
                }

                update ltInteractionTopicsToUpdate;
            }
        }
    }
}