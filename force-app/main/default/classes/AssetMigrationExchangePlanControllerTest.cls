@isTest
public with sharing class AssetMigrationExchangePlanControllerTest {

    @TestSetup
    static void setup() {
        List<User> lstInsert = new List<User>();

        String profileId = [SELECT Id FROM Profile WHERE Name = 'Governanca'].Id;
        
        UserRole roleWithoutAccess = new UserRole();
        roleWithoutAccess.name = 'PapelSemAcesso';
        roleWithoutAccess.DeveloperName = 'PapelSemAcesso';
        insert roleWithoutAccess;
        
        User userPapelSemAcesso = DataFactory.createUser(profileId, roleWithoutAccess.Id);
        insert userPapelSemAcesso;
		
        CanvasHybrisMigration__mdt chmWithoutAccess = [SELECT id, OriginApiName__c, HasAccessToHybrisMigration__c, UserLicense__c FROM CanvasHybrisMigration__mdt WHERE HasAccessToHybrisMigration__c = false LIMIT  1];
        UserRole role = [SELECT id FROM userRole WHERE DeveloperName   ='PapelSemAcesso'];

        UserRole roleWithAccess = new UserRole();
        roleWithAccess.name = 'PapelComAcesso';
        roleWithAccess.DeveloperName = 'PapelComAcesso';
        insert roleWithAccess;
        
        CanvasHybrisMigration__mdt chmWithSalesforceAccess = [SELECT id, OriginApiName__c, HasAccessToHybrisMigration__c, UserLicense__c FROM CanvasHybrisMigration__mdt WHERE HasAccessToHybrisMigration__c = true and UserLicense__c = 'Salesforce' LIMIT  1];
        UserRole role = [SELECT id FROM userRole WHERE DeveloperName   ='PapelComAcesso'];

        User userWithSalesforceAccess = DataFactory.createUser(profileId, roleWithAccess.Id);
        userWithSalesforceAccess.FirstName = 'WithSalesforceAccessUser';
        lstInsert.add(userWithSalesforceAccess);

        User user = DataFactory.createUser(profileId, role.Id);
        user.FirstName = 'NoAccessUser';
        lstInsert.add(user);

        CanvasHybrisMigration__mdt chmWithPartnerAccess = [SELECT id, OriginApiName__c, HasAccessToHybrisMigration__c, UserLicense__c FROM CanvasHybrisMigration__mdt WHERE HasAccessToHybrisMigration__c = true and UserLicense__c = 'Partner Community' LIMIT  1];
        Profile communityProfile = [SELECT id FROM Profile WHERE Name = 'AliadoExterno'];
        
        String profileAdminId = [SELECT Id FROM Profile WHERE Name = 'Administrador do sistema' OR Name = 'System Administrator'].Id;
		User userAdmin = DataFactory.createUser(profileAdminId, roleWithAccess.Id);
        insert userAdmin;
        
        system.runAs(userAdmin){
            
            Account acc = DataFactory.createAccount();
            insert acc;
            
            Contact newContactPartner = DataFactory.createContact();
            newContactPartner.AccountId = acc.id;
            insert newContactPartner;
            
            
            User userPartner = DataFactory.createCommunityUser(communityProfile.id, 'VendasAliado', newContactPartner.Id);
            userPartner.FirstName = 'userPartner';
            insert userPartner;
        }
        
        User userWithPermissionSet = DataFactory.createUser(profileId, roleWithoutAccess.Id);
        userWithPermissionSet.FirstName = 'userWithPermissionSet';
        lstInsert.add(userWithPermissionSet);
        insert lstInsert;
        
        PermissionSet canvasPermissionSet = [select id, name from PermissionSet where name = 'CanvasHybrisMigrationE2E'];
        PermissionSetAssignment assignUserToPermission = new PermissionSetAssignment();
        assignUserToPermission.AssigneeId = userWithPermissionSet.Id;
        assignUserToPermission.PermissionSetId = canvasPermissionSet.Id;
        insert assignUserToPermission;
    }

    @isTest
    public static void showOffer() {
        Test.startTest();
            Id userId = [SELECT Id FROM User WHERE FirstName = 'WithSalesforceAccessUser' LIMIT 1].Id;
            
            Boolean isCanvasHybrisCheck = AssetMigrationExchangePlanController.showOffer(userId);
        Test.stopTest();

        System.assertEquals(true, isCanvasHybrisCheck, 'Usuário Salesforce sem acesso a troca de ofertas.');
    }

    @isTest
    public static void showOfferTestWithoutUser() {
        Test.startTest();
            User userTest = new User();

            Boolean isCanvasHybrisCheck = AssetMigrationExchangePlanController.showOffer(userTest.Id);
        Test.stopTest();

        System.assertEquals(false, isCanvasHybrisCheck, 'Usuário encontrado');
    }

    @isTest
    public static void showOfferTestWithoutRole() {
        Test.startTest();
            Id userId = [SELECT Id FROM User WHERE UserRole.DeveloperName = 'PapelSemAcesso' LIMIT 1].Id;

            Boolean isCanvasHybrisCheck = AssetMigrationExchangePlanController.showOffer(userId);
        Test.stopTest();

        System.assertEquals(false, isCanvasHybrisCheck, 'O papel do usuário permite acesso a troca de ofertas.');
    }

    @isTest
    public static void showOfferPartner() {
        Test.startTest();
        User userId = [SELECT Id, profile.userlicense.name FROM User WHERE FirstName = 'userPartner' LIMIT 1];
		
        Boolean isCanvasHybrisCheck = AssetMigrationExchangePlanController.showOffer(userId.id);
        Test.stopTest();

        System.assertEquals(true, isCanvasHybrisCheck, 'Usuário Parceiro sem acesso a troca de ofertas.');

    }
    
    @isTest
    public static void showOfferToUserWithPermissionSet() {
        Test.startTest();
        	User userId = [SELECT Id, profile.userlicense.name FROM User WHERE FirstName = 'userWithPermissionSet' LIMIT 1];
		
        	Boolean isCanvasHybrisCheck = AssetMigrationExchangePlanController.showOffer(userId.id);
        Test.stopTest();

        System.assertEquals(true, isCanvasHybrisCheck, 'Usuário sem acesso a troca de ofertas');

    }
}