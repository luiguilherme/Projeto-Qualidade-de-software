/*
* @authors - Diego Costa @Deloitte   
* @date - 07/06/2022
* @description - Classe de teste da Controller InvoiceHistoryController
*/
@isTest
public class InvoiceHistoryControllerTest {
    
    @testSetup 
    static void setup(){
        
        string type = 'Fixa';

        Account lAccount = DataFactory.createAccount();
        insert lAccount;        
        
        Asset lAsset = DataFactory.createAsset(lAccount.Id, type );
        insert lAsset;
        
        vlocity_cmt__CustomerInteraction__c customerInteraction = DataFactory.createCustomerInteraction(lAccount.Id);
        insert customerInteraction;
        
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
            SearchRangeInvoice__c = 1800,
            TotalNumberRecords__c = 100,
            ServiceHistoryExpiration__c = 0
        );

        insert new Webservice__c(
            Name = 'FourthPlataformInvoiceCallout',
            Validate__c = 1800,
            Endpoint__c  = 'https://hmlapi.telefonicabigdata.com',
            SubscriptionKey__c = 'd1ca8d57a2984db88f01c9ce7b5862e2'
        );
        
        WebServiceTestFactory.start().authOAuthProvider().create();
    }

    @isTest
    public static void validateUserIdInformation() {
        Account ltAccount = [SELECT Id,UserId__c FROM Account LIMIT 1];
        
        ltAccount.UserId__c = 'userid';

        update ltAccount;
        
        vlocity_cmt__CustomerInteraction__c customerInteraction = [SELECT Id, vlocity_cmt__AccountId__c FROM vlocity_cmt__CustomerInteraction__c LIMIT 1];
        
        Boolean existUserId = InvoiceHistoryController.validateUserIdInformation(customerInteraction.Id);
        System.assertEquals(true, existUserId);
    }

    @isTest
    public static void getInvoiceHistory(){
        Account lAccount = [ SELECT Id,UserId__c FROM Account LIMIT 1];
        lAccount.UserId__c = 'userid';
        update lAccount;

        InvoiceHistoryController serviceController = new InvoiceHistoryController();
        Boolean hasRecord = InvoiceHistoryController.getInvoiceHistory(lAccount.Id);

        Invoice__c serviceHistory = DataFactory.createInvoiceHistory(lAccount.Id);
        insert serviceHistory;

        hasrecord = InvoiceHistoryController.getInvoiceHistory(lAccount.Id);

        System.assertEquals(true, hasRecord);


    }

    @isTest
    public static void createInvoiceHistory(){
        Account lAccount = [ SELECT Id,UserId__c FROM Account LIMIT 1];
		lAccount.UserId__c = 'userid';
        update lAccount;
        
        vlocity_cmt__CustomerInteraction__c customerInteraction = [SELECT Id, vlocity_cmt__AccountId__c FROM vlocity_cmt__CustomerInteraction__c LIMIT 1];
                
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new InvoiceCalloutMock());

        InvoiceHistoryController.createInvoiceHistory(customerInteraction.Id);
        Test.stopTest();
    }

    @isTest
    public static void createInvoiceHistoryWithInvalidStatusCode(){
        Account lAccount = [ SELECT Id,UserId__c FROM Account LIMIT 1];
		
        lAccount.UserId__c = 'userid';
        
        update lAccount;
        System.debug('Account: ' + lAccount);
        vlocity_cmt__CustomerInteraction__c customerInteraction = [SELECT Id, vlocity_cmt__AccountId__c FROM vlocity_cmt__CustomerInteraction__c LIMIT 1];
        
        System.debug('customerInteraction: ' + customerInteraction);
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new InvoiceCalloutMock(500));

        InvoiceHistoryController.createInvoiceHistory(customerInteraction.Id);        
        
        Test.stopTest();
    }
    
    @isTest
    public static void createInvoiceHistoryWebServiceWhenNull() {
        Webservice__c wsConfig = Webservice__c.getInstance('FourthPlataformInvoiceCallout');
        Account lAccount = [ SELECT Id,UserId__c FROM Account LIMIT 1];
		
        delete wsConfig;

        lAccount.UserId__c = 'userid';
        
        update lAccount;

        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new InvoiceCalloutMock());

        InvoiceHistoryController.createInvoiceHistory(lAccount.Id);
        
        Test.stopTest();
    }

    @isTest
    public static void getMessage(){
        Account lAccount = [ SELECT Id,UserId__c FROM Account LIMIT 1];
		lAccount.UserId__c = 'userid';
        update lAccount;

        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new InvoiceCalloutMock());

        InvoiceHistoryController.getMessage(lAccount.Id);
        Test.stopTest();
    }

    @isTest
    public static void getFormatedDate() {
        String dateToValidate = '2020-08-20T03:00:00Z';
        Date returnDate = Date.valueOf(dateToValidate.replaceAll('T',' '));

        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new InvoiceCalloutMock());

        Date validDate = InvoiceHistoryController.getFormatedDate(dateToValidate);
        Date invalidateDate = InvoiceHistoryController.getFormatedDate(null);

        Test.stopTest();

        System.assertEquals(returnDate, validDate);
        System.assertEquals(null, invalidateDate);
    }

    @isTest
    public static void getValidateTime() {
        Webservice__c ws = [SELECT Id, Name, Validate__c, Endpoint__c FROM Webservice__c LIMIT 1];

        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new InvoiceCalloutMock());

        Integer validValidate = InvoiceHistoryController.getValidateTime(ws);

        Test.stopTest();

        System.assertEquals(1800, validValidate);
    }
}