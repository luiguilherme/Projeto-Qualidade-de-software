@isTest
public with sharing class AssetMigrationExchangePlanControllerTest {

    @TestSetup
    static void setup() {
        // #region setupShowOffer
                
        List<User> lstInsert = new List<User>();

        String profileId = [SELECT Id FROM Profile WHERE Name = 'Governanca'].Id;
        
        UserRole roleToInsert = new UserRole();
        roleToInsert.name = 'PapelSemAcesso';
        roleToInsert.DeveloperName = 'PapelSemAcesso';
        insert roleToInsert;
        
        User userPapelSemAcesso = DataFactory.createUser(profileId, roleToInsert.Id);
        insert userPapelSemAcesso;
    
        CanvasHybrisMigration__mdt chmWithoutAccess = [SELECT id, OriginApiName__c, HasAccessToHybrisMigration__c, UserLicense__c FROM CanvasHybrisMigration__mdt WHERE HasAccessToHybrisMigration__c = false LIMIT  1];
        UserRole role = [SELECT id FROM userRole WHERE DeveloperName   ='PapelSemAcesso'];

        UserRole roleWithAccess = new UserRole();
        roleWithAccess.name = 'PapelComAcesso';
        roleWithAccess.DeveloperName = 'PapelComAcesso';
        insert roleWithAccess;
        
        CanvasHybrisMigration__mdt chmWithSalesforceAccess = [SELECT id, OriginApiName__c, HasAccessToHybrisMigration__c, UserLicense__c FROM CanvasHybrisMigration__mdt WHERE HasAccessToHybrisMigration__c = true and UserLicense__c = 'Salesforce' LIMIT  1];

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
        
        User userPartner = new User();
        Account acc = new Account();
        system.runAs(userAdmin){
            
            acc = DataFactory.createAccount();
            insert acc;
            
            Contact newContactPartner = DataFactory.createContact();
            newContactPartner.AccountId = acc.id;
            insert newContactPartner;
            
            Asset newAsset = DataFactory.createAsset(acc.id, 'Movel');
            newAsset.Status = 'Active';
            newAsset.MainProductDescription__c  = 'Pós-Controle';
            insert newAsset;
            
            userPartner = DataFactory.createCommunityUser(communityProfile.id, 'VendasAliado', newContactPartner.Id);
            userPartner.FirstName = 'userPartner';
            insert userPartner;

            vlocity_cmt__CustomerInteraction__c newCustomerInteraction = DataFactory.createCustomerInteraction (acc.id);
            insert newCustomerInteraction;
        }
        
        system.runAs(userPartner){
            vlocity_cmt__CustomerInteraction__c newCustomerInteraction = DataFactory.createCustomerInteraction (acc.id);
            insert newCustomerInteraction;
        }
        
        User userWithPermissionSet = DataFactory.createUser(profileId, roleToInsert.Id);
        userWithPermissionSet.FirstName = 'userWithPermissionSet';
        lstInsert.add(userWithPermissionSet);
        insert lstInsert;
        
        PermissionSet canvasPermissionSet = [select id, name from PermissionSet where name = 'CanvasHybrisMigrationE2E'];
        PermissionSetAssignment assignUserToPermission = new PermissionSetAssignment();
        assignUserToPermission.AssigneeId = userWithPermissionSet.Id;
        assignUserToPermission.PermissionSetId = canvasPermissionSet.Id;
        insert assignUserToPermission;
        
    // #endregion
    // #region createCustomerInteractionTopic
    // #endregion
    }

    @isTest
    public static void showOffer() {
        createFeatFlag();
        
        Test.startTest();
            User userTest = [SELECT Id FROM User WHERE FirstName = 'WithSalesforceAccessUser' LIMIT 1];
            AssetMigrationDTO accessReturn = new AssetMigrationDTO();
        
            vlocity_cmt__CustomerInteraction__c cInteractionObj = [SELECT Id FROM vlocity_cmt__CustomerInteraction__c LIMIT 1];
            system.runAs(userTest){
                accessReturn = AssetMigrationExchangePlanController.checkAccessToComponent(cInteractionObj.Id);
                
            }
        Test.stopTest();

        System.assertEquals(true, accessReturn.userHaveAccess, 'Usuário Salesforce sem acesso a troca de ofertas.');
    }

    @isTest
    public static void showOfferTestWithoutUser() {
        createFeatFlag();

        Test.startTest();
            User userTest = [SELECT Id FROM User WHERE FirstName = 'WithSalesforceAccessUser' LIMIT 1];
            AssetMigrationDTO accessReturn = new AssetMigrationDTO();
        	
            vlocity_cmt__CustomerInteraction__c cInteractionObj = [SELECT Id FROM vlocity_cmt__CustomerInteraction__c LIMIT 1];
            system.runAs(userTest){
                accessReturn = AssetMigrationExchangePlanController.checkAccessToComponent(cInteractionObj.Id);
                
            }
        Test.stopTest();

        System.assertEquals(true, accessReturn.userHaveAccess, 'Usuário encontrado');
    }

    @isTest
    public static void showOfferTestWithoutRole() {
      createFeatFlag();

      Test.startTest();
            User userTest = [SELECT Id FROM User WHERE FirstName = 'WithSalesforceAccessUser' LIMIT 1];
            AssetMigrationDTO accessReturn = new AssetMigrationDTO();
        	
            vlocity_cmt__CustomerInteraction__c cInteractionObj = [SELECT Id FROM vlocity_cmt__CustomerInteraction__c LIMIT 1];
            system.runAs(userTest){
                accessReturn = AssetMigrationExchangePlanController.checkAccessToComponent(cInteractionObj.Id);
                
            }
        Test.stopTest();

        System.assertEquals(true, accessReturn.userHaveAccess, 'O papel do usuário permite acesso a troca de ofertas.');
    }

    @isTest
    public static void showOfferPartner() {
        createFeatFlag();

        Test.startTest();
            User userTest = [SELECT Id, profile.userlicense.name FROM User WHERE FirstName = 'userPartner' LIMIT 1];
            AssetMigrationDTO accessReturn = new AssetMigrationDTO();
        	
            system.runAs(userTest){
	            vlocity_cmt__CustomerInteraction__c cInteractionObj = [SELECT Id FROM vlocity_cmt__CustomerInteraction__c LIMIT 1];

                accessReturn = AssetMigrationExchangePlanController.checkAccessToComponent(cInteractionObj.Id);
                
            }
        Test.stopTest();

        System.assertEquals(true, accessReturn.userHaveAccess, 'Usuário Parceiro sem acesso a troca de ofertas.');

    }
    
    @isTest
    public static void showOfferToUserWithPermissionSet() {
       createFeatFlag();

       Test.startTest();
            User userTest = [SELECT Id FROM User WHERE FirstName = 'WithSalesforceAccessUser' LIMIT 1];
            AssetMigrationDTO accessReturn = new AssetMigrationDTO();
        	
            vlocity_cmt__CustomerInteraction__c cInteractionObj = [SELECT Id FROM vlocity_cmt__CustomerInteraction__c LIMIT 1];
            system.runAs(userTest){
                accessReturn = AssetMigrationExchangePlanController.checkAccessToComponent(cInteractionObj.Id);
                
            }
        Test.stopTest();

        System.assertEquals(true , accessReturn.userHaveAccess, 'Usuário sem acesso a troca de ofertas');

    }

    @isTest
    public static void createCustomerInteractionTopicTeste() {
        Test.startTest();
            vlocity_cmt__CustomerInteraction__c newCustomerInteractionTeste = [SELECT id, vlocity_cmt__AccountId__c from vlocity_cmt__CustomerInteraction__c limit 1];
            Asset selectedAsset = AssetDAO.getAssetMobileMigration(newCustomerInteractionTeste.vlocity_cmt__AccountId__c)[0];
        	Map <String, Object> returnMap = AssetMigrationExchangePlanController.createCustomerInteractionTopic(newCustomerInteractionTeste.id, selectedAsset.id);

        Test.stopTest();

        System.assert(returnMap.containsKey('success'), 'CustomerInteractionTopic não foi criada');
    }

    @isTest
    public static void createCustomerInteractionTopicFalse() {
        Test.startTest();
            vlocity_cmt__CustomerInteraction__c newCustomerInteractionTeste = [SELECT id from vlocity_cmt__CustomerInteraction__c limit 1];
            Map <String, Object> returnMap = AssetMigrationExchangePlanController.createCustomerInteractionTopic('xxxxxxxxxx', 'xxxxxxxxxx');

        Test.stopTest();

        System.assert(returnMap.containsKey('error'), 'CustomerInteractionTopic não foi criada');
    }
    
    public static void createFeatFlag() {
        FeatureFlag__c feat = new FeatureFlag__c();
        feat.Name = 'FluxoMigracaoCanvasHybris';
        feat.Active__c = true;
        feat.Application__c = 'FluxoMigracaoCanvasHybris';
        
        insert feat;
    }
}
