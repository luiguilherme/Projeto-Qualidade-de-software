public with sharing class ChatIAHistoryVO {
    public virtual class CreateHistory {
        @AuraEnabled public List<Chat> chats {get; set;}
    }

    public virtual class CreateNewChat {
        @AuraEnabled public Chat chat {get; set;}
    }

    public virtual class Chat {
        @AuraEnabled public String x_id {get; set;}
        @AuraEnabled public String x_date {get; set;}
        @AuraEnabled public List<History> history {get; set;}
    }

    public virtual class History {
        @AuraEnabled public String type {get; set;}
        @AuraEnabled public String message {get; set;}
        @AuraEnabled public String x_id {get; set;}
    }

    public virtual class CreateHistoryResponse {
        @AuraEnabled public String user_id {get; set;}
        @AuraEnabled public String flow_id {get; set;}
        @AuraEnabled public List<Chat> chats {get; set;}

    }
    
    public virtual class CreateNewChatResponse {
        @AuraEnabled public String x_id {get; set;}
        @AuraEnabled public String x_date {get; set;}
        @AuraEnabled public List<History> history {get; set;}
    }
    

    public virtual class GetHistoryByIdResponse {
        @AuraEnabled public Boolean chatFound {get; set;}
        @AuraEnabled public String x_id {get; set;}
        @AuraEnabled public String x_date {get; set;}
        @AuraEnabled public List<History> history {get; set;}
    }
    public virtual class GetAllHistoryResponse {
        @AuraEnabled public String user_id {get; set;}
        @AuraEnabled public String x_id {get; set;}
        @AuraEnabled public String flow_id {get; set;}
        @AuraEnabled public List<Chat> chats {get; set;}
       
    }

    public virtual class DeleteChatByIdResponse {
        @AuraEnabled public String response {get; set;}
    }
}