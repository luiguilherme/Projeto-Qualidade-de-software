public without sharing class AttachmentController
{
    @AuraEnabled 
    public static List<DocumentAttachment> getAttachments(String caseId)
    {
        if (String.isEmpty(caseId)) { throw new IllegalArgumentException('caseId não pode ser nulo.'); }
        return AttachmentService.getAttachments(caseId);
    }
}