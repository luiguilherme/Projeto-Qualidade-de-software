@IsTest
public with sharing class UUIDServiceTest {
    @testSetup 
    static void setup(){
        insert new Webservice__c(
            Name = 'UserServiceUserProfileCallout',
            Endpoint__c  = 'https://api-hml.telefonica.com.br/userprofile/v4/',
            SubscriptionKey__c = 'd1ca8d57a2984db88f01c9ce7b5862e2',
            User__c ='UserMock'
        );
        WebServiceTestFactory.start().authOAuthProvider().create();
    }

    @isTest
    public static void validUuidCpf(){
        //cenário
        Test.setMock(HttpCalloutMock.class, new UserProfileCalloutPessoaMock());
    
        Boolean result;
        test.startTest();
        UUIDService UUIDServiceMock = new UUIDService('63542141747','63542141747');
        //execução
        result = UUIDServiceMock.uuIDIsValid();
        test.stopTest();
        //verificação
        System.assert(result,'O Uuid é inválido');
    
    }
    @isTest 
    public static void invalidUUidCpf(){
        //cenário
        Test.setMock(HttpCalloutMock.class, new UserProfileCalloutPessoaMock());
        Boolean result;
        test.startTest();
        UUIDService UUIDServiceMock = new UUIDService('123456','12346');
        //execução
        result = UUIDServiceMock.uuIDIsValid();
        test.stopTest();
        //verificação
        System.assert(!result,'O Uuid é válido e era para ser inválido');
    }
   @isTest
    public static void validUuidProduct(){
        //cenário
        Test.setMock(HttpCalloutMock.class, new UserProfileCalloutProductMock());
        Boolean result;
        test.startTest();
        UUIDService UUIDServiceMock = new UUIDService('63542141747','63542141747');
        //execução
        result = UUIDServiceMock.uuIDIsValid();
        test.stopTest();
        //verificação
        System.assert(result,'O Uuid é inválido');

    }
    @isTest
    public static void invalidUuidProduct(){
        //cenário
        Test.setMock(HttpCalloutMock.class, new UserProfileCalloutProductMock());
        Boolean result;
        test.startTest();
        UUIDService UUIDServiceMock = new UUIDService('123456','123456');
        //execução
        result = UUIDServiceMock.uuIDIsValid();
        System.debug(result);
        test.stopTest();
        //verificação
        System.assert(!result,'O Uuid é válido e era para ser inválido');

    }
    @isTest
    public static void isPrePaidProduct(){
        //cenário
        Test.setMock(HttpCalloutMock.class, new UserProfileCalloutProductMock());
        Boolean result;
        test.startTest();
        UUIDService UUIDServiceMock = new UUIDService('123456','123456');
        //execução
        result = UUIDServiceMock.isPrepaid();
        System.debug(result);
        test.stopTest();
        //verificação
        System.assert(result,'O retorno possuia um pré pago mas retornou falso');


    }
    @isTest
    public static void isPrePaidPhysicalPerson(){
        //cenário
        Test.setMock(HttpCalloutMock.class, new UserProfileCalloutPessoaMock());
        Boolean result;
        test.startTest();
        UUIDService UUIDServiceMock = new UUIDService('123456','123456');
        //execução
        result = UUIDServiceMock.isPrepaid();
        System.debug(result);
        test.stopTest();
        //verificação
        System.assert(result,'O retorno possuia um pré pago mas retornou falso');


    }






}