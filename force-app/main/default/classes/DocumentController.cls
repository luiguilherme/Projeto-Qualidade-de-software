public without sharing class DocumentController {
    public String base64EncodedDocument { get; set; }
    public String documentId;

    public void getDocument() {
        this.getVisualForcePageDocumentId();
        this.getBase64EncodedDocument();
    }

    public void getVisualForcePagedocumentId() {
        this.documentId = ApexPages.currentPage().getParameters().get('document-id');
    }
    
    public void getBase64EncodedDocument() {
        if (String.isBlank(this.documentId)) {
            throw new IllegalArgumentException('documentId não pode ser nulo.'); 
        }
        try {
            this.base64EncodedDocument = DocumentService.getBase64EncodedDocument(this.documentId);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage()); 
        }
    }
}