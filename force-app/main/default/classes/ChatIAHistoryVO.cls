public with sharing class ChatIAHistoryVO {
    public virtual class CreateHistory {
          @AuraEnabled public List<Chat> chats {get; set;}
    }

    public virtual class CreateNewChat {
        @AuraEnabled public Chat chat {get; set;}
    }
    public virtual class Feedback{
        @AuraEnabled public String feedback {get;set;}
        @AuraEnabled public String correlator {get;set;}

    }
    public virtual class Chat {
        @AuraEnabled public String x_id {get; set;}
        @AuraEnabled public String x_date {get; set;}
        @AuraEnabled public List<History> history {get; set;}
    }
    public virtual class ChatHistory {
        @AuraEnabled public String x_date {get; set;}
        @AuraEnabled public List<NewHistory> history {get; set;}
    }
    public virtual class NewHistory {
        @AuraEnabled public String type {get; set;}
        @AuraEnabled public String message {get; set;}
        @AuraEnabled public String correlator {get;set;}
        @AuraEnabled public String feedback {get;set;}
        @AuraEnabled public Boolean has_feedback {get;set;}
    }
    public virtual class History {
        @AuraEnabled public String type {get; set;}
        @AuraEnabled public String message {get; set;}
        @AuraEnabled public String correlator {get;set;}
        @AuraEnabled public String feedback {get;set;}
        @AuraEnabled public Boolean has_feedback {get;set;}
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

    /**
    * Date: 18-01-2024
    * Author: nicholas.cinto@everymind.com.br
    * Description: Criação de classes para novo consumo de API
    */
    public virtual class CreateNewHistory {
        @AuraEnabled public List<ChatHistory> chats;
    }

    public virtual class CreateNewHistoryResponse {
        @AuraEnabled public List<CreateNewChatResponse> chats;
        @AuraEnabled public String x_id;
        @AuraEnabled public String v;
        @AuraEnabled public Datetime created_at;
        
        
        // Letra 'x' inserida devido a ajuste na string no momento da deserialização com o método replace/replaceAll
        @AuraEnabled public String userx_id;
        @AuraEnabled public String flowx_id;
        @AuraEnabled public Datetime upx_dated_at;
    }
}