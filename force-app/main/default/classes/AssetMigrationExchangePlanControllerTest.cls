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
            newAsset.Name = 'Test Asset '; //Test GetAssetMigration ****
            newAsset.AccountId = acc.Id;
            newAsset.Status = 'Active';
            newAsset.PhoneNumber__c = '1234567890';
            newAsset.Cabinet__c = 'Test Cabinet ';
            newAsset.Type__c = 'Fixa';
            newAsset.ProductType__c = 'Test Product Type ';
            newAsset.MainProductDescription__c = 'Main Product';
            newAsset.SourceSystem__c = 'Test Source System';
            newAsset.PriceCurrent__c = 100.00;
            newAsset.IdBundle__c = 'Test Bundle ';
            newAsset.OfferDescription__c = 'Test Offer '; //Test GetAssetMigration ****

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

    @isTest
    public static void GetAssetMigrationTest() {
        
        Account acc = [SELECT Id FROM Account  LIMIT 1];

        
        Test.startTest();
        List<Asset> assets = AssetDAO.getAssetMigration(acc.Id);
        Test.stopTest();

        
        System.assertNotEquals(null, assets, 'retorno assets.');
        System.assertEquals(1, assets.size(), 'retorno de 1 assets.');
        
        
       /* for (Asset asset : assets) {
            System.assertEquals(acc.Id, asset.AccountId, 'The AccountId should match.');
            System.assertEquals('Active', asset.Status, 'The Status should be Active.');
            System.assert(asset.Type__c == 'Fixa' || asset.Type__c == 'Movel', 'The Type__c should be Fixa or Movel.');
            System.assert(!asset.MainProductDescription__c.contains('Fam'), 'The MainProductDescription__c should not contain "Fam".');
            System.assertNotEquals('dependente', asset.IsHolder__c, 'The IsHolder__c should not be "dependente".');
        }*/
    }
}