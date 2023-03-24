/*
* @description Classe Controller do componente de PDF Fatura, buscando as informações de Fatura nos legados via Microserviço de TI
*/
public without sharing class InvoiceDownloadController {
    public static final String WEBSERVICE_NAME = 'FourthPlataformInvoiceCallout';

    @AuraEnabled
    public static void downloadInvoice(String invoiceId, Boolean secondaryDownload) {
        Webservice__c wsConfig = Webservice__c.getInstance(WEBSERVICE_NAME);        
     
        Invoice__c invoice = InvoiceDAO.getById(invoiceId);
     
        if (invoice == null) {
            return;
        }

        String endPoint;                

        if (secondaryDownload) {
           endPoint = invoice.SecondaryDownloadUrl__c;

        } else {
            endPoint = invoice.Downloadurl__c;
        }

        if (endPoint == null || String.isBlank(endPoint)) {
            return;
        }

        HttpClient client = new HttpClient();
        HttpResponse response = client.get(wsConfig, endPoint);

        ServiceResponse invoiceResponse = new ServiceResponse();     
        
        invoiceResponse.success = (response.getStatusCode() / 100 == 2);
        
        if (invoiceResponse.success) {
            Blob beforeBlob = response.getBodyAsBlob();

            try {
                attachFilles(
                    invoiceId,
                    'Fatura ' + (secondaryDownload ? 'Contestada ' : '') + invoice.Name,
                    '.pdf',
                    beforeBlob
                );

            } catch(Exception e) {
                throw new AuraHandledException(JSON.serialize(invoiceResponse));
            }
        }
    }

	private static void attachFilles(String invoiceId, string fileName, String extension, Blob beforeBlob) {       
        ContentDocumentLink fileLink = new ContentDocumentLink();

        if (UserInfo.getUserType() == 'Standard') {
            fileLink = ContentDocumentLinkDAO.getByInvoiceIdTitle(invoiceId, fileName);
		
		} else {
			fileLink = ContentDocumentLinkDAO.getByInvoiceIdTitleUserId(invoiceId, fileName, UserInfo.getUserId());
        }

        ContentVersion attach = new ContentVersion();

        attach.Title = fileName;
        attach.PathOnClient = extension;
        attach.VersionData = beforeBlob;
        attach.IsMajorVersion = true;

        if (fileLink != null && fileLink.ContentDocumentId != null) {
            attach.ContentDocumentId = fileLink.ContentDocumentId;
        }           

        //Insere a lista de content version 

        Database.SaveResult lstSr = Database.insert(attach, false);
        
        if (lstSr.isSuccess()) {
            attach = ContentVersionDAO.getById(attach.Id);     

            if (fileLink == null || fileLink.ContentDocumentId == null) {
                if (fileLink == null) {
                    fileLink = new ContentDocumentLink();
                }

                fileLink.ContentDocumentId = attach.ContentDocumentId;
                fileLink.LinkedEntityId = invoiceId;
                fileLink.ShareType = 'V';

                insert fileLink;
            }
        }
    }
}