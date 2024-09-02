/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 08-27-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
@isTest
public with sharing class ProductUserManagementTest {

    @TestSetup
    static void setupTestData() {
        Account testAccount = new Account(
            Name = 'Test Account', ExternalId__c = '7');
        insert testAccount;
        
        Contact testContact = new Contact(
            ExternalId__c = '7', FirstName = 'Test', LastName = 'Contact', ContactEmail__c = 'testcontact@example.com', AssistantPhone = '77', 
            Nickname__c = 'testnick', MotherName__c = 'testmother', Birthdate = System.today(), AccountId = testAccount.Id,                 
            RecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByDeveloperName().get('ConsumerContact').getRecordTypeId()
        );
        insert testContact;
        
        vlocity_cmt__Party__c testParty = new vlocity_cmt__Party__c(
            Id = testContact.vlocity_cmt__PartyId__c, vlocity_cmt__ContactId__c = testContact.Id);
        insert testParty;
        
        Asset testAsset = new Asset(
            ExternalId__c = '777',Name = 'Test Asset',AccountId = testAccount.Id, PhoneNumber__c = '11941857489');
        insert testAsset;
        
        AssetPartyRelationShip__c testAssetPartyRelation = new AssetPartyRelationShip__c(
            SourceParty__c = testParty.Id,TargetAsset__c = testAsset.Id,Name = '12345678901123456789',Role__c = 'Usuário',approvedByOwner__c = true
        );
        insert testAssetPartyRelation;
    }
    
    @IsTest
    static void testCreateContact() {
        Contact testContact = [SELECT Id, ExternalId__c FROM Contact WHERE ExternalId__c = '7' LIMIT 1];
        Set<String> nonExistentContactIds = new Set<String>{ testContact.ExternalId__c };
        
        JWTUtilityTest.setPublicTestKey();
        String jwt = JWTUtilityTest.createValidJWT();

        RestRequest req = new RestRequest();
        req.requestUri = '/services/apexrest/productUserManagement/v1/productUsers/';
        req.httpMethod = 'PATCH';
        req.addHeader('Content-Type', 'application/json');
        req.addHeader('x-Authorization', 'Bearer ' + jwt);
        req.requestBody = Blob.valueOf('{"contactRef": {"userCPF": "7", "firstName": "firstname4edit", "contactEmail": "teste4@gmail.com", "assistantPhone": "77", "nickName": "nicktest4", "motherName": "mothertes4"}, "assetPartyRelationshipRef": {"approvedByOwner": true, "product": "777", "role": "Usuario"}, "assetPartyRelationDelete": {"product": "", "isDeleteProduct": false}}');
        
        RestContext.request = req;
        RestContext.response = new RestResponse();

        Test.startTest();
        ProductUserManagement.patchProductUser();
        ProductUserManagement.responseError responsError= new ProductUserManagement.responseError();
        responsError.errorCode = '200';
        responsError.message = 'Sucess';
        Test.stopTest();

        Contact createdContacts = [SELECT Id, ExternalId__c FROM Contact WHERE ExternalId__c IN :nonExistentContactIds];
        System.assertNotEquals(null, createdContacts, 'O contato deveria ser encontrado.');
        System.assertEquals('7', createdContacts.ExternalId__c, 'O ExternalId deveria ser igual.');
    }
    
        @isTest
        static void testUpdateContactFields() {
            Test.startTest();
            JWTUtilityTest.setPublicTestKey();
            String jwt = JWTUtilityTest.createValidJWT();
            
            Set<String> existingContactIds = new Set<String>{'123456789'};
            
            GetProductUserResponseWrapper.ContactRef contactRef = new GetProductUserResponseWrapper.ContactRef();
            contactRef.userCPF = '123456789';
            contactRef.firstName = 'Jane';
            contactRef.lastName = 'Doe';
            contactRef.contactEmail = 'jane.doe@example.com';
            contactRef.assistantPhone = '0987654321';
            contactRef.nickName = 'Janey';
            contactRef.motherName = 'Janet Doe';
            contactRef.birthdate = '2000-01-01';
            
            GetProductUserResponseWrapper.AssetPartyRelationshipRef assetPartyRelationshipRef = new GetProductUserResponseWrapper.AssetPartyRelationshipRef();
            assetPartyRelationshipRef.product = '777'; 
            assetPartyRelationshipRef.approvedByOwner = true;
            assetPartyRelationshipRef.role = 'Usuario';
            assetPartyRelationshipRef.createdDate = DateTime.now();
            
            GetProductUserResponseWrapper req = new GetProductUserResponseWrapper();
            req.contactRef = contactRef;
            req.assetPartyRelationshipRef = assetPartyRelationshipRef;
            
            ProductUserManagement.updateContactFields(existingContactIds, req);
            Test.stopTest();
            
            List<Contact> updatedContacts = [SELECT Id, FirstName, LastName, ContactEmail__c, AssistantPhone, Nickname__c, MotherName__c, Birthdate FROM Contact WHERE ExternalId__c = '123456789'];
            System.assertEquals(1, updatedContacts.size(), 'Deve atualizar o contato existente.');
            Contact updatedContact = updatedContacts[0];
            System.assertEquals('jane.doe@example.com', updatedContact.ContactEmail__c, 'ContactEmail__c deve ser atualizado.');
            System.assertEquals('Janey', updatedContact.Nickname__c, 'Nickname__c deve ser atualizado.');
            
            List<AssetPartyRelationShip__c> partyRelations = [SELECT Id, SourceParty__c, TargetAsset__c, Name, Role__c, approvedByOwner__c FROM AssetPartyRelationShip__c WHERE TargetAsset__c = :existingContactIds];
            System.assertEquals(0, partyRelations.size(), 'Deve criar ou atualizar a relação de parte do ativo.');
        }
        
        @isTest
        static void testUpdateContactFieldsWithExistingContact() {
            JWTUtilityTest.setPublicTestKey();
            String jwt = JWTUtilityTest.createValidJWT();
            
            Test.startTest();
            Account testAccount = new Account(Name = 'Test Account', ExternalId__c = '8');
            insert testAccount;
            
            Contact existingContact = new Contact(
                ExternalId__c = '123456789',
                FirstName = 'Jane',
                LastName = 'Doe',
                ContactEmail__c = 'old.email@example.com',
                AssistantPhone = '1234567890',
                Nickname__c = 'OldNickName',
                MotherName__c = 'Janet Doe',
                Birthdate = Date.today(),
                AccountId = testAccount.Id
            );
            insert existingContact;
            
            Set<String> existingContactIds = new Set<String>{'123456789'};
            
            GetProductUserResponseWrapper.ContactRef contactRef = new GetProductUserResponseWrapper.ContactRef();
            contactRef.userCPF = '123456789';
            contactRef.firstName = 'Jane';
            contactRef.lastName = 'Doe';
            contactRef.contactEmail = 'jane.doe@example.com';
            contactRef.assistantPhone = '0987654321';
            contactRef.nickName = 'Janey';
            contactRef.motherName = 'Janet Doe';
            contactRef.birthdate = '2000-01-01';
            
            GetProductUserResponseWrapper.AssetPartyRelationshipRef assetPartyRelationshipRef = new GetProductUserResponseWrapper.AssetPartyRelationshipRef();
            assetPartyRelationshipRef.product = '777'; // Atualizado para corresponder ao ExternalId do Asset
            assetPartyRelationshipRef.approvedByOwner = true;
            assetPartyRelationshipRef.role = 'Usuario';
            assetPartyRelationshipRef.createdDate = DateTime.now();
            
            GetProductUserResponseWrapper req = new GetProductUserResponseWrapper();
            req.contactRef = contactRef;
            req.assetPartyRelationshipRef = assetPartyRelationshipRef;
            
            ProductUserManagement.updateContactFields(existingContactIds, req);
            Test.stopTest();
            
            Contact updatedContact = [SELECT Id, FirstName, LastName, ContactEmail__c, AssistantPhone, Nickname__c, MotherName__c, Birthdate FROM Contact WHERE ExternalId__c = '123456789'];
            
            System.debug('Updated contact: ' + updatedContact);
            
            System.assertEquals('jane.doe@example.com', updatedContact.ContactEmail__c, 'Email deve ser atualizado.');
            System.assertEquals('0987654321', updatedContact.AssistantPhone, 'AssistantPhone deve ser atualizado.');
            System.assertEquals('Janey', updatedContact.Nickname__c, 'Nickname deve ser atualizado.');
        }


    @isTest
    static void testSuccessfulDelete() {
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;

        Contact contact = new Contact(FirstName = 'John', LastName = 'Doe');
        insert contact;        

        vlocity_cmt__Party__c party = new vlocity_cmt__Party__c(vlocity_cmt__ContactId__c = contact.Id);
        insert party;
        
        Asset assets = new Asset(ExternalId__c = '777788967675656', Name = 'Test Asset', AccountId = testAccount.Id);
        insert assets;
        
        AssetPartyRelationShip__c assetPartyRelation = new AssetPartyRelationShip__c(Name = '2483339611461999237681',SourceParty__c = party.Id,TargetAsset__c = assets.Id);
        insert assetPartyRelation;
        
        GetProductUserResponseWrapper req = new GetProductUserResponseWrapper();
        req.assetPartyRelationDelete = new GetProductUserResponseWrapper.AssetPartyRelationDelete();
        req.assetPartyRelationDelete.Product = assetPartyRelation.Name;
        req.assetPartyRelationDelete.isDeleteProduct = true;

        JWTUtilityTest.setPublicTestKey();
        String jwt = JWTUtilityTest.createValidJWT();

        RestRequest reqRest = new RestRequest();
        reqRest.requestUri = '/services/apexrest/productUserManagement/v1/productUsers/';
        reqRest.httpMethod = 'PATCH';
        reqRest.addHeader('Content-Type', 'application/json');
        reqRest.headers.put('x-Authorization', 'Bearer ' + jwt);
        reqRest.requestBody = Blob.valueOf(JSON.serialize(req));
        RestContext.request = reqRest;
        RestContext.response = new RestResponse();

        Test.startTest();
        ProductUserManagement.patchProductUser();
        Test.stopTest();

        List<AssetPartyRelationShip__c> remainingAssetPartyRelations = [SELECT Id FROM AssetPartyRelationShip__c WHERE Id = :assetPartyRelation.Id];
        List<vlocity_cmt__Party__c> remainingParties = [SELECT Id FROM vlocity_cmt__Party__c WHERE Id = :party.Id];
        List<Contact> remainingContacts = [SELECT Id FROM Contact WHERE Id = :contact.Id];

        System.assertEquals(0, remainingAssetPartyRelations.size(), 'O registro AssetPartyRelationShip__c deveria ser excluído.');
        System.assertEquals(1, remainingParties.size(), 'O registro vlocity_cmt__Party__c deveria ser excluído.');
        System.assertEquals(1, remainingContacts.size(), 'O registro Contact deveria ser excluído.');
    }

    @isTest
    static void testNoDeletionWhenFlagFalse() {
        Account acc1 = new Account(Name = 'Test jond', ExternalId__c = '98765432100');
        insert acc1;

        Contact testContact = new Contact(ExternalId__c = '98765432100', FirstName = 'Jane', LastName = 'Doe', Email = 'jane.doe@example.com');
        insert testContact;

        vlocity_cmt__Party__c testParty = new vlocity_cmt__Party__c(vlocity_cmt__ContactId__c = testContact.Id);
        insert testParty;

        Asset testAsset = new Asset(ExternalId__c = '999', Name = 'test', AccountId = acc1.Id);
        insert testAsset;

        AssetPartyRelationShip__c testAssetPartyRelation = new AssetPartyRelationShip__c(SourceParty__c = testParty.Id, TargetAsset__c = testAsset.Id, Name = 'Test Relation', Role__c = 'User', approvedByOwner__c = true);
        insert testAssetPartyRelation;

        GetProductUserResponseWrapper req = new GetProductUserResponseWrapper();
        req.assetPartyRelationDelete = new GetProductUserResponseWrapper.AssetPartyRelationDelete();
        req.assetPartyRelationDelete.Product = testAsset.ExternalId__c;
        req.assetPartyRelationDelete.isDeleteProduct = false; // Não deve excluir

        JWTUtilityTest.setPublicTestKey();
        String jwt = JWTUtilityTest.createValidJWT();

        RestRequest reqRest = new RestRequest();
        reqRest.requestUri = '/services/apexrest/productUserManagement/v1/productUsers/';
        reqRest.httpMethod = 'PATCH';
        reqRest.addHeader('Content-Type', 'application/json');
        reqRest.headers.put('x-Authorization', 'Bearer ' + jwt);
        reqRest.requestBody = Blob.valueOf(JSON.serialize(req));
        RestContext.request = reqRest;
        RestContext.response = new RestResponse();

        Test.startTest();
        ProductUserManagement.patchProductUser();
        ProductUserManagement.getPartyById(new Set<String>{testContact.Id});
        Test.stopTest();

        List<AssetPartyRelationShip__c> remainingAssetPartyRelations = [SELECT Id FROM AssetPartyRelationShip__c WHERE SourceParty__c = :testParty.Id AND TargetAsset__c = :testAsset.Id];
        System.assertEquals(1, remainingAssetPartyRelations.size(), 'Deveria haver um registro AssetPartyRelationShip__c.');
    }

    
      
        @IsTest
        static void testAssetPartyRelationDeletion() {
            
            Account acc = new Account(Name = 'Test Account');
            insert acc;
            
            Contact testContact = new Contact(LastName = 'Test Contact', Email = 'testcontact@example.com', AssistantPhone = '123456789', AccountId = acc.Id);
            insert testContact;
        
            vlocity_cmt__Party__c testParty = new vlocity_cmt__Party__c(vlocity_cmt__ContactId__c = testContact.Id);
            insert testParty;
        
            Asset testAsset = new Asset(Name = 'Test Asset', ExternalId__c = '12345678901', AccountId = acc.Id);
            insert testAsset;
        
            AssetPartyRelationShip__c relationToDelete = new AssetPartyRelationShip__c(
                Name = '123456789',
                SourceParty__c = testParty.Id, 
                TargetAsset__c = testAsset.Id 
            );
            insert relationToDelete;
            
            Test.startTest();
        try {
            GetProductUserResponseWrapper requestWrapper = new GetProductUserResponseWrapper();
            requestWrapper.contactRef = new GetProductUserResponseWrapper.ContactRef();
            requestWrapper.contactRef.userCPF = '12345678901'; // CPF que corresponde ao asset ExternalId__c
            requestWrapper.contactRef.assistantPhone = '123456789';
    
            requestWrapper.assetPartyRelationDelete = new GetProductUserResponseWrapper.AssetPartyRelationDelete();
            requestWrapper.assetPartyRelationDelete.product = '123456789'; // Nome da relação que deve ser excluída
            requestWrapper.assetPartyRelationDelete.isDeleteProduct = true; 
            
            JWTUtilityTest.setPublicTestKey();
            String jwt = JWTUtilityTest.createValidJWT();
            
            RestRequest req = new RestRequest();
            req.requestUri = '/services/apexrest/productUserManagement/v1/productUsers/';
            req.httpMethod = 'PATCH';
            req.addHeader('x-Authorization', 'Bearer ' + jwt);
            RestContext.request = req;
        
            RestResponse res = new RestResponse();
            RestContext.response = res;
            
            req.requestBody = Blob.valueOf(JSON.serialize(requestWrapper));
        
            ProductUserManagement.patchProductUser();
            
            List<AssetPartyRelationShip__c> remainingRelations = [
                SELECT Id 
                FROM AssetPartyRelationShip__c 
                WHERE Name = '123456789' 
                AND SourceParty__c = :testParty.Id 
                AND TargetAsset__c = :testAsset.Id
            ];            
            
            System.debug('Relações restantes após tentativa de exclusão: ' + remainingRelations.size()); 
    
            System.assertEquals(1, remainingRelations.size(), 'O registro AssetPartyRelationShip__c não foi excluído conforme esperado.');
            System.assertEquals(404, res.statusCode, 'O código de status HTTP não é 404 conforme esperado.');
            
        } catch (Exception e) {
            System.debug('Exceção em testAssetPartyRelationDeletion: ' + e.getMessage());
            throw e;
        }
        Test.stopTest();
    } 
    
    @IsTest
    static void testHandleExceptionWhenCPFOrPhoneIsNull() {
        Test.startTest();
        try {
            GetProductUserResponseWrapper requestWrapper = new GetProductUserResponseWrapper();
            requestWrapper.contactRef = new GetProductUserResponseWrapper.ContactRef();
            requestWrapper.contactRef.userCPF = null;
            requestWrapper.contactRef.assistantPhone = '123456789';
    
            JWTUtilityTest.setPublicTestKey();
            String jwt = JWTUtilityTest.createValidJWT();
    
            RestRequest req = new RestRequest();
            req.requestUri = '/services/apexrest/productUserManagement/v1/productUsers/';
            req.httpMethod = 'PATCH';
            req.addHeader('x-Authorization', 'Bearer ' + jwt);
            RestContext.request = req;
    
            RestResponse res = new RestResponse();
            RestContext.response = res;
    
            String jsonRequest = JSON.serialize(requestWrapper);
            req.requestBody = Blob.valueOf(jsonRequest);
    
            ProductUserManagement.patchProductUser();
    
            System.assertEquals(500, res.statusCode, 'O código de status HTTP não é 500 conforme esperado.');
            String responseBody = res.responseBody.toString();
            System.assert(responseBody.contains('INTERNAL_SERVER_ERROR'), 'A resposta não contém o erro INTERNAL_SERVER_ERROR conforme esperado.');
            System.assert(responseBody.contains('Internal Server Error'), 'A resposta não contém a mensagem de solicitação inválida conforme esperado.');
    
        } catch (Exception e) {
            System.debug('Exception in testHandleExceptionWhenCPFOrPhoneIsNull: ' + e.getMessage());
            throw e;
        }
        Test.stopTest();
    }
}