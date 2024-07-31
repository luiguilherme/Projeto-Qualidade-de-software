@isTest
public with sharing class CaseManagementTest {
    @testSetup 
    static void setup(){
        insert new Webservice__c(
            Name = 'UserServiceUserProfileCallout',
            Endpoint__c  = 'https://api-hml.telefonica.com.br/userprofile/v4/',
            SubscriptionKey__c = 'd1ca8d57a2984db88f01c9ce7b5862e2',
            User__c ='UserMock'
        );
        WebServiceTestFactory.start().authOAuthProvider().create();

        Account accountRec = new Account();
        accountRec.Name = 'Test Account';
        accountRec.DocumentNumber__c = '1234';
        insert accountRec;

        Asset assetRec = new Asset();
        assetRec.AccountId = accountRec.Id;
        assetRec.Name = 'Test Asset';
        assetRec.MainProductDescription__c = 'Vivo Fibra';
        insert assetRec;

        Case caseRec = new Case();
        caseRec.RecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get(CasesMyRequestsB2C.CHARGE_OF_ADDRESS_RECORD_TYPE_API_NAME).getrecordTypeId();
        caseRec.Subject = 'Test Case';
        caseRec.Origin = 'URA';
        caseRec.Protocol__c = '1234';
        caseRec.Status =  'Em fila';
        caseRec.AccountId = accountRec.Id;
        caseRec.ComplainedAsset__c = assetRec.Id;
        insert caseRec;

        CaseDetail__c casedatail = new CaseDetail__c();
        casedatail.Case__c = caseRec.id;    
        casedatail.OrderNumber__c = '123456';
        casedatail.CEP__c = '123456';
        casedatail.Street__c = 'Rua teste';
        casedatail.AddresNumber__c = '253';
        casedatail.haveAddressNumber__c = false;
        casedatail.WithoutComplement__c = false;
        casedatail.Complement__c = 'teste';
        casedatail.ReferencePoint__c = 'teste';
        casedatail.Neighborhood__c = 'teste';
        casedatail.City__c = 'Rio de Janeiro';
        casedatail.State__c = 'Rio de Janeiro';
        casedatail.ModifyBillingAddress__c = false;
        casedatail.DateOption1__c  = Date.valueOf('2024-03-27');
        casedatail.PeriodOption1__c = 'Manhã, entre 08h e 12h';
        casedatail.DateOption2__c  = Date.valueOf('2024-03-30');
        casedatail.PeriodOption2__c = 'Tarde, entre 13h e 18h';
        casedatail.ScheduledDate__c  = Date.valueOf('2024-03-27');
        casedatail.ScheduledPeriod__c = 'Manhã, entre 08h e 12h';
        insert casedatail;

        CaseComment__c caseComent = new CaseComment__c();
        caseComent.ParentId__c = caseRec.id;
        caseComent.ViewDatetime__c = null;
        insert caseComent;
    }
    
    @isTest static void getCasessNotPrePaidAuthentic() {
        JWTUtilityTest.setPublicTestKey();
        Account acc = [SELECT Id FROM Account];
        acc.DocumentNumber__c = '63542141747';
        TriggerHandler.bypass('AccountTriggerHandler');
        update acc;
        TriggerHandler.clearbypass('AccountTriggerHandler');
        String jwt = JWTUtilityTest.createValidJWT();
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        
        req.requestURI = '/CaseManagement/v1/';
        req.httpMethod = 'GET';
        req.params.put('documentNumber', '63542141747');
        req.headers.put('x-Authorization', 'Bearer ' + jwt);
        RestContext.request = req;
        RestContext.response = res;
        
        Test.setMock(HttpCalloutMock.class, new UserProfileCalloutPessoaNotPrePaidMock());
        Test.startTest();
            CaseManagement.getCases();
            System.debug(res.responseBody.toString());
            GetCasesRequestWrapper responseReturn = (GetCasesRequestWrapper) Json.deserialize(res.responseBody.toString(),GetCasesRequestWrapper.class);
        Test.stopTest();
        Case caseRec = [SELECT Id FROM Case WHERE Subject = 'Test Case'];
        System.assertEquals(caseRec.id, responseReturn.cases[0].caseId ,'Case retornado com sucesso!' );
    }
        
    @isTest static void getCasesIdUrl() {
        JWTUtilityTest.setPublicTestKey();
        Account acc = [SELECT Id FROM Account];
        acc.DocumentNumber__c = '63542141747';
        TriggerHandler.bypass('AccountTriggerHandler');
        update acc;
        TriggerHandler.clearbypass('AccountTriggerHandler');

        String jwt = JWTUtilityTest.createValidJWT();
        Case caseRec = [SELECT Id FROM Case WHERE Subject = 'Test Case'];

        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();

        req.requestURI = '/CaseManagement/v1/'+caseRec.Id;
        req.headers.put('x-Authorization','Bearer ' + jwt);
        req.httpMethod = 'GET';
        req.params.put('documentNumber', '63542141747');
        RestContext.request = req;
        RestContext.response = res;
        
        Test.setMock(HttpCalloutMock.class, new UserProfileCalloutPessoaNotPrePaidMock());
        Test.startTest();
        CaseManagement.getCases();
        Test.stopTest();
        
        Assert.areEqual(200, res.statusCode);
    }

    @isTest static void getCasesFiltros() {
        JWTUtilityTest.setPublicTestKey();
        Account acc = [SELECT Id FROM Account];
        acc.DocumentNumber__c = '63542141747';
        TriggerHandler.bypass('AccountTriggerHandler');
        update acc;
        TriggerHandler.clearbypass('AccountTriggerHandler');
        String jwt = JWTUtilityTest.createValidJWT();

        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();

        req.requestURI = '/CaseManagement/v1/';
        req.httpMethod = 'GET';
        req.headers.put('x-Authorization','Bearer ' + jwt);
        req.addParameter('documentNumber','63542141747');
        String filterStatusValues = '\'Em andamento\',\'Concluída\',\'Expirada\'';
        req.addParameter('filterStatus', filterStatusValues);
        req.addParameter('orderStatus','Em andamento,Expirada,Concluída');     
        req.addParameter('initCreatedDate', '2024-01-01T00:00:00.000-00:00');
        req.addParameter('finalCreatedDate','2024-10-08T00:00:00.000-00:00');
        RestContext.request = req;
        RestContext.response = res;

        Test.setMock(HttpCalloutMock.class, new UserProfileCalloutPessoaNotPrePaidMock());
        Test.startTest();
        CaseManagement.getCases();
        GetCasesRequestWrapper responseReturn = (GetCasesRequestWrapper) Json.deserialize(res.responseBody.toString(),GetCasesRequestWrapper.class);
        Test.stopTest();
        Case caseRec = [SELECT Id FROM Case WHERE Subject = 'Test Case'];
        System.assertEquals(caseRec.id, responseReturn.cases[0].caseId,'Case retornado com sucesso!' );
    } 

    public static void getCasesTestForbidden(){     
        JWTUtilityTest.setPublicTestKey();  
        String jwt = JWTUtilityTest.createInvalidJWT();
        Map<String,String> headerMap = new Map<String,String>();
            
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();

        req.requestURI = '/CaseManagement/v1/';
        req.headers.put('x-Authorization','Bearer ' + jwt);
        req.addParameter('documentNumber','1234');
        req.httpMethod = 'GET';
        RestContext.request = req;
        RestContext.response = res;

        Test.startTest();
        CaseManagement.getCases();
        Test.stopTest();

        Test.setMock(HttpCalloutMock.class, new UserProfileCalloutPessoaNotPrePaidMock());
            
        System.assert(res.statusCode == 403);
    }

    @IsTest
    public static void insertCasesTestError(){
        JWTUtilityTest.setPublicTestKey();
        //Teste para validar a criação correta dos casos.
        CustomerInteractionTopicTree__c topicTree = new CustomerInteractionTopicTree__c(
            Name = 'Test With Omnitree',
            Active__c = true,
            GPSId__c = '',
            OperatorSegment__c = 'Gold',
            OmniTree__c = 'Mudança de Endereço > Fixa > Casa',
			Type__c = 'Palito'            
        );
        insert topicTree;

        String jwt = JWTUtilityTest.createValidJWT();
         Map<String,String> headerMap = new Map<String,String>();
                
         RestRequest request = new RestRequest();
         RestResponse res = new RestResponse();
         request.requestUri ='/CaseManagement/v1';
         request.httpMethod = 'POST';
         request.headers.put('x-Authorization','Bearer ' + jwt);
         request.requestBody = Blob.valueOf('{"accountRef":{"documentNumber":"63542141747"},"assetRef":{"externalId":"","payload":{"identifiers":["+5511972673497"],"start_date":"2011-03-14T23:00:00+01:00","subscription_type":"postpaid","product_type":"mobile","display_name":"Básico Funcional","status":"active","status_description":"Ativo","connection":{"downlink_mbps":"20MB","uplink_mbps":"10MB","type":"fiber"},"tags":["so:amdocs","colaborador","produto-avulso"],"descriptions":[{"text":"20MB"}]}},"caseRef":{"omniChannelStatus":"Em andamento","caseId":"0038L00000FNVNpQAP","status":"Cancelamento solicitado","contactPhone":"11972839102","recordTypeDevName":"ChangeOfAddress","protocol":"P00130421","topicTreeId":"' + String.valueOf(topicTree.Id) + '","origin":"URA","createDate":"2023-04-04T19:38:17.000+0000"},"caseDetailRef":{"recordTypeDevName":"ChangeOfAddress","orderNumber":"123123","cep":"08441-291","street":"Av Berrini","addresNumber":"12","haveAddressNumber":true,"withoutComplement":false,"complement":"Andar 13","referencePoint":"Perto da Berrini","neighborhood":"Berrini","city":"São Paulo","state":"São Paulo","modifyBillingAddress":false,"firstDateOption":"2024-01-12T00:00:00.000Z","firstPeriodOption":"Tarde, entre 13h e 18h","secondDateOption":"2024-01-15T00:00:00.000Z","secondPeriodOption":"Manhã","scheduledDate":"2024-01-18T00:00:00.000Z","scheduledPeriod":"Manhã, entre 08h e 12h"},"fileLinksRef":[{"idGedoc":"{ID DO ARQUIVO NO GEDOC}","fileDescription":"{DESCRIÇÃO DO ARQUIVO PARA SER EXIBIDO}"}]}');
         RestContext.request = request;
         RestContext.response = res;

         Account accountRec = new Account();
         accountRec.Name = 'Test Account';
         accountRec.DocumentNumber__c = '63542141747';
         insert accountRec;

         
        Contact newContact = new Contact();
        newContact.LastName = 'teste';
        newContact.ExternalId__c = '63542141747';
        insert newContact;
        Test.setMock(HttpCalloutMock.class, new UserProfileCalloutPessoaNotPrePaidMock());


        Test.startTest();
        CaseManagement.createCase();
        test.stopTest();
         
        System.assert(res.statusCode == 500);
    }

    @IsTest
    public static void testAssetCreation(){
        JWTUtilityTest.setPublicTestKey();
        //Teste para validar se a criação dos assets está correta e nenhum asset está sendo deletado.
        CustomerInteractionTopicTree__c topicTree = new CustomerInteractionTopicTree__c(
            Name = 'Test With Omnitree',
            Active__c = true,
            GPSId__c = '',
            OperatorSegment__c = 'Gold',
            OmniTree__c = 'Mudança de Endereço > Fixa > Casa',
			Type__c = 'Palito'            
        );
        insert topicTree;

        Account accountRec = new Account();
        accountRec.Name = 'Test Account';
        accountRec.DocumentNumber__c = '63542141747';
        insert accountRec;

        Contact newContact = new Contact();
        newContact.LastName = 'teste';
        newContact.ExternalId__c = '63542141747';
        insert newContact;

        Asset assetRec = new Asset();
        assetRec.AccountId = accountRec.Id;
        assetRec.Name = 'Test Asset';
        assetRec.MainProductDescription__c = 'Vivo Fibra';
        insert assetRec;

        List<Asset> listAssetsBefore = [SELECT Id FROM Asset];

        String jwt = JWTUtilityTest.createValidJWT();
        Map<String,String> headerMap = new Map<String,String>();
                
        RestRequest request = new RestRequest();
        RestResponse res = new RestResponse();
        request.requestUri ='/CaseManagement/v1';
        request.httpMethod = 'POST';
        request.headers.put('x-Authorization','Bearer ' + jwt);
        request.requestBody = Blob.valueOf('{"accountRef":{"documentNumber":"63542141747"},"assetRef":{"externalId":"","payload":{"identifiers":["+5511972673497"],"start_date":"2011-03-14T23:00:00+01:00","subscription_type":"postpaid","product_type":"mobile","display_name":"Básico Funcional","status":"active","status_description":"Ativo","connection":{"downlink_mbps":"20MB","uplink_mbps":"10MB","type":"fiber"},"tags":["so:amdocs","colaborador","produto-avulso"],"descriptions":[{"text":"20MB"}]}},"caseRef":{"omniChannelStatus":"Em andamento","caseId":"0038L00000FNVNpQAP","status":"Cancelamento solicitado","contactPhone":"11972839102","recordTypeDevName":"ChangeOfAddress","protocol":"P00130421","topicTreeId":"' + String.valueOf(topicTree.Id) + '","origin":"App Vivo","createDate":"2023-04-04T19:38:17.000+0000"},"caseDetailRef":{"recordTypeDevName":"ChangeOfAddress","orderNumber":"123123","cep":"08441-291","street":"Av Berrini","addresNumber":"12","haveAddressNumber":true,"withoutComplement":false,"complement":"Andar 13","referencePoint":"Perto da Berrini","neighborhood":"Berrini","city":"São Paulo","state":"São Paulo","modifyBillingAddress":false,"firstDateOption":"2024-01-12T00:00:00.000Z","firstPeriodOption":"Tarde, entre 13h e 18h","secondDateOption":"2024-01-15T00:00:00.000Z","secondPeriodOption":"Manhã, entre 08h e 12h","scheduledDate":"2024-01-18T00:00:00.000Z","scheduledPeriod":"Manhã, entre 08h e 12h"},"fileLinksRef":[{"idGedoc":"{ID DO ARQUIVO NO GEDOC}","fileDescription":"{DESCRIÇÃO DO ARQUIVO PARA SER EXIBIDO}"}]}');
        RestContext.request = request;
        RestContext.response = res;
        Test.setMock(HttpCalloutMock.class, new UserProfileCalloutPessoaNotPrePaidMock());

        Test.startTest();
        CaseManagement.createCase();
        Test.stopTest();
         
        List<Asset> listAssetsAfter = [SELECT Id FROM Asset];
        System.assertEquals(listAssetsBefore.size(), listAssetsAfter.size() - 1);
    }
  
    @IsTest
    public static void insertCasesTest(){
        JWTUtilityTest.setPublicTestKey();
        //Teste para validar a criação correta dos casos.
        CustomerInteractionTopicTree__c topicTree = new CustomerInteractionTopicTree__c(
            Name = 'Test With Omnitree',
            Active__c = true,
            GPSId__c = '',
            OperatorSegment__c = 'Gold',
            OmniTree__c = 'Mudança de Endereço > Fixa > Casa',
			Type__c = 'Palito'            
        );
        insert topicTree;

        String jwt = JWTUtilityTest.createValidJWT();
        Map<String,String> headerMap = new Map<String,String>();
                
        RestRequest request = new RestRequest();
        RestResponse res = new RestResponse();
        request.requestUri ='/CaseManagement/v1';
        request.httpMethod = 'POST';
        request.headers.put('x-Authorization','Bearer ' + jwt);
        request.requestBody = Blob.valueOf('{"accountRef":{"documentNumber":"63542141747"},"assetRef":{"externalId":"","payload":{"identifiers":["+5511972673497"],"start_date":"2011-03-14T23:00:00+01:00","subscription_type":"postpaid","product_type":"mobile","display_name":"Básico Funcional","status":"active","status_description":"Ativo","connection":{"downlink_mbps":"20MB","uplink_mbps":"10MB","type":"fiber"},"tags":["so:amdocs","colaborador","produto-avulso"],"descriptions":[{"text":"20MB"}]}},"caseRef":{"omniChannelStatus":"Em andamento","caseId":"0038L00000FNVNpQAP","status":"Cancelamento solicitado","contactPhone":"11972839102","recordTypeDevName":"ChangeOfAddress","protocol":"P00130421","topicTreeId":"' + String.valueOf(topicTree.Id) + '","origin":"App Vivo","createDate":"2023-04-04T19:38:17.000+0000"},"caseDetailRef":{"recordTypeDevName":"ChangeOfAddress","orderNumber":"123123","cep":"08441-291","street":"Av Berrini","addresNumber":"12","haveAddressNumber":true,"withoutComplement":false,"complement":"Andar 13","referencePoint":"Perto da Berrini","neighborhood":"Berrini","city":"São Paulo","state":"São Paulo","modifyBillingAddress":false,"firstDateOption":"2024-01-12T00:00:00.000Z","firstPeriodOption":"Tarde, entre 13h e 18h","secondDateOption":"2024-01-15T00:00:00.000Z","secondPeriodOption":"Manhã, entre 08h e 12h","scheduledDate":"2024-01-18T00:00:00.000Z","scheduledPeriod":"Manhã, entre 08h e 12h"},"fileLinksRef":[{"idGedoc":"{ID DO ARQUIVO NO GEDOC}","fileDescription":"{DESCRIÇÃO DO ARQUIVO PARA SER EXIBIDO}"}]}');
        RestContext.request = request;
        RestContext.response = res;

        Account accountRec = new Account();
        accountRec.Name = 'Test Account';
        accountRec.DocumentNumber__c = '63542141747';
        insert accountRec;

        Contact newContact = new Contact();
        newContact.LastName = 'teste';
        newContact.ExternalId__c = '63542141747';
        insert newContact;

        Test.setMock(HttpCalloutMock.class, new UserProfileCalloutPessoaNotPrePaidMock());
         
        Test.startTest();
        CaseManagement.createCase();
        Test.stopTest();
         
        System.assert(res.statusCode == 200);
    }

    @IsTest
    public static void insertCasesTestForbidden(){
        JWTUtilityTest.setPublicTestKey();
        //Teste para validar a criação correta dos casos.
        CustomerInteractionTopicTree__c topicTree = new CustomerInteractionTopicTree__c(
            Name = 'Test With Omnitree',
            Active__c = true,
            GPSId__c = '',
            OperatorSegment__c = 'Gold',
            OmniTree__c = 'Mudança de Endereço > Fixa > Casa',
			Type__c = 'Palito'            
        );
        insert topicTree;
        
        String jwt = JWTUtilityTest.createInvalidJWT();
        Map<String,String> headerMap = new Map<String,String>();
                
        RestRequest request = new RestRequest();
        RestResponse res = new RestResponse();
        request.requestUri ='/CaseManagement/v1';
        request.httpMethod = 'POST';
        request.headers.put('x-Authorization','Bearer ' + jwt);
        request.requestBody = Blob.valueOf('{"accountRef":{"documentNumber":"63542141747"},"assetRef":{"externalId":"","payload":{"identifiers":["+5511972673497"],"start_date":"2011-03-14T23:00:00+01:00","subscription_type":"postpaid","product_type":"mobile","display_name":"Básico Funcional","status":"active","status_description":"Ativo","connection":{"downlink_mbps":"20MB","uplink_mbps":"10MB","type":"fiber"},"tags":["so:amdocs","colaborador","produto-avulso"],"descriptions":[{"text":"20MB"}]}},"caseRef":{"omniChannelStatus":"Em andamento","caseId":"0038L00000FNVNpQAP","status":"Cancelamento solicitado","contactPhone":"11972839102","recordTypeDevName":"ChangeOfAddress","protocol":"P00130421","topicTreeId":"' + String.valueOf(topicTree.Id) + '","origin":"URA","createDate":"2023-04-04T19:38:17.000+0000"},"caseDetailRef":{"recordTypeDevName":"ChangeOfAddress","orderNumber":"123123","cep":"08441-291","street":"Av Berrini","addresNumber":"12","haveAddressNumber":true,"withoutComplement":false,"complement":"Andar 13","referencePoint":"Perto da Berrini","neighborhood":"Berrini","city":"São Paulo","state":"São Paulo","modifyBillingAddress":false,"firstDateOption":"2024-01-12T00:00:00.000Z","firstPeriodOption":"Tarde, entre 13h e 18h","secondDateOption":"2024-01-15T00:00:00.000Z","secondPeriodOption":"Manhã, entre 08h e 12h","scheduledDate":"2024-01-18T00:00:00.000Z","scheduledPeriod":"Manhã, entre 08h e 12h"},"fileLinksRef":[{"idGedoc":"{ID DO ARQUIVO NO GEDOC}","fileDescription":"{DESCRIÇÃO DO ARQUIVO PARA SER EXIBIDO}"}]}');
        RestContext.request = request;
        RestContext.response = res;

        Account accountRec = new Account();
        accountRec.Name = 'Test Account';
        accountRec.DocumentNumber__c = '63542141747';
        insert accountRec;

        Contact newContact = new Contact();
        newContact.LastName = 'teste';
        newContact.ExternalId__c = '63542141747';
        insert newContact;

        Test.setMock(HttpCalloutMock.class, new UserProfileCalloutPessoaNotPrePaidMock());
         
        Test.startTest();
        CaseManagement.createCase();
        test.stopTest();
         
        System.assert(res.statusCode == 403);
    }
    
    @isTest
    public static void updateCaseTest() {
        Account accountRec = new Account();
        accountRec.Name = 'Test Account';
        accountRec.DocumentNumber__c = '63542141747';
        insert accountRec;
  
        Asset assetRec = new Asset();
        assetRec.AccountId = accountRec.Id;
        assetRec.Name = 'Test Asset';
        assetRec.MainProductDescription__c = 'Vivo Fibra';
        insert assetRec;

        Case caseRec = new Case();
        caseRec.Subject = 'Test Case2';
        caseRec.Origin = 'URA';
        caseRec.Protocol__c = '1234';
        caseRec.Status =  'Em fila';
        caseRec.AccountId = accountRec.Id;
        caseRec.ComplainedAsset__c = assetRec.Id;
        caseRec.DocumentNumber__c = '63542141747';
        insert caseRec;

        JWTUtilityTest.setPublicTestKey();
    
        String jwt = JWTUtilityTest.createValidJWT();
        String statusBefore = caseRec.Status;

        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
    
        req.requestURI = '/CaseManagement/v1/'+caseRec.Id;
        req.headers.put('x-Authorization','Bearer ' + jwt);
        req.httpMethod = 'PATCH';
        RestContext.request = req;
        RestContext.response = res;
        req.requestBody = Blob.valueOf('{"status": "Cancelamento solicitado"}');
        
        Test.setMock(HttpCalloutMock.class, new UserProfileCalloutPessoaNotPrePaidMock());
        Test.startTest();
        CaseManagement.updateCase();
        Test.stopTest();

        caseRec = [SELECT Id, Status FROM Case WHERE Subject = 'Test Case2'];
        String statusAfter = caseRec.Status;
        
        System.assert(statusAfter == 'Cancelamento solicitado', 'O status do caso não foi alterado corretamente.');
        System.assert(res.statuscode == 200, 'O status da requisição está incorreto');
    }

    @isTest
    public static void updateCaseTestInvalidStatus() {
        Account accountRec = new Account();
        accountRec.Name = 'Test Account';
        accountRec.DocumentNumber__c = '63542141747';
        insert accountRec;
  
        Asset assetRec = new Asset();
        assetRec.AccountId = accountRec.Id;
        assetRec.Name = 'Test Asset';
        assetRec.MainProductDescription__c = 'Vivo Fibra';
        insert assetRec;

        Case caseRec = new Case();
        caseRec.Subject = 'Test Case2';
        caseRec.Origin = 'URA';
        caseRec.Protocol__c = '1234';
        caseRec.Status =  'Em fila';
        caseRec.AccountId = accountRec.Id;
        caseRec.ComplainedAsset__c = assetRec.Id;
        caseRec.DocumentNumber__c = '63542141747';
        insert caseRec;

        JWTUtilityTest.setPublicTestKey();
    
        String jwt = JWTUtilityTest.createValidJWT();
        String statusBefore = caseRec.Status;

        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
    
        req.requestURI = '/CaseManagement/v1/'+caseRec.Id;
        req.headers.put('x-Authorization','Bearer ' + jwt);
        req.httpMethod = 'PATCH';
        RestContext.request = req;
        RestContext.response = res;
        req.requestBody = Blob.valueOf('{"status": "Expirado"}');
        
        Test.setMock(HttpCalloutMock.class, new UserProfileCalloutPessoaNotPrePaidMock());
        Test.startTest();
        CaseManagement.updateCase();
        Test.stopTest();

        caseRec = [SELECT Id, Status FROM Case WHERE Subject = 'Test Case2'];
        String statusAfter = caseRec.Status;
        
        System.assert(res.statusCode == 400, 'O status da requisição está incorreto.');
        System.assertEquals(statusBefore, statusAfter, 'O status foi alterado indevidamente.');
    }

    @IsTest
    public static void creatingACaseAlsoInsertsCustomerInteractionAndCustomerInteractionTopicTest() {
        JWTUtilityTest.setPublicTestKey();
        //Teste para validar a criação correta dos casos.
        CustomerInteractionTopicTree__c topicTree = new CustomerInteractionTopicTree__c(
            Name = 'Test With Omnitree',
            Active__c = true,
            GPSId__c = '',
            OperatorSegment__c = 'Gold',
            OmniTree__c = 'Mudança de Endereço > Fixa > Casa',
			Type__c = 'Palito'            
        );
        insert topicTree;

        String jwt = JWTUtilityTest.createValidJWT();
        Map<String,String> headerMap = new Map<String,String>();
                
        RestRequest request = new RestRequest();
        RestResponse response = new RestResponse();
        request.requestUri ='/CaseManagement/v1';
        request.httpMethod = 'POST';
        request.headers.put('x-Authorization','Bearer ' + jwt);
        request.requestBody = Blob.valueOf('{"accountRef":{"documentNumber":"63542141747"},"assetRef":{"externalId":"","payload":{"identifiers":["+5511972673497"],"start_date":"2011-03-14T23:00:00+01:00","subscription_type":"postpaid","product_type":"mobile","display_name":"Básico Funcional","status":"active","status_description":"Ativo","connection":{"downlink_mbps":"20MB","uplink_mbps":"10MB","type":"fiber"},"tags":["so:amdocs","colaborador","produto-avulso"],"descriptions":[{"text":"20MB"}]}},"caseRef":{"omniChannelStatus":"Em andamento","caseId":"0038L00000FNVNpQAP","status":"Cancelamento solicitado","contactPhone":"11972839102","recordTypeDevName":"ChangeOfAddress","protocol":"P00130421","topicTreeId":"' + String.valueOf(topicTree.Id) + '","origin":"App Vivo","createDate":"2023-04-04T19:38:17.000+0000"},"caseDetailRef":{"recordTypeDevName":"ChangeOfAddress","orderNumber":"123123","cep":"08441-291","street":"Av Berrini","addresNumber":"12","haveAddressNumber":true,"withoutComplement":false,"complement":"Andar 13","referencePoint":"Perto da Berrini","neighborhood":"Berrini","city":"São Paulo","state":"São Paulo","modifyBillingAddress":false,"firstDateOption":"2024-01-12T00:00:00.000Z","firstPeriodOption":"Tarde, entre 13h e 18h","secondDateOption":"2024-01-15T00:00:00.000Z","secondPeriodOption":"Manhã, entre 08h e 12h","scheduledDate":"2024-01-18T00:00:00.000Z","scheduledPeriod":"Manhã, entre 08h e 12h"},"fileLinksRef":[{"idGedoc":"{ID DO ARQUIVO NO GEDOC}","fileDescription":"{DESCRIÇÃO DO ARQUIVO PARA SER EXIBIDO}"}]}');
        RestContext.request = request;
        RestContext.response = response;

        Account accountRec = new Account();
        accountRec.Name = 'Test Account';
        accountRec.DocumentNumber__c = '63542141747';
        insert accountRec;

        Contact newContact = new Contact();
        newContact.LastName = 'teste';
        newContact.ExternalId__c = '63542141747';
        insert newContact;

        Test.setMock(HttpCalloutMock.class, new UserProfileCalloutPessoaNotPrePaidMock());
         
        Test.startTest();
        CaseManagement.createCase();
        Test.stopTest();
                
        CaseManagement.ResponseWrapper responseBody = (CaseManagement.ResponseWrapper) Json.deserialize(response.responseBody.toString(), CaseManagement.ResponseWrapper.class);

        String caseId = responseBody.caseRef.Id;

        Case newCase = [SELECT Id, CustomerInteractionId__c FROM Case WHERE Id = :caseId];

        List<vlocity_cmt__CustomerInteraction__c> customerInteractions = [SELECT Id FROM vlocity_cmt__CustomerInteraction__c WHERE Id = :newCase.CustomerInteractionId__c];

        List<vlocity_cmt__CustomerInteractionTopic__c> customerInteractionTopics = [SELECT Id FROM vlocity_cmt__CustomerInteractionTopic__c WHERE vlocity_cmt__CaseId__c = :caseId];
        
        Assert.areEqual(1, customerInteractions.size(), 'É esperado a criação de um Registro de vlocity_cmt__CustomerInteraction__c');

        Assert.areEqual(1, customerInteractionTopics.size(), 'É esperado a criação de um Registro de vlocity_cmt__CustomerInteractionTopic__c');
    }
}