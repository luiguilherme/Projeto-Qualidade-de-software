@isTest
public class OAuthEndUserRequestConfiguratorTest {
    
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
    
    //@isTest
    //private static void test(){
        
    //    Webservice__c wsConfig = Webservice__c.getInstance('GenericWS');
        
    //    Test.startTest();
    //    OAuthEndUserRequestConfigurator config = new OAuthEndUserRequestConfigurator();
    //    HttpRequest request = new HttpRequest();
    //    request = config.configure(request, wsConfig);
    //    Test.stopTest();
    //}
    
    //@isTest
    //private static void filledConstructorTest(){
        
    //    Webservice__c wsConfig = Webservice__c.getInstance('GenericWS');
        
    //    Test.startTest();
    //    OAuthEndUserRequestConfigurator config = new OAuthEndUserRequestConfigurator(new QuartaPlataformaRequestConfigurator());
    //    HttpRequest request = new HttpRequest();
    //    request = config.configure(request, wsConfig);
    //    Test.stopTest();
    //}
    
    @isTest
    private static void testmockdata(){
        
        //Webservice__c wsConfig = Webservice__c.getInstance('GenericWS');
        
        Test.startTest();
        OAuthEndUserRequestConfigurator config = new OAuthEndUserRequestConfigurator();
        testResult = config.mockMethod();
        //HttpRequest request = new HttpRequest();
        //request = config.configure(request, wsConfig);
        Test.stopTest();
    }

}