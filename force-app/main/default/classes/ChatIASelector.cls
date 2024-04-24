public with sharing class ChatIASelector {
    private final static ChatIASelector instance = new ChatIASelector();

    private ChatIASelector() {}

    public static ChatIASelector getInstance(){
        return instance;
    }

    public List<ChatIA__c> getLastChatIA(String userId) {
        return [SELECT Id, Session__c, History__c, Active__c, Backup__c, Usuario__c FROM ChatIA__c WHERE Usuario__c =:userId ORDER BY CreatedDate DESC LIMIT 1];
    }

    public List<QuestionSuggestion__c> getQuestionSuggestion() {
        return [SELECT Id, Question__c, Order__c FROM QuestionSuggestion__c ORDER BY Order__c LIMIT 3];
    }

    public List<StandardQuestionSuggestion__mdt> getStandardQuestionSuggestion(Integer quantityNeeded) {
        return [SELECT Id, Question__c, Order__c FROM StandardQuestionSuggestion__mdt ORDER BY Order__c LIMIT :quantityNeeded];
    }
    public List<PermissionSetAssignment> getPermission(String userId) {
        return [SELECT Id, AssigneeId, PermissionSet.Name FROM PermissionSetAssignment WHERE AssigneeId =: userId AND PermissionSet.Name = 'ChatIA'];
    }
    public User getUser(String userId) {
        //para B2B usar BI_BR_Login_de_rede__c
        return [SELECT Id, Name, Email, Login__c, Profile.Name FROM User WHERE Id =: userId];
    }
}