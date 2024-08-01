public with sharing class ChatAppVivoController 
{
    @AuraEnabled
    public static List<ChatMessage> getChatMessagesByCaseId(String caseId)
    {
        if (String.isEmpty(caseId)) { throw new IllegalArgumentException('caseId não pode ser nulo.'); }
        List<CaseComment__c> caseComments = CaseCommentDAO.getCaseCommentsByCaseId(caseId);
        return ChatAppVivoService.buildMessages(caseComments);
    }

    @AuraEnabled
    public static ChatMessage newChatMessage(String caseId, String newMessage)
    {
        try 
        {
            if (String.isEmpty(caseId)|| String.isEmpty(newMessage)) { throw new IllegalArgumentException('caseId ou newMessage não pode ser nulo.'); }
            CaseComment__c newCaseComment = ChatAppVivoService.createCaseComment(caseId, newMessage);
            return ChatAppVivoService.buildMessage(newCaseComment);
        } 
        catch (Exception e)
        {
            System.debug('newChatMessage(): ' + e.getMessage());
            throw new AuraHandledException(e.getMessage());
        }
    }
}