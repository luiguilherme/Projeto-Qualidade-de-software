@IsTest
public class UserProfileControllerTest {

    @testSetup 
    static void setup(){

        Account lAccount = DataFactory.createAccount();
        insert lAccount;

        vlocity_cmt__CustomerInteraction__c customer = DataFactory.createCustomerInteraction(lAccount.Id);
        insert customer;
        
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
            Name = 'FourthPlataformUserProfileCallout',
            Endpoint__c  = 'https://hmlapi.telefonicabigdata.com',
            SubscriptionKey__c = 'd1ca8d57a2984db88f01c9ce7b5862e2'
        );
        
        WebServiceTestFactory.start().authOAuthProvider().create();
    }

    @isTest
    public static void getUserIdTest(){
        vlocity_cmt__CustomerInteraction__c customer = [ SELECT Id FROM vlocity_cmt__CustomerInteraction__c LIMIT 1];

        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new UserProfileCalloutMock());

        UserProfileController userProfile = new UserProfileController();
        String userId = UserProfileController.getUserId(customer.Id);
        Test.stopTest();
        
        system.debug('USERID ' + userId);

        System.assertNotEquals(null, userId);

    }

    @isTest
    public static void getUserIdTest2(){
        Account lAccount = [ SELECT Id, UserId__c FROM Account LIMIT 1];
        lAccount.UserId__c = 'userid';
        update lAccount;

        vlocity_cmt__CustomerInteraction__c customer = [ SELECT Id FROM vlocity_cmt__CustomerInteraction__c LIMIT 1];

        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new UserProfileCalloutMock());

        UserProfileController userProfile = new UserProfileController();
        Id userId = UserProfileController.getUserId(customer.Id);
        Test.stopTest();

        System.assertEquals(null, userId);

    }
}