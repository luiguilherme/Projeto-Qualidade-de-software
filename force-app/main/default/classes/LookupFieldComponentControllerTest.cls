@isTest
public class LookupFieldComponentControllerTest {
    @TestSetup
    static void setup(){
        Account lAccount = DataFactory.createAccount();
        insert lAccount;
        System.debug(lAccount);
    }
    
    @isTest
    public static void lookupFieldTest(){
        Test.startTest();
        
        List<Account> lAccount = LookupFieldComponentController.fetchLookUpValues('Name', 'Account', 'Account', '["Id", "Name"]', 'Billing', '{"DocumentNumber__c": "11111111111111"}', 'DocumentNumber__c', '11111111111111', null, 'DocumentNumber__c IN (\'11111111111111\')', false);
        List<Account> lAccountTwo = LookupFieldComponentController.fetchLookUpValues('Name', 'Account', 'Account', '["Id"]', 'Billing', '{"DocumentNumber__c": "11111111111111"}', 'IsDeleted', null, 'false', null, true);
        System.assertNotEquals( lAccount, null, 'Account not found');
        System.assertNotEquals( lAccountTwo, null, 'Account not found');
        System.debug(lAccount);
        
        Test.stopTest();
    }
}