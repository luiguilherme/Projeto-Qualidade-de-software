public with sharing class ChatIAQNAAnswerVO {
    public virtual class BodyToReceive{
        @AuraEnabled public String content{get; set;}
        @AuraEnabled public List<SupportingSnippets> supporting_snippets{get; set;}      
        @AuraEnabled public String correlator{get; set;}        
            
    }

    public virtual class SupportingSnippets{
        @AuraEnabled public String content{get; set;}       
        @AuraEnabled public Document document{get; set;}       
        @AuraEnabled public String page_number{get; set;}     
    }

    public virtual class Document{
        @AuraEnabled public String name{get; set;}       
        @AuraEnabled public String url{get; set;}       
        
    }
}