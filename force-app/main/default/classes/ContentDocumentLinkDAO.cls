/** 
 * @author Diego Costa @ Deloitte
 * @date 15/06/2022
 * @description Controla a busca e criação do ContentDocumentLink
 */
public with sharing class ContentDocumentLinkDAO {
    public static ContentDocumentLink getByInvoiceIdTitle(Id invoiceId, String title) {
        List<ContentDocumentLink> ltContentDocumentLink = getByInvoiceIdTitle(
			new Set<Id>{invoiceId}, 
			new Set<String>{title}
		);

        return (ltContentDocumentLink.IsEmpty() ? null : ltContentDocumentLink[0]);
    }

    public static List<ContentDocumentLink> getByInvoiceIdTitle(Set<Id> invoiceId, Set<String> title) {
        return [
            SELECT 
                Id, 
                ContentDocumentId,
                ContentDocument.Title, 
                Visibility 
            FROM 
                ContentDocumentLink 
            WHERE 
                LinkedEntityId = :invoiceId AND 
                ContentDocument.Title = :title
        ];
    }

    public static ContentDocumentLink getByInvoiceIdTitleUserId(Id invoiceId, String title, Id userId) {
        List<ContentDocumentLink> ltContentDocumentLink = getByInvoiceIdTitleUserId(
			new Set<Id> {invoiceId},
			new Set<String>{title}, 
			new Set<Id>{userId}
		);

        return (ltContentDocumentLink.IsEmpty() ? null : ltContentDocumentLink[0]);
    }

    public static List<ContentDocumentLink> getByInvoiceIdTitleUserId(Set<Id> invoiceId, Set<String> title, Set<Id> userId) {
        return [
            SELECT 
                Id, 
                ContentDocumentId,
                ContentDocument.Title, 
                Visibility 
            FROM 
                ContentDocumentLink 
            WHERE 
                LinkedEntityId = :invoiceId AND 
                ContentDocument.Title = :title AND 
				ContentDocument.CreatedById = :userId
        ];
    }
}