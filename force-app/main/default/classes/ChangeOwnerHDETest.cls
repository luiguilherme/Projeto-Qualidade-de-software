@isTest
public inherited sharing class ChangeOwnerHDETest {
    
    @testSetup 
    static void setup() {
       	Account account1 = DataFactory.createAccount();
        insert account1;
        
        Case case1 = new Case();
        case1.Origin = 'Ura';
        case1.Subject = 'TestCase';
        case1.Segment__c = 'Platinum';
        case1.AccountId = account1.Id;
        insert case1;
       
    }
    
    public static testMethod void getUserByRoleTest() {
        Id caseId = [SELECT Id FROM Case WHERE Subject = 'TestCase'].Id;
        
        String profileId = [SELECT Id FROM Profile WHERE Name = 'Representante'].Id;

        String userRoleId = [SELECT Id FROM UserRole WHERE DeveloperName = 'PlatinumMovel'].Id;
         
        User user1 = DataFactory.createUser(profileId, userRoleId);      
        insert user1;
        
        Test.startTest();
        
        List<User> userList =  ChangeOwnerHDEController.getUserByRole(caseId);
        System.assert(userList.size() > 0);
        
        Test.stopTest();
    }
}