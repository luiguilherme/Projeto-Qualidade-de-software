public with sharing class ChatAppVivoService
{
    public class Message
    {
        @AuraEnabled public String id;
        @AuraEnabled public String parentId;
        @AuraEnabled public String message;
        @AuraEnabled public Boolean fromCustomer;
        @AuraEnabled public String origin;
    }

    public static CaseComment__c createCaseComment(String caseId, String newMessage)
    {
        CaseComment__c newCaseComment = new CaseComment__c();
        newCaseComment.ParentId__c = caseId;
        newCaseComment.Origin__c = 'Salesforce';
        newCaseComment.Comment__c = newMessage;
        insert newCaseComment;
        return newCaseComment;
    }

    public static List<ChatMessage> buildMessages(List<CaseComment__c> caseComments)
    {
        List<ChatMessage> messages = new List<ChatMessage>();
        for (CaseComment__c caseComment : caseComments)
        {
            ChatMessage message = ChatAppVivoService.buildMessage(caseComment);
            messages.add(message);
        }
        return messages;
    }

    public static ChatMessage buildMessage(CaseComment__c caseComment) 
    {
        ChatMessage message = new ChatMessage();
        message.id = caseComment.Id;
        message.parentId = caseComment.ParentId__c;
        message.message = caseComment.Comment__c;
        message.fromCustomer =  caseComment.Origin__c == 'App Vivo' ? true : false;
        message.origin = caseComment.Origin__c;
        return message;
    }
}