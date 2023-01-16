@IsTest
public with sharing class AccessTokenControllerTest {
    
    @testSetup
    private static void setup(){
        
        Webservice__c setting = new Webservice__c();
        setting.Name = 'GenericWS';
        setting.Certificate__c = 'SFA_CERT';
        setting.Password__c = '01234567890abcde';
        setting.Endpoint__c  = 'https://hmlapi.telefonicabigdata.com';
        setting.SubscriptionKey__c = 'd1ca8d57a2984db88f01c9ce7b5862e2';

        insert setting;
        
    }
    @IsTest
    static void testInvokeMethod(){
        
        Test.startTest();
        AccessTokenController accessTokenController = new AccessTokenController();
        accessTokenController.invokeMethod('getAccessToken', new Map<String, Object>(), new Map<String, Object>(), new Map<String, Object>());
        Test.stopTest();
        
    }
}
