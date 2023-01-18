@IsTest
public class ServiceHistoryControllerTest {

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
            Name = 'FourthPlataformServiceHistoryCallout',
            Endpoint__c  = 'https://hmlapi.telefonicabigdata.com',
            SubscriptionKey__c = 'd1ca8d57a2984db88f01c9ce7b5862e2'
        );
        
        WebServiceTestFactory.start().authOAuthProvider().create();
    }

    @isTest
    public static void getServiceHistory(){
        Account lAccount = [ SELECT Id FROM Account LIMIT 1];

        ServiceHistoryController serviceController = new ServiceHistoryController();
        Boolean hasRecord = ServiceHistoryController.getServiceHistory(lAccount.Id);

        ServiceHistory__c serviceHistory = DataFactory.createServiceHistory(lAccount.Id);
        insert serviceHistory;

        hasrecord = ServiceHistoryController.getServiceHistory(lAccount.Id);

        System.assertEquals(true, hasRecord);


    }

    @isTest
    public static void createServiceHistory(){
        Account lAccount = [ SELECT Id FROM Account LIMIT 1];

        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new ServiceCalloutMock());

        ServiceHistoryController.createServiceHistory(lAccount.Id);
        Test.stopTest();
    }

}