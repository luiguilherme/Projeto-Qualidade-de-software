@isTest
public class InvoiceDownloadControllerTest {
    
    @testSetup 
    static void setup() {
        Account lAccount = DataFactory.createAccount();

        insert lAccount;
        
        insert new GeneralParam__c(
            AccountLoadDate__c  = Datetime.now().addDays(-1),
            AssetLoadDate__c = Datetime.now().addDays(-1),
            BillingAccountLoadDate__c = Datetime.now().addDays(-1),
            InvoiceLoadDate__c = Datetime.now().addDays(-1),
            AddressLoadDate__c = Datetime.now().addDays(-1),
            AssetJob__c = true,
            BillingAccountJob__c = true,
            AccountJob__c = true,
            AddressJob__c = true,
            InvoiceJob__c = true,
            SearchRange__c = 90,
            TotalNumberRecords__c = 100,
            ServiceHistoryExpiration__c = 0
        );

        insert new Webservice__c(
            Name = 'FourthPlataformInvoiceCallout',
            Endpoint__c  = 'https://hmlapi.telefonicabigdata.com',
            SubscriptionKey__c = 'd1ca8d57a2984db88f01c9ce7b5862e2'
        );
        
        WebServiceTestFactory.start().authOAuthProvider().create();
    }

    @isTest
    public static void downloadInvoice() {
        Account lAccount = [SELECT Id FROM Account LIMIT 1];
        
		Invoice__c invoiceHistory = DataFactory.createInvoiceHistory(lAccount.Id);
        
        insert invoiceHistory;
        
        String body = 'JVBERi0xLjQKJdPr6eEKMSAwIG9iago8PC9DcmVhdG9yIChNb3ppbGxhLzUuMCBcKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NFwpIEFwcGxl';
        
        Attachment attach = DataFactory.createAttachment(invoiceHistory.Id,body);
        
        insert attach;
       
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new InvoiceDownloadMock());

        InvoiceDownloadController.downloadInvoice(invoiceHistory.Id, false);
        Test.stopTest();
    }

    @isTest
    public static void secondaryDownloadInvoice(){
        Account lAccount = [SELECT Id FROM Account LIMIT 1];

		Invoice__c invoiceHistory = DataFactory.createInvoiceHistory(lAccount.Id);
        
        insert invoiceHistory;

        String body = 'JVBERi0xLjQKJdPr6eEKMSAwIG9iago8PC9DcmVhdG9yIChNb3ppbGxhLzUuMCBcKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NFwpIEFwcGxl';
        
        Attachment attach = DataFactory.createAttachment(invoiceHistory.Id, body);

        insert attach;
       
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new InvoiceDownloadMock());
        
        InvoiceDownloadController.downloadInvoice(invoiceHistory.Id, true);
        Test.stopTest();
    }
}