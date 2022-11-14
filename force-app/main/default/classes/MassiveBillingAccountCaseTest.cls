@isTest
public class MassiveBillingAccountCaseTest {
        
    @testSetup 
    static void setup(){
        Account lAccount = DataFactory.createAccount();
        
        insert lAccount;
        
        Account lBillingAccountFixed = DataFactory.createBillingAccount(lAccount.Id, 'Fixa');
        Account lBillingAccountMobile = DataFactory.createBillingAccount(lAccount.Id, 'Móvel');
        insert lBillingAccountFixed;
        insert lBillingAccountMobile;
        
        List<Asset> lstAsset = new List<Asset>();
        Asset asset = DataFactory.createAsset(lAccount.Id, 'Fixa');
        
        lstAsset.add(asset);
        lstAsset.add(DataFactory.createAsset(lAccount.Id, 'Móvel'));
        insert lstAsset;
        
        List<vlocity_cmt__CustomerInteraction__c> lstCustomerInteraction = new List<vlocity_cmt__CustomerInteraction__c>();        
        vlocity_cmt__CustomerInteraction__c customerInteractionFixa = DataFactory.createCustomerInteraction(lBillingAccountFixed.Id);
        vlocity_cmt__CustomerInteraction__c customerInteractionMovel = DataFactory.createCustomerInteraction(lBillingAccountMobile.Id);
        lstCustomerInteraction.add(customerInteractionFixa);
        lstCustomerInteraction.add(customerInteractionMovel);
		insert lstCustomerInteraction;        
        
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
            CustomerType__c = 'Totalizado;Fixa',
            CustomerSegment__c = 'TOP;VIP;PLATINUM'
        );        
    }    
    
    @isTest
    public static void getAccountRetentionFixedTest(){
        List<Account> lAccount = [SELECT Id FROM Account WHERE BillingAccountType__c = 'Fixa' LIMIT 1];	
        List<vlocity_cmt__CustomerInteraction__c> lCustomerInteraction = [SELECT Id FROM vlocity_cmt__CustomerInteraction__c WHERE vlocity_cmt__AccountId__c =: lAccount[0].Id];
        
        Test.startTest();        
        
            AccountRetentionTO.BillingAccount billingAccountObj = MassiveBillingAccountCaseController.getAccountRetentionFixed(lCustomerInteraction[0].Id);
            system.assert(billingAccountObj != null);
                
        Test.stopTest();
    }

    @isTest
    public static void getMassiveFixed(){
        Asset asset = [SELECT Id FROM Asset LIMIT 1];

        Map<String, Object> mapResponse = new Map<String, Object>();
        
        Test.startTest();
            Test.setMock(HttpCalloutMock.class, new MassiveFixedCaseMock());
            mapResponse = MassiveBillingAccountCaseController.getMassiveFixed(asset.Id);
            System.assertEquals(true, mapResponse.get('success'));
        Test.stopTest();
    }

    @isTest
    public static void getMassiveSuspicion(){
        Asset asset = [SELECT Id FROM Asset LIMIT 1];

        Map<String, Object> mapResponse = new Map<String, Object>();
        
        Test.startTest();
            Test.setMock(HttpCalloutMock.class, new MassiveSuspicionCaseMock());
            mapResponse = MassiveBillingAccountCaseController.getMassiveSuspicion(asset.Id);
            System.assertEquals(true, mapResponse.get('success'));
        Test.stopTest();
    }
}