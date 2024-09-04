/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 08-27-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
@isTest
public class ConsultProductUserTest {
    
    @testSetup
    static void testSetup() {
        
		Account testAccount = new Account( Name = 'Test Account', ExternalId__c = '1234567890211999999999');
        insert testAccount;

        Contact testContact = new Contact( AccountId = testAccount.Id,
            CPF__c = '12345678902', FirstName = 'Test', LastName = 'User', ExternalId__c = '1234567890211999999999', ContactEmail__c = 'contactEmail@test.com', AssistantPhone = '1199643388', OtherPhone = '1199643388',
            Nickname__c = 'TestNick', MotherName__c = 'TestMother', Birthdate = Date.newInstance(1990, 1, 1), Email = 'email@test.com', MobilePhone = '1199643388', HomePhone = '113622959', Phone = '113622959');
        insert testContact;
        
        Asset testAsset = new Asset( ExternalId__c = '1234567890211999999999', Name = 'Test Asset', AccountId = testAccount.Id, ContactId = testContact.Id);
        insert testAsset;
        
        vlocity_cmt__Party__c testParty = new vlocity_cmt__Party__c( vlocity_cmt__ContactId__c = testContact.Id );
        insert testParty;
        
        AssetPartyRelationShip__c testAssetPartyRelation = new AssetPartyRelationShip__c( SourceParty__c = testParty.Id, TargetAsset__c = testAsset.Id, Name = 'Test Asset Party Relation', Role__c = 'Usuário', approvedByOwner__c = true );
        insert testAssetPartyRelation;
    }
    
    @isTest
    static void testSelectAllDependentsByCpfWhenSuccess() {
        JWTUtilityTest.setPublicTestKey();
        String jwt = JWTUtilityTest.createValidJWT();
        RestRequest req = new RestRequest();
        req.requestUri = '/services/apexrest/consultProductUser/v1/productUsers/12345678902';
        req.httpMethod = 'GET';
        req.headers.put('x-Authorization','Bearer ' + jwt);
        req.addHeader('Content-Type', 'application/json');
        RestContext.request = req;
        
        RestResponse res = new RestResponse();
        RestContext.response = res;

        Test.startTest();
        ConsultProductUser.getConsultProductUser();
        Test.stopTest();
        
        GetConsultProductResponseWrapper.ConsultProductUserWrapper response = (GetConsultProductResponseWrapper.ConsultProductUserWrapper) JSON.deserialize(res.responseBody.toString(), GetConsultProductResponseWrapper.ConsultProductUserWrapper.class);
        System.assertEquals(200, res.statusCode);
        System.assertEquals('Registros retornados com sucesso.', response.message);
        System.assertNotEquals(0, response.totalSize);
        
    }
    
    @isTest
    static void testSelectDependentsByCpfAndLineWhenSuccess() {
        JWTUtilityTest.setPublicTestKey();
        String jwt = JWTUtilityTest.createValidJWT();
        RestRequest req = new RestRequest();
        req.requestUri = '/services/apexrest/consultProductUser/v1/productUsers/1234567890211999999999';
        req.httpMethod = 'GET';
        req.headers.put('x-Authorization','Bearer ' + jwt);
        req.addHeader('Content-Type', 'application/json');
        RestContext.request = req;
        
        RestResponse res = new RestResponse();
        RestContext.response = res;
        
        Test.startTest();
        ConsultProductUser.getConsultProductUser();
        Test.stopTest();
        
        GetConsultProductResponseWrapper.ConsultProductUserWrapper response = (GetConsultProductResponseWrapper.ConsultProductUserWrapper) JSON.deserialize(res.responseBody.toString(), GetConsultProductResponseWrapper.ConsultProductUserWrapper.class);
        System.assertEquals(200, res.statusCode);
        System.assertEquals('Registros retornados com sucesso.', response.message);
        System.assertNotEquals(0, response.totalSize);
    }
 
    @isTest
    static void testReturnsErrorWhenCpfIsInvalid() {
        RestResponse res = new RestResponse();
        RestRequest req = new RestRequest();

        RestContext.response = res;
        JWTUtilityTest.setPublicTestKey();
        String jwt = JWTUtilityTest.createValidJWT();
        req.headers.put('x-Authorization','Bearer ' + jwt);

        req.requestUri = '/services/apexrest/consultProductUser/v1/productUsers/';
        req.httpMethod = 'GET';
        req.addHeader('Content-Type', 'application/json');
        RestContext.request = req;
 
        Test.startTest();
        ConsultProductUser.getConsultProductUser();
        Test.stopTest();

        System.assertEquals(400, res.statusCode);
        String responseBody = res.responseBody.toString();
        GetConsultProductResponseWrapper response = GetConsultProductResponseWrapper.parse(responseBody);

        System.assert(responseBody.contains('BAD_REQUEST'));
        System.assert(responseBody.contains('invalid request'));
    }
 
    
    @isTest
    static void testReturnsErrorWhenCpfOrCpfAndLineNotFound() {
        JWTUtilityTest.setPublicTestKey();
        String jwt = JWTUtilityTest.createValidJWT();
        RestRequest req = new RestRequest();
        req.requestUri = '/services/apexrest/consultProductUser/v1/productUsers/1234567890211999999998';
        req.httpMethod = 'GET';
        req.headers.put('x-Authorization','Bearer ' + jwt);
        req.addHeader('Content-Type', 'application/json');
        RestContext.request = req;
        
        RestResponse res = new RestResponse();
        RestContext.response = res;
        
        Test.startTest();
        ConsultProductUser.getConsultProductUser();
        Test.stopTest();
        
        GetConsultProductResponseWrapper.ConsultProductUserWrapper response = (GetConsultProductResponseWrapper.ConsultProductUserWrapper) JSON.deserialize(res.responseBody.toString(), GetConsultProductResponseWrapper.ConsultProductUserWrapper.class);
        System.assertEquals(404, res.statusCode);
        System.assertEquals('This operation was not found', response.message);
    }
    
	@isTest
    static void testIsValidJWT() {
        JWTUtilityTest.setPublicTestKey();
		RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();

        String jwt = JWTUtilityTest.createValidJWT();
        String externalId = '1234567891';
        //Contact cc = [SELECT Id, ExternalId__c FROM Contact WHERE ExternalId__c =: externalId];

        req.requestURI = '/services/apexrest/consultProductUser/v1/productUsers/' + externalId;
        req.headers.put('x-Authorization','Bearer ' + jwt);
        req.httpMethod = 'GET';
        RestContext.request = req;
        RestContext.response = res;

        Test.startTest();
        ConsultProductUser.getConsultProductUser();
        Test.stopTest();

        Assert.areEqual(400, res.statusCode);
    }
    
    @isTest
    static void testIsInvalidJWT() {
        JWTUtilityTest.setPublicTestKey();
		RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();

        String jwt = JWTUtilityTest.createInvalidJWT();
        String externalId = '1234567891';
        //Contact cc = [SELECT Id, ExternalId__c FROM Contact WHERE ExternalId__c =: externalId];

        req.requestURI = '/services/apexrest/consultProductUser/v1/productUsers/' + externalId;
        req.headers.put('x-Authorization','Bearer ' + jwt);
        req.httpMethod = 'GET';
        RestContext.request = req;
        RestContext.response = res;

        Test.startTest();
        ConsultProductUser.getConsultProductUser();
        Test.stopTest();

        GetConsultProductResponseWrapper.ConsultProductUserWrapper response = (GetConsultProductResponseWrapper.ConsultProductUserWrapper) JSON.deserialize(res.responseBody.toString(), GetConsultProductResponseWrapper.ConsultProductUserWrapper.class);
        System.assertEquals(403, res.statusCode);
        System.assertEquals('Forbidden', response.message); 
    }
    
    @isTest
    static void testInternalServerError() {
        JWTUtilityTest.setPublicTestKey();
        String jwt = '';
        RestRequest req = new RestRequest();
        req.requestUri = '/services/apexrest/consultProductUser/v1/productUsers/12345678901199999998';
        req.httpMethod = 'GET';
        req.headers.put('x-Authorization','Bearer ' + jwt);
        req.addHeader('Content-Type', 'application/json');
        RestContext.request = req;
        
        RestResponse res = new RestResponse();
        RestContext.response = res;
        
        Test.startTest();
        ConsultProductUser.getConsultProductUser();
        Test.stopTest();
        
        GetConsultProductResponseWrapper.ConsultProductUserWrapper response = (GetConsultProductResponseWrapper.ConsultProductUserWrapper) JSON.deserialize(res.responseBody.toString(), GetConsultProductResponseWrapper.ConsultProductUserWrapper.class);
        System.assertEquals(500, res.statusCode);
        System.assertEquals('Internal Server Error', response.message); 
    } 
    
    	@isTest
    	static void testJWTForbiden() {
        JWTUtilityTest.setPublicTestKey();
        String jwt = JWTUtilityTest.createValidJWT();
        RestRequest req = new RestRequest();
        req.requestUri = '/services/apexrest/consultProductUser/v1/productUsers/12345678901199999998';
        req.httpMethod = 'GET';
        req.headers.put('x-Authorization',' ');
        req.addHeader('Content-Type', 'application/json');
        RestContext.request = req;
        
        RestResponse res = new RestResponse();
        RestContext.response = res;
        
        Test.startTest();
        ConsultProductUser.getConsultProductUser();
        Test.stopTest();
        
        GetConsultProductResponseWrapper.ConsultProductUserWrapper response = (GetConsultProductResponseWrapper.ConsultProductUserWrapper) JSON.deserialize(res.responseBody.toString(), GetConsultProductResponseWrapper.ConsultProductUserWrapper.class);
        System.assertEquals(403, res.statusCode);
        System.assertEquals('Forbidden', response.message); 
    } 
}