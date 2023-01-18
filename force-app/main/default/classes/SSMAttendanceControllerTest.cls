@IsTest
public with sharing class SSMAttendanceControllerTest {
    private static final String TEST_PHONE_NUMBER = '81988887777';
    private static final String TEST_CNPJ_CPF_NUMBER = '11122233344';

    @TestSetup
    public static void setup() {
        Account accountTest1 = new Account(
            //RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('RetencaoConvergente').getRecordTypeId(),
            Name = 'Account Test #1',
            DocumentNumber__c = '09845643278'            
        );

        Database.insert(accountTest1);

        Account accountTest2 = new Account(
            //RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('RetencaoConvergente').getRecordTypeId(),
            Name = 'Account Test #2',
            DocumentNumber__c = TEST_CNPJ_CPF_NUMBER
        );
        
        Database.insert(accountTest2);

        Asset assetTest = new Asset(
            AccountId = accountTest1.Id,
            Name = TEST_PHONE_NUMBER
        );

        Database.insert(assetTest);

        GenericOptionsLists__c newCustomerSegmentTest = new GenericOptionsLists__c();

        newCustomerSegmentTest.Name = 'PLATINUM';
        newCustomerSegmentTest.Code__c = 'PLATINUM';
        newCustomerSegmentTest.Description__c = 'PREMIUM';
        newCustomerSegmentTest.Description2__c = '1';
        newCustomerSegmentTest.APIName__c = 'CustomerSegment';
        newCustomerSegmentTest.APIDateTime__c = Date.today();
        newCustomerSegmentTest.UsedIn__c = 'CustomerSegment';
        newCustomerSegmentTest.Active__c = true;

        Database.insert(newCustomerSegmentTest);
    }

    @IsTest
    public static void getAccountByPhoneNumberTest() {
        Test.startTest();
            Map<String, Object> mapTest1 = SSMAttendanceController.getAccount(TEST_PHONE_NUMBER, '');
        Test.stopTest();

        System.assertNotEquals(null, mapTest1.get('success'));
    }

    @IsTest
    public static void getAccountByDocumentNumberTest() {
        Test.startTest();
            Map<String, Object> mapTest2 = SSMAttendanceController.getAccount('', TEST_CNPJ_CPF_NUMBER);
        Test.stopTest();

        System.assertNotEquals(null, mapTest2.get('success'));
    }

    @IsTest
    public static void getAccountErrorNotFoundTest() {
        Test.startTest();
            Map<String, Object> mapTest = SSMAttendanceController.getAccount(TEST_CNPJ_CPF_NUMBER, TEST_PHONE_NUMBER);
        Test.stopTest();
        
        System.assertEquals('Not found.', mapTest.get('error'));
    }

    @IsTest
    public static void getAccountCustomerSegmentGSSTest() {
        String CUSTOMER_SEGMENT_PLATINUM_IN = 'PLATINUM';
        String CUSTOMER_SEGMENT_PLATINUM_OUT = '1';
        String CUSTOMER_SEGMENT_NONE_IN = NULL;
        String CUSTOMER_SEGMENT_NONE_OUT = '3';

        StoreServiceManagerTO.ItemPicklistValue segmentPLATINUM = SSMAttendanceController.getAccountCustomerSegmentGSS(
            CUSTOMER_SEGMENT_PLATINUM_IN
        );

        StoreServiceManagerTO.ItemPicklistValue segmentNONE = SSMAttendanceController.getAccountCustomerSegmentGSS(
            CUSTOMER_SEGMENT_NONE_IN
        );
        
        System.assertEquals(CUSTOMER_SEGMENT_PLATINUM_OUT, segmentPLATINUM.value);
        System.assertEquals(CUSTOMER_SEGMENT_NONE_OUT, segmentNONE.value);
    }
    
    @IsTest
    public static void isPartnerCommunityLicenseTest() {
        Boolean test = SSMAttendanceController.isPartnerCommunityLicense();
    
        System.assertEquals(false, test);
    }
}