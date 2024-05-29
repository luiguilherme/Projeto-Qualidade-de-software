@isTest
private class UpdatePrimaryContactBatchTest {
    
    @TestSetup
    static void makeData(){

        Account acc = new Account(Name='Account Test');
        insert acc;

        Contact con = new Contact(FirstName='Contact', LastName='Test', 
                                  AccountId=acc.Id,
                                  Email='contact.test@test1.com');
        insert con;

        GeneralParam__c setting = new GeneralParam__c();
        setting.UpdatedPrimaryContactLimit__c = 100;
        setting.UpdatedPrimaryContactDays__c = 10;
        insert setting;
        
    }

    @isTest
    static void updatePrimaryContactTest() {
        Test.startTest();
        Database.executeBatch(new UpdatePrimaryContactBatch());
        System.Schedule('Atualizar contato principal2', '0 0 3 ? * 1,2,3,4,5,6,7', new UpdatePrimaryContactBatch());
        Test.stopTest();
        System.assertNotEquals([SELECT vlocity_cmt__PrimaryContactId__c FROM Account LIMIT 1], null);
    }


}