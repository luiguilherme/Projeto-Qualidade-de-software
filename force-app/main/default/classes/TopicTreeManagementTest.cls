@isTest
public with sharing class TopicTreeManagementTest {
    private static final String BROKEN_JWT_TOKEN = 'MIGeMA0GCSqGSIb3DQEBAQUAA4GMADCBiAKBgGem2z/GaUjUe/6OGfilrcdrklxa0fyMqQIbSMBjC9rr7g+2db+mC1C/pSwNEOHjnM8OcObtSeTz9khtd/jB8aFggYbnmFAJgBEvOmiPLFpaDObBKVMytSK/M8j63gmu2fGIWZAupnyCG1BKe2YOpOwG4nOwlRSqUhISUosYFotfAgMBAAE='; 
    
    @testSetup 
    static void setup(){
        insert new CustomerInteractionTopicTree__c(
            Name = 'Test With Omnitree',
            Active__c = true,
            GPSId__c = '',
            OperatorSegment__c = 'Gold',
            OmniTree__c = 'Mudança do Endereço de Instalação > Fixa > Casa',
			Type__c = 'Palito'            
        );

        insert new CustomerInteractionTopicTree__c(
            Name = 'Test With Gps Flow',
            Active__c = true,
            GPSId__c = '',
            OperatorSegment__c = 'Gold',
            GPSFlow__c = 'Mudança do Endereço de Instalação > Fixa > Casa',
			Type__c = 'Palito'            
        );
    }
    
    @isTest
    public static void getWithOmniTree(){
        JWTUtilityTest.setPublicTestKey();
        String jwt = JWTUtilityTest.createValidJWT();
        Test.startTest();
        RestRequest request = new RestRequest();
        RestResponse res = new RestResponse();   
        request.requestUri ='/TopicTreeManagement/v1';
        request.httpMethod = 'GET';
        String authHeader = 'Bearer ' + jwt;
        request.headers.put('x-Authorization', authHeader);
        request.addParameter('omnitree','true');
        RestContext.request = request;
        RestContext.response= res;
        TopicTreeManagement.getTopicTree();
        test.stopTest();
        getTopicTreeResponseWrapper.responseSucess responseReturn = (getTopicTreeResponseWrapper.responseSucess) Json.deserialize(res.responseBody.toString(),getTopicTreeResponseWrapper.responseSucess.class);
        System.assertEquals('Test With Omnitree', responseReturn.topicTree[0].Name);
    }

    @isTest
    public static void getWithGpsFlow(){
        JWTUtilityTest.setPublicTestKey();
        String jwt = JWTUtilityTest.createValidJWT();
        Test.startTest();
        RestRequest request = new RestRequest();
        RestResponse res = new RestResponse();   
        request.requestUri ='/TopicTreeManagement/v1';
        request.httpMethod = 'GET';
        String authHeader = 'Bearer ' + jwt;
        request.headers.put('x-Authorization', authHeader);
        request.addParameter('gpsFlow','true');
        RestContext.request = request;
        RestContext.response= res;
        TopicTreeManagement.getTopicTree();
        test.stopTest();
        getTopicTreeResponseWrapper.responseSucess responseReturn = (getTopicTreeResponseWrapper.responseSucess) Json.deserialize(res.responseBody.toString(),getTopicTreeResponseWrapper.responseSucess.class);
        System.assertEquals('Test With Gps Flow', responseReturn.topicTree[0].Name);
    }

    @isTest
    public static void getWithOmnitreeAndGpsFlow(){
        JWTUtilityTest.setPublicTestKey();
        String jwt = JWTUtilityTest.createValidJWT();
        insert new CustomerInteractionTopicTree__c(
            Name = 'Test With Gps Flow and OmniTree',
            Active__c = true,
            GPSId__c = '',
            OperatorSegment__c = 'Gold',
            GPSFlow__c = 'Teste GpsFlow',
            OmniTree__c = 'Mudança de Endereço > Fixa > Casa',
			Type__c = 'Palito'            
        );
        Test.startTest();
        RestRequest request = new RestRequest();
        RestResponse res = new RestResponse();   
        request.requestUri ='/TopicTreeManagement/v1';
        request.httpMethod = 'GET';
        String authHeader = 'Bearer ' + jwt;
        request.headers.put('x-Authorization', authHeader);
        request.addParameter('gpsFlow','true');
        request.addParameter('omnitree','true');
        RestContext.request = request;
        RestContext.response= res;
        TopicTreeManagement.getTopicTree();
        test.stopTest();
        getTopicTreeResponseWrapper.responseSucess responseReturn = (getTopicTreeResponseWrapper.responseSucess) Json.deserialize(res.responseBody.toString(),getTopicTreeResponseWrapper.responseSucess.class);
        System.assertEquals('Test With Gps Flow and OmniTree', responseReturn.topicTree[0].Name);
    }

    @isTest
    public static void getWithProductType(){
        JWTUtilityTest.setPublicTestKey();
        String jwt = JWTUtilityTest.createValidJWT();
        insert new CustomerInteractionTopicTree__c(
            Name = 'getWithProductType',
            Active__c = true,
            GPSId__c = '',
            OperatorSegment__c = 'Gold',
            GPSFlow__c = 'Teste GpsFlow',
            OmniTree__c = 'Mudança de Endereço > Fixa > Casa',
            ProductType__C = 'Fixed',
			Type__c = 'Palito'            
        );
        Test.startTest();
        RestRequest request = new RestRequest();
        RestResponse res = new RestResponse();   
        request.requestUri ='/TopicTreeManagement/v1';
        request.httpMethod = 'GET';
        String authHeader = 'Bearer ' + jwt;
        request.headers.put('x-Authorization', authHeader);
        request.addParameter('productType','fixed, mobile');
        RestContext.request = request;
        RestContext.response= res;
        TopicTreeManagement.getTopicTree();
        test.stopTest();
        getTopicTreeResponseWrapper.responseSucess responseReturn = (getTopicTreeResponseWrapper.responseSucess) Json.deserialize(res.responseBody.toString(),getTopicTreeResponseWrapper.responseSucess.class);
        System.assertEquals('getWithProductType', responseReturn.topicTree[0].Name);
    }

    @isTest
    public static void getBlank(){
        JWTUtilityTest.setPublicTestKey();
        String jwt = JWTUtilityTest.createValidJWT();
        Test.startTest();
        RestRequest request = new RestRequest();
        RestResponse res = new RestResponse();   
        request.requestUri ='/TopicTreeManagement/v1';
        request.httpMethod = 'GET';
        String authHeader = 'Bearer ' + jwt;
        request.headers.put('x-Authorization', authHeader);
        request.addParameter('gpsFlow','true');
        request.addParameter('omnitree','true');
        RestContext.request = request;
        RestContext.response= res;
        TopicTreeManagement.getTopicTree();
        test.stopTest();
        List<getTopicTreeResponseWrapper.responseError> responseReturn = (List<getTopicTreeResponseWrapper.responseError>) Json.deserialize(res.responseBody.toString(),List<getTopicTreeResponseWrapper.responseError>.class);
        System.assertEquals('NOT_FOUND', responseReturn[0].errorCode);
    }

    @isTest
    public static void errorException(){
        JWTUtilityTest.setPublicTestKey();
        String jwt = JWTUtilityTest.createValidJWT();
        Test.startTest();
        RestRequest request = new RestRequest();
        RestResponse res = new RestResponse();   
        request.requestUri ='/TopicTreeManagement/v1';
        request.httpMethod = 'GET';
        String authHeader = 'Bearer ' + BROKEN_JWT_TOKEN;
        request.headers.put('x-Authorization', authHeader);
        request.addParameter('gpsFlow','true');
        request.addParameter('omnitree','true');
        RestContext.request = request;
        RestContext.response= res;
        TopicTreeManagement.getTopicTree();
        test.stopTest();
        List<getTopicTreeResponseWrapper.responseError> responseReturn = (List<getTopicTreeResponseWrapper.responseError>) Json.deserialize(res.responseBody.toString(),List<getTopicTreeResponseWrapper.responseError>.class);
        System.assertEquals('Exception', responseReturn[0].errorCode);
    }

    @isTest
    public static void errorJWT(){
        JWTUtilityTest.setPublicTestKey();
        String jwt = JWTUtilityTest.createInvalidJWT();
        Test.startTest();
        RestRequest request = new RestRequest();
        RestResponse res = new RestResponse();   
        request.requestUri ='/TopicTreeManagement/v1';
        request.httpMethod = 'GET';
        String authHeader = 'Bearer ' + jwt;
        request.headers.put('x-Authorization', authHeader);
        request.addParameter('gpsFlow','true');
        request.addParameter('omnitree','true');
        RestContext.request = request;
        RestContext.response= res;
        TopicTreeManagement.getTopicTree();
        test.stopTest();
        List<getTopicTreeResponseWrapper.responseError> responseReturn = (List<getTopicTreeResponseWrapper.responseError>) Json.deserialize(res.responseBody.toString(),List<getTopicTreeResponseWrapper.responseError>.class);
        System.assertEquals('Forbidden', responseReturn[0].errorCode);
    }

    @isTest
    public static void withoutJWT(){
        Test.startTest();
        RestRequest request = new RestRequest();
        RestResponse res = new RestResponse();   
        request.requestUri ='/TopicTreeManagement/v1';
        request.httpMethod = 'GET';
        request.addParameter('gpsFlow','true');
        request.addParameter('omnitree','true');
        RestContext.request = request;
        RestContext.response= res;
        TopicTreeManagement.getTopicTree();
        test.stopTest();
        List<getTopicTreeResponseWrapper.responseError> responseReturn = (List<getTopicTreeResponseWrapper.responseError>) Json.deserialize(res.responseBody.toString(),List<getTopicTreeResponseWrapper.responseError>.class);
        System.assertEquals('Forbidden', responseReturn[0].errorCode);
    }
    
}