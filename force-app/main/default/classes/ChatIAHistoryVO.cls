public with sharing class ChatIAHistoryVO {
    public virtual class History {
        @AuraEnabled public String message {get; set;}
        @AuraEnabled public String response {get; set;}
        @AuraEnabled public String feedback {get;set;}
        @AuraEnabled public String correlator {get;set;}
        @AuraEnabled public String feedback_message {get;set;}
        @AuraEnabled public String userId {get;set;}
        @AuraEnabled public String subscriptionId {get;set;}
        @AuraEnabled public String createdAt {get;set;}
        @AuraEnabled public String sessionId { get; set; }
    }
    public virtual class GetHistoryByIdResponse {
        @AuraEnabled public List<History> history { get; set; }
        @AuraEnabled public Boolean response { get; set; }
        @AuraEnabled public String code { get; set; }
        @AuraEnabled public String message { get; set; }
        @AuraEnabled public String service { get; set; }
    }
    

    public virtual class DeleteChatByIdResponse{
        @AuraEnabled public Boolean response {get; set;}
        @AuraEnabled public String code {get; set;}
        @AuraEnabled public String message {get; set;}
        @AuraEnabled public String service {get; set;}
    }
}