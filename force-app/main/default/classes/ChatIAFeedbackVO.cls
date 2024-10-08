public with sharing class ChatIAFeedbackVO {
    public virtual class Feedback{
        @AuraEnabled public String feedback {get;set;}
        @AuraEnabled public String message {get;set;}
        @AuraEnabled public String correlator {get;set;}
    }
    public virtual class FeedbackResponse{
        @AuraEnabled public Boolean response { get; set; }
        @AuraEnabled public String code { get; set; }
        @AuraEnabled public String message { get; set; }
        @AuraEnabled public String service { get; set; }
        
    }
}