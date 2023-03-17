@isTest
public with sharing class AssetMigrationExchangePlanControllerTest {

    @TestSetup
    static void setup() {
        List<User> lstInsert = new List<User>();

        String profileId = [SELECT Id FROM Profile WHERE Name = 'Governanca'].Id;
        
        UserRole roleToInsert = new UserRole();
        roleToInsert.name = 'NaoExiste';
        roleToInsert.DeveloperName = 'NaoExiste';
        insert roleToInsert;
        
        User userWithRoleNaoExiste = DataFactory.createUser(profileId, roleToInsert.Id);
        insert userWithRoleNaoExiste;
		
        CanvasHybrisMigration__mdt chmWithoutAccess = [SELECT id, OriginApiName__c, HasAccessToHybrisMigration__c, UserLicense__c FROM CanvasHybrisMigration__mdt WHERE HasAccessToHybrisMigration__c = false LIMIT  1];
        UserRole role = [SELECT id FROM userRole WHERE DeveloperName   ='Anatel'];

        User user = DataFactory.createUser(profileId, role.Id);
        user.FirstName = 'NoAccessUser';
        lstInsert.add(user);
        
        CanvasHybrisMigration__mdt chmWithSalesforceAccess = [SELECT id, OriginApiName__c, HasAccessToHybrisMigration__c, UserLicense__c FROM CanvasHybrisMigration__mdt WHERE HasAccessToHybrisMigration__c = true and UserLicense__c = 'Salesforce' LIMIT  1];
        UserRole roleWithSalesforceAccess = [SELECT id FROM userRole WHERE DeveloperName  ='TelefonicaBrasil'];

        User userWithSalesforceAccess = DataFactory.createUser(profileId, roleWithSalesforceAccess.Id);
        userWithSalesforceAccess.FirstName = 'WithSalesforceAccessUser';
        lstInsert.add(userWithSalesforceAccess);
        
        CanvasHybrisMigration__mdt chmWithPartnerAccess = [SELECT id, OriginApiName__c, HasAccessToHybrisMigration__c, UserLicense__c FROM CanvasHybrisMigration__mdt WHERE HasAccessToHybrisMigration__c = true and UserLicense__c = 'Partner Community' LIMIT  1];
        Profile communityProfile = [SELECT id FROM Profile WHERE Name = 'AliadoExterno'];
        
        String profileAdminId = [SELECT Id FROM Profile WHERE Name = 'Administrador do sistema'].Id;
		User userAdmin = DataFactory.createUser(profileAdminId, roleWithSalesforceAccess.Id);
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
        
        insert lstInsert;
    }

    @isTest
    public static void showOffer() {
        Test.startTest();
            Id userId = [SELECT Id FROM User WHERE FirstName = 'WithSalesforceAccessUser' LIMIT 1].Id;
            
            Boolean isCanvasHybrisCheck = AssetMigrationExchangePlanController.showOffer(userId);
        Test.stopTest();

        System.assertEquals(true, isCanvasHybrisCheck, 'Ocorreu um erro.');
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
            Id userId = [SELECT Id FROM User WHERE UserRole.DeveloperName = 'NaoExiste' LIMIT 1].Id;

            Boolean isCanvasHybrisCheck = AssetMigrationExchangePlanController.showOffer(userId);
        Test.stopTest();

        System.assertEquals(false, isCanvasHybrisCheck, 'Usuário tem acesso a troca de ofertas.');
    }

    @isTest
    public static void showOfferPartner() {
        Test.startTest();
        User userId = [SELECT Id, profile.userlicense.name FROM User WHERE FirstName = 'userPartner' LIMIT 1];
		
        Boolean isCanvasHybrisCheck = AssetMigrationExchangePlanController.showOffer(userId.id);
        Test.stopTest();

        System.assertEquals(true, isCanvasHybrisCheck, 'Usuário sem acesso a troca de ofertas.');

    }
}