public with sharing class ChatIASelector {
    private final static ChatIASelector instance = new ChatIASelector();

    private ChatIASelector() {}

    public static ChatIASelector getInstance(){
        return instance;
    }

    public List<ChatIA__c> getActiveChatIA(String userId) {
        return [SELECT Id, Session__c, Backup__c, Usuario__c FROM ChatIA__c WHERE Active__c = true AND Usuario__c = :userId LIMIT 1];
    }

    public List<QuestionSuggestion__c> getQuestionSuggestion() {
        return [SELECT Id, Question__c, Order__c FROM QuestionSuggestion__c ORDER BY Order__c LIMIT 3];
    }

    public List<StandardQuestionSuggestion__mdt> getStandardQuestionSuggestion(Integer quantityNeeded) {
        return [SELECT Id, Question__c, Order__c FROM StandardQuestionSuggestion__mdt ORDER BY Order__c LIMIT :quantityNeeded];
    }
}