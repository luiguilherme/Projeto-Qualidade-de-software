public without sharing class DocumentController
{
    public String base64EncodedDocument { get; set; }
    public String documentId;

    public DocumentController()
    {
        this.getVisualForcePageDocumentId();
        if (!Test.isRunningTest()) { this.getDocument(); }
    }

    public void getVisualForcePagedocumentId()
    {
        this.documentId = ApexPages.currentPage().getParameters().get('document-id');
    }
    
    public void getDocument()
    {
        if (String.isBlank(this.documentId)) { throw new IllegalArgumentException('documentId não pode ser nulo.'); }
        try 
        {
            this.base64EncodedDocument = DocumentService.getBase64EncodedDocument(this.documentId);
            System.debug(this.base64EncodedDocument);
        }
        catch (Exception e)
        { 
            throw new AuraHandledException(e.getMessage()); 
        }
    }
}