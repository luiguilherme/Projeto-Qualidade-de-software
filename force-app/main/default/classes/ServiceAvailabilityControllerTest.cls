@isTest
public class ServiceAvailabilityControllerTest {
    
    @TestSetup
    static void setup(){
        Account lAccount = DataFactory.createAccount();
        lAccount.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Consumer').getRecordTypeId();
        lAccount.ShippingStreet = 'Av. teste 2 ';
        lAccount.ShippingPostalCode = '12342';
        lAccount.ShippingNumber__c = '12342';
        lAccount.BillingStreet = 'Av. teste 1';
        lAccount.BillingPostalCode = '12341';
        lAccount.BillingNumber__c = '12341';
        insert lAccount;
        
        Account lAccount1 = new Account();
        lAccount1.Name = 'Teste1';
        lAccount1.ParentId = lAccount.Id;
        lAccount1.BillingAccountType__c = 'Móvel';
        lAccount1.BillingStreet = 'Av. teste 1';
        lAccount1.BillingPostalCode = '12341';
        lAccount1.BillingNumber__c = '12341';
        lAccount1.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Billing').getRecordTypeId();
        insert lAccount1;
        
        Account lAccount2 = new Account();
        lAccount2.Name = 'Teste2';
        lAccount2.ParentId = lAccount.Id;
        lAccount2.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Service').getRecordTypeId();
        lAccount2.ShippingStreet = 'Av. teste 2 ';
        lAccount2.ShippingPostalCode = '12342';
        lAccount2.ShippingNumber__c = '12342';
        insert lAccount2;
        
        Account lAccount3 = new Account();
        lAccount3.Name = 'Teste3';
        lAccount3.BillingAccountType__c = 'Fixa';
        lAccount3.ShippingStreet = 'Av. teste 3';
        lAccount3.ShippingPostalCode = '12343';
        lAccount3.ShippingNumber__c = '12343';
        lAccount3.ParentId = lAccount.Id;
        lAccount3.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Billing').getRecordTypeId();
        insert lAccount3;

        GeneralParam__c generalParam = new GeneralParam__c();
        generalParam.CitySpecial__c = 'BRASILIA-DF;PALMAS-TO';
        generalParam.CityBlockLot__c = 'BAURU-SP;PRESIDENTE EPITACIO-SP;PRIMAVERA-PE;PEDERNEIRAS-SP';
        insert generalParam;
        
        insert new Webservice__c(
            Name = 'GeographicAddressCallout',
            Endpoint__c = 'https://hmlapi.telefonicabigdata.com',
            SubscriptionKey__c = 'd1ca8d57a2984db88f01c9ce7b5862e2'
        );

        insert new Webservice__c(
            Name = 'GeographicAddressValidationCallout',
            Endpoint__c = 'https://hmlapi.telefonicabigdata.com',
            SubscriptionKey__c = 'd1ca8d57a2984db88f01c9ce7b5862e2'
        );

        insert new Webservice__c(
            Name = 'ServiceCoverageAvailabilityCallout',
            Endpoint__c = 'https://hmlapi.telefonicabigdata.com',
            SubscriptionKey__c = 'd1ca8d57a2984db88f01c9ce7b5862e2'
        );

        WebServiceTestFactory.start().authOAuthProvider().create();
    }

    @isTest
    public static void getAddressList (){
        Account ltAccount = [SELECT Id FROM Account WHERE RecordType.Name = 'Consumer' LIMIT 1];
        Test.startTest();
        List<ServiceAvailabilityController.AddressItem> returnList = ServiceAvailabilityController.getAddressList(ltAccount.Id);
        System.debug(returnList);
        Test.stopTest();
        
        System.assert(returnList.size() > 0, 'Address List successfully get.');
    }
    
    @isTest
    public static void  getAccountId (){
        Account ltAccount = [SELECT Id FROM Account LIMIT 1];
        Account acctFound = ServiceAvailabilityController.getAccountId(ltAccount.Id);
        System.assertEquals(ltAccount.Id, acctFound.Id, 'Account Id successfully matched.');
    }

    @isTest
    public static void getGeographicAddressWithFreeText(){
        String zipCode = '04742060';
        String stNumber = '70';
        String freeText = 'ABC'; 
        String withFreeTextReturn;

        ServiceAvailabilityController serviceAvailability = new ServiceAvailabilityController();
        ServiceAvailabilityController.ServiceAvailabilityResponse response = new ServiceAvailabilityController.ServiceAvailabilityResponse();
        Test.startTest();
            Test.setMock(HttpCalloutMock.class, new ServiceAvailabilityGeographicAddressMock());
            response = ServiceAvailabilityController.getGeographicAddress(zipCode, stNumber, freeText);
            System.assertNotEquals(null, response.body, 'JSON String succesfully returned.');
        Test.stopTest();
    }

    @isTest
    public static void getGeographicAddressNoFreeText(){
        String zipCode = '04742060';
        String stNumber = '70';
        String freeText = ''; 
        String noFreeTextReturn;

        ServiceAvailabilityController serviceAvailability = new ServiceAvailabilityController();
        ServiceAvailabilityController.ServiceAvailabilityResponse response = new ServiceAvailabilityController.ServiceAvailabilityResponse();

        Test.startTest();
            Test.setMock(HttpCalloutMock.class, new ServiceAvailabilityGeographicAddressMock());
            response = ServiceAvailabilityController.getGeographicAddress(zipCode, stNumber, freeText);
            System.assertNotEquals(null, response.body, 'JSON String without freeText succesfully returned.');
        Test.stopTest();
    }

    @isTest
    public static void getGeographicAddressNoFreeTextWhithoutMock(){
        String zipCode = '04742060';
        String stNumber = '70';
        String freeText = ''; 
        String noFreeTextReturn;

        ServiceAvailabilityController serviceAvailability = new ServiceAvailabilityController();
        ServiceAvailabilityController.ServiceAvailabilityResponse response = new ServiceAvailabilityController.ServiceAvailabilityResponse();

        Test.startTest();
            response = ServiceAvailabilityController.getGeographicAddress(zipCode, stNumber, freeText);
            System.assertNotEquals(null, response.body, 'JSON String without freeText succesfully returned.');
        Test.stopTest();
    }

    @isTest
    public static void getGeographicAddressValidation(){
        String reqJson = '"{\"submittedGeographicAddress\":{\"id\":\"LM:04571000:::1376:::::::-46.6945653:-23.6085754:100:20210412182542\",\"freeText\":\"1376, AVENIDA ENGENHEIRO LUIZ CARLOS BERRINI, CIDADE MONCOES, SAO PAULO - SP\",\"country\":\"BR\",\"city\":\"SAO PAULO\",\"stateOrProvince\":\"SP\",\"locality\":\"CIDADE MONCOES\",\"postcode\":\"04571000\",\"streetType\":\"AVENIDA\",\"streetPrefix\":\"ENGENHEIRO\",\"streetName\":\"LUIZ CARLOS BERRINI\",\"streetNrFirst\":\"1376\",\"complementSummary\":{\"complement\":null},\"geographicLocation\":{\"geoJson\":{\"type\":\"Point\",\"coordinates\":[\"-46.694565\",\"-23.608576\"]}},\"systemOriginator\":\"LM\",\"database\":\"04571000\"}}"';
        String json;
        ServiceAvailabilityController serviceAvailability = new ServiceAvailabilityController();
        ServiceAvailabilityController.ServiceAvailabilityResponse response = new ServiceAvailabilityController.ServiceAvailabilityResponse();

        Test.startTest();
            Test.setMock(HttpCalloutMock.class, new ServiceAvailabilityAddressValidateMock());
            response = ServiceAvailabilityController.getGeographicAddressValidation(reqJson);
            System.assertNotEquals(null, response.body, 'JSON successfully retrieved.');
        Test.stopTest();
    }

    @isTest
    public static void getAddressCoverage(){
        String reqJson = '"{\"physicalResourceAvailability\":[{\"brazilianUrbanPropertyAddress\":\"{\\\"telephonicArea\\\":null,\\\"systemOriginator\\\":\\\"SAGRE\\\",\\\"streetType\\\":\\\"RUA\\\",\\\"streetPrefix\\\":null,\\\"streetNrFirst\\\":\\\"178\\\",\\\"streetName\\\":\\\"FAXINAL\\\",\\\"streetCode\\\":\\\"46566\\\",\\\"stateOrProvince\\\":\\\"PR\\\",\\\"postCode\\\":null,\\\"networkOwner\\\":\\\"VIVO2\\\",\\\"id\\\":\\\"SAGRE:46566\\\",\\\"database\\\":\\\"PR_CURITIBA\\\",\\\"country\\\":\\\"BR\\\",\\\"cnl\\\":\\\"41000\\\",\\\"city\\\":\\\"CURITIBA\\\",\\\"centralOffice\\\":null}\"}]}"';
        String json;
        ServiceAvailabilityController serviceAvailability = new ServiceAvailabilityController();
        ServiceAvailabilityController.ServiceAvailabilityResponse response = new ServiceAvailabilityController.ServiceAvailabilityResponse();

        Test.startTest();
            String payload = '{"validationResult":"SUCCESS","alternateGeographicAddress":[{"country":"BR","city":"SAO PAULO","stateOrProvince":"SP","streetType":"RUA","streetName":"TAUARI","streetNrFirst":"70","complementSummary":{"complement":[]},"geographicLocation":{"geoJson":{"type":"Point","coordinates":["-46.698963","-23.652172"]}},"systemOriginator":"SAGRE","database":"SP_SAO_PAULO","streetCode":"36479","cnl":"11000","networkOwner":"VIVO2","aliasedGeographicAddress":[{"id":"SAGRE:SP_SAO_PAULO:11000:36479:70:::::::-46.6989634:-23.6521729:200:20210414024102","country":"BR","city":"SAO PAULO","stateOrProvince":"SP","streetType":"RUA","streetName":"TAUARI","streetNrFirst":"70","complementSummary":{"complement":[]},"geographicLocation":{"uncertain":"66.72","geoJson":{"type":"Point","coordinates":["-46.698963","-23.652172"]}},"systemOriginator":"SAGRE","database":"SP_SAO_PAULO","streetCode":"36479","cnl":"11000","networkOwner":"VIVO2"}]},{"country":"BR","streetType":"RUA","streetName":"TAUARI","streetNrFirst":"70","complementSummary":{"complement":[]},"geographicLocation":{"geoJson":{"type":"Point","coordinates":["-46.69939","-23.652555"]}},"systemOriginator":"OSP","database":"TLF_BR_SPO_VM","streetCode":"252425","cnl":"11000","networkOwner":"VIVO1","telephonicArea":"AT","aliasedGeographicAddress":[{"id":"OSP:TLF_BR_SPO_VM:11000:252425:70:::::::-46.6993888:-23.6525554:200:20210414024103","country":"BR","streetType":"R.","streetName":"TAUARI","streetNrFirst":"70","complementSummary":{"complement":[]},"geographicLocation":{"uncertain":"6.74","geoJson":{"type":"Point","coordinates":["-46.69939","-23.652555"]}},"systemOriginator":"OSP","database":"TLF_BR_SPO_VM","streetCode":"252425","cnl":"11000","networkOwner":"VIVO1","telephonicArea":"AT"}]}],"state":"DONE"}';
            Test.setMock(HttpCalloutMock.class, new ServiceAvailabilityAddressCoverageMock());
            response = ServiceAvailabilityController.getAddressCoverage(reqJson);
            System.assertNotEquals(null, response.body, 'JSON successfully retrieved.');
        Test.stopTest();
    }

    @isTest
    public static void getAddressPicklistValues(){

        List<ServiceAvailabilityController.KeyValuePicklists> optionlist = new List<ServiceAvailabilityController.KeyValuePicklists>();  
        Test.startTest();
            optionlist = ServiceAvailabilityController.getAddressPicklistValues();
            System.assert(optionlist.size() > 0, 'Picklists successfully retrieved.');    
        Test.stopTest();
    }

    @isTest
    public static void getAddressSpecialCities(){
        
        List<String> ltSC = new List<String>();
        
        Test.startTest();
            ltSC = ServiceAvailabilityController.getAddressSpecialCities();
            System.assert(ltSC.size() > 0,'Special Cities successfully retrieved.');
        Test.stopTest();
    }

    @isTest
    public static void getAddressBlockLotCities(){
        List<String> ltBLC = new List<String>();  
        
        Test.startTest();
            ltBLC = ServiceAvailabilityController.getAddressBlockLotCities();
            System.assert(ltBLC.size() > 0, 'BlockLot City successfully retrieved.');
        Test.stopTest();
    }

}