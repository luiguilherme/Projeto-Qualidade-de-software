@isTest
public with sharing class AssetMigrationExchangePlanControllerTest {

    @TestSetup
    static void setup() {
        String profileId = [SELECT Id FROM Profile WHERE Name = 'Governanca'].Id;

        CanvasHybrisMigration__mdt chmHasNoAccess = [SELECT id, OriginApiName__c, HasAccessToHybrisMigration__c, UserLicense__c FROM CanvasHybrisMigration__mdt WHERE HasAccessToHybrisMigration__c = false LIMIT  1];
        UserRole role = [SELECT id FROM userRole WHERE DeveloperName   ='Anatel'];
                 
        User user = DataFactory.createUser(profileId, role.Id);
        user.FirstName = 'NoAccessUser';
        insert user;
        
        CanvasHybrisMigration__mdt chmHasWithAccessSalesforce = [SELECT id, OriginApiName__c, HasAccessToHybrisMigration__c, UserLicense__c FROM CanvasHybrisMigration__mdt WHERE HasAccessToHybrisMigration__c = true and UserLicense__c = 'Salesforce' LIMIT  1];
        UserRole roleWithAccessSalesforce = [SELECT id FROM userRole WHERE DeveloperName  ='TelefonicaBrasil'];
                 
        User userWithAccessSalesforce = DataFactory.createUser(profileId, roleWithAccessSalesforce.Id);
        userWithAccessSalesforce.FirstName = 'WithAccessUserSalesforce';
        insert userWithAccessSalesforce;
        
        CanvasHybrisMigration__mdt chmHasWithAccessPartner = [SELECT id, OriginApiName__c, HasAccessToHybrisMigration__c, UserLicense__c FROM CanvasHybrisMigration__mdt WHERE HasAccessToHybrisMigration__c = true and UserLicense__c = 'Partner Community' LIMIT  1];
        Profile communityProfile = [SELECT id FROM Profile WHERE Name = 'AliadoExterno'];
        
        Contact newContactPartner = DataFactory.createContact();
        insert newContactPartner;
        User userPartner = DataFactory.createCommunityUser(communityProfile.id, 'VendasAliado', newContactPartner.Id);
        userPartner.FirstName = 'userPartner';
        insert userPartner;
    }

    @isTest
    public static void showOffer() {
        Test.startTest();
            Id userId = [SELECT Id FROM User WHERE FirstName = 'WithAccessUserSalesforce' LIMIT 1].Id;
            
            Boolean isCanvasHybrisCheck = AssetMigrationExchangePlanController.showOffer(userId);
        Test.stopTest();

        System.assertNotEquals(true, isCanvasHybrisCheck, 'Ocorreu um erro.');
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
            Id userId = [SELECT Id FROM User WHERE UserRole.DeveloperName = 'Anatel' LIMIT 1].Id;

            Boolean isCanvasHybrisCheck = AssetMigrationExchangePlanController.showOffer(userId);
        Test.stopTest();

        System.assertEquals(false, isCanvasHybrisCheck, 'Usuário tem acesso a troca de ofertas.');
    }

    @isTest
    public static void showOfferPartner() {
        Test.startTest();
        User userId = [SELECT Id, profile.userlicense.name FROM User WHERE FirstName = 'userPartner' LIMIT 1];
		
        System.debug('Passei aqui ' + userId);
        Boolean isCanvasHybrisCheck = AssetMigrationExchangePlanController.showOffer(userId.id);
        Test.stopTest();

        System.assertEquals(true, isCanvasHybrisCheck, 'Usuário sem acesso a troca de ofertas.');

    }
}