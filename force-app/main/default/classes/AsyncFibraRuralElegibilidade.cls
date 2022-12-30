public class AsyncFibraRuralElegibilidade implements Queueable, Database.AllowsCallouts {
    
    private String payload;
    private String email;
    private Id leadId;
    private Integer CODE_HTTP_SUCCESS = 200;
    
    public AsyncFibraRuralElegibilidade(String payload, String email, Id leadId){
        this.payload = payload;
        this.email = email;
        this.leadId = leadId;
    }
    
    public void execute(QueueableContext context) {
        
        Integer status = FibraRuralLeadElegibilidadeCallout.sendEmailAPI(payload);
        
        ContentNote newNote = new ContentNote();
        
        If(status == CODE_HTTP_SUCCESS){
            
            newNote.Title = 'Envio de e-mail automático';
            newNote.Content = blob.valueOf('Notificação de recebimento de formulário de interesse para contratação de Vivo Fibra Áreas Rurais solicitada para ' + email + ' realizado.');
            
        } else{
            
            newNote.Title = 'Falha envio de e-mail automático';
            newNote.Content = blob.valueOf('Notificação de recebimento de formulário de interesse para contratação de Vivo Fibra Áreas Rurais solicitada para ' + email + ' não realizado.');
            
        }
        
        insert newNote;
        ContentDocumentLink newNoteLink = new ContentDocumentLink();
        newNoteLink.ContentDocumentId = newNote.Id;
        newNoteLink.LinkedEntityId = leadId;
        newNoteLink.ShareType = 'V';
        insert newNoteLink;
        
    }
    
}