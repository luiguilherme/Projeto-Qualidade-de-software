public with sharing class ChatIAAuthenticationVO {
    public virtual class Auth{
        @AuraEnabled public String token{get; set;}                  
    }

    public virtual class BodyToReceive{
        @AuraEnabled public String user_profile {get; set;}        
        @AuraEnabled public List<String> user_profile_permission {get; set;}        
        @AuraEnabled public String user_id {get; set;}        
        @AuraEnabled public String user_name {get; set;}        
        @AuraEnabled public String user_email {get; set;}        
        @AuraEnabled public String session_id {get; set;}       
        @AuraEnabled public String oam_matricula {get; set;}       
        @AuraEnabled public String oam_gestor {get; set;}       
        @AuraEnabled public String oam_ccusto {get; set;}       
        @AuraEnabled public String token {get; set;}       
        @AuraEnabled public List<Subscription> subscriptions {get; set;}       
        @AuraEnabled public String correlator {get; set;}       
        @AuraEnabled public List<Product> products {get; set;}       
    }

    public virtual class Subscription{
        @AuraEnabled public String x_id {get; set;}
        @AuraEnabled public String x_v {get; set;}
        @AuraEnabled public String tenantId {get; set;}
        @AuraEnabled public String tenantName {get; set;}
        @AuraEnabled public String subscriptionId {get; set;}
        @AuraEnabled public String subscriptionName {get; set;}
        @AuraEnabled public String subscriptionDescription {get; set;}
        @AuraEnabled public String subscriptionRoute {get; set;}
        @AuraEnabled public String created_at {get; set;}
        @AuraEnabled public String updated_at {get; set;}
        @AuraEnabled public List<String> permissions {get; set;}
    }

    public virtual class Product{
        @AuraEnabled public String x_id {get; set;}
        @AuraEnabled public String name {get; set;}
        @AuraEnabled public String description {get; set;}
        @AuraEnabled public String bu {get; set;}
        @AuraEnabled public String url {get; set;}
        @AuraEnabled public String project {get; set;}
        @AuraEnabled public String x_v {get; set;}
        @AuraEnabled public String created_at {get; set;}
        @AuraEnabled public String updated_at {get; set;}
        @AuraEnabled public List<String> permissions {get; set;}
    }
}