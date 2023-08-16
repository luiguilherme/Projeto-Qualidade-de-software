@isTest
public with sharing class SyncOrderWithHybrisButtonControllerTest {
    private static final Map<String,String> CONST_MAPHEADER = new Map<String,String>{'Content-Type' => 'application/json'};
    private static final String CONST_BODYSUCCESS ='{"crmPurchaseOrderNumber":"1107981096A","orderCode":"PE-00999999","products":[{"price":99.99,"productCode":"105310932","productDescription":"VIVO SELFIE BASICO 10GB"},{"price":0,"productCode":"YGSC244U3000","productDescription":"SIM CARD 4G P44 HRS 2/3/4FF UNID OLHAL"}],"status":"PURCHASE_STATEMENT","userId":"55773532034","vendorId":"80708782"}';
    private static final String CONST_BODYERROR = '';

    @TestSetup
    public static void setup(){
        Account acc = DataFactory.createAccount();
        insert acc;
        
        insert new OrderIssued__c(
            AccountId__c = acc.Id,
            HybrisOrder__c = 'PE-00999999',
            AmdocsOrder__c = '123456',
            Status__c = 'CHECKED_VALID'
        );

        insert new Webservice__c(
            Name = 'OrderHybrisCallout',
            Endpoint__c  = 'https://hmlapi.telefonicabigdata.com',
            SubscriptionKey__c = 'd1ca8d57a2984db88f01c9ce7b5862e2'
        );
    }
    @isTest
    public static void syncOrderStatusWithHybrisTest() {
        Test.startTest();
        OrderHybrisCalloutMock getRequest = new OrderHybrisCalloutMock(200, CONST_BODYSUCCESS, CONST_MAPHEADER);
        Test.setMock(HttpCalloutMock.class, getRequest);

        OrderIssued__c orderIssuedToAssert = [SELECT Id FROM OrderIssued__c WHERE HybrisOrder__c ='PE-00999999' limit 1];

        SyncOrderWithHybrisButtonController.syncHybrisOrderStatus(orderIssuedToAssert.Id);
        OrderIssued__c orderIssuedUpdated = [SELECT Status__c FROM OrderIssued__c WHERE HybrisOrder__c ='PE-00999999' limit 1];

        Test.stopTest();
        System.assertEquals('PURCHASE_STATEMENT', orderIssuedUpdated.Status__c, 'Status não foi atualizado como deveria.' );
    }

    @IsTest
    static void syncOrderStatusWithHybrisExceptionTest(){
        Test.startTest();
        OrderHybrisCalloutMock getRequest = new OrderHybrisCalloutMock(200, CONST_BODYERROR, CONST_MAPHEADER);
        Test.setMock(HttpCalloutMock.class, getRequest);

        OrderIssued__c orderIssuedToAssert = [SELECT Id FROM OrderIssued__c WHERE HybrisOrder__c ='PE-00999999' limit 1];

        Boolean isException = false;

        try {
            SyncOrderWithHybrisButtonController.syncHybrisOrderStatus(orderIssuedToAssert.Id);
            OrderIssued__c orderIssuedUpdated = [SELECT Status__c FROM OrderIssued__c WHERE HybrisOrder__c ='PE-00999999' limit 1];
        } catch (Exception e) {
            isException = true;
        }

        Test.stopTest();
        System.assertEquals(true, isException, 'O erro aconteceu como esperado.' );
    }
}