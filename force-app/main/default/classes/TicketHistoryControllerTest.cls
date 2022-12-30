@isTest
public class TicketHistoryControllerTest {
    
    @testSetup 
    static void setup(){

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
            Name = 'FourthPlataformTicketServiceCallout',
            Validate__c = 3600,
            Endpoint__c  = 'https://hmlapi.telefonicabigdata.com',
            SubscriptionKey__c = 'd1ca8d57a2984db88f01c9ce7b5862e2',
            switchedOn__c = true
        );
        
        WebServiceTestFactory.start().authOAuthProvider().create();
    }

    @isTest
    public static void getTicketHistoryFalse(){
        Account lAccount = [ SELECT Id FROM Account LIMIT 1];

        Boolean hasRecord = TicketHistoryController.getTicketHistory(lAccount.Id);
        Ticket__c ticketHistory = DataFactory.createTicketHistory(lAccount.Id);
        insert ticketHistory;

        hasrecord = TicketHistoryController.getTicketHistory(lAccount.Id);

        System.assertEquals(false, hasRecord);
    }

    @isTest
    public static void getTicketHistoryTrue(){
        Account lAccount = [ SELECT Id FROM Account LIMIT 1];

        Boolean hasRecord = TicketHistoryController.getTicketHistory(lAccount.Id);
        System.assertEquals(true, hasRecord);
    }

    @isTest
    public static void createTicketHistory(){
        Account lAccount = [ SELECT Id FROM Account LIMIT 1];

        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new TicketCalloutMock());

        TicketHistoryController.createTicketHistory(lAccount.Id);
        Test.stopTest();
    }
}