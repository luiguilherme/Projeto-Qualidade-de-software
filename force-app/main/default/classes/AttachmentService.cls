public without sharing class AttachmentService
{
    public static List<DocumentAttachment> getAttachments(String caseId)
    {
        if (String.isBlank(caseId)) { throw new IllegalArgumentException('caseId não pode ser nulo.'); }
        List<FileLink__c> fileLinks = FileLinkDAO.getBy(caseId);
        List<DocumentAttachment> attachments = new List<DocumentAttachment>();
            
        for (FileLink__c fileLinkRec : fileLinks)
        {
            DocumentAttachment attachment = new DocumentAttachment();
            attachment.id = fileLinkRec.Id;
            attachment.name = fileLinkRec.FileDescription__c;
            attachments.add(attachment);
        }
        return attachments;
    }
}