@isTest
public with sharing class CaseCommentManagementTest {
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
    public static void getCaseCommentsEmpty(){
        JWTUtilityTest.setPublicTestKey();
        String jwt = JWTUtilityTest.createValidJWT();
        Map<String,String> headerMap = new Map<String,String>();
        account accountMock = DataFactory.createAccount();
        accountMock.documentNumber__c = '63542141747';
        insert accountMock;
        
        Case casemock = DataFactory.createCase('ChangeOfAddress', 'Subject Mock', 'descriptionMock');
        caseMock.accountid = accountMock.id;
        insert caseMock;
     
        RestRequest request = new RestRequest();
        RestResponse res = new RestResponse();
        request.requestUri ='/CaseCommentManagement/v1/';
        request.httpMethod = 'GET';
        request.headers.put('x-Authorization','Bearer ' + jwt);
        request.addParameter('caseId',caseMock.id);
        RestContext.request = request;
        RestContext.response = res;
       
        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new UserProfileCalloutPessoaNotPrePaidMock());
        CaseCommentManagement.getCaseComments();
        test.stopTest();
        
        System.assertEquals(res.statuscode, 200);
    }

    @isTest
    public static void getCaseCommentsNotPrePaidAuthentic(){
        JWTUtilityTest.setPublicTestKey();
        String jwt = JWTUtilityTest.createValidJWT();
        Map<String,String> headerMap = new Map<String,String>();
        account accountMock = DataFactory.createAccount();
        accountMock.documentNumber__c = '63542141747';
        insert accountMock;
        
        Case casemock = DataFactory.createCase('ChangeOfAddress', 'Subject Mock', 'descriptionMock');
        caseMock.accountid = accountMock.id;
        insert caseMock;
        
        CaseComment__c caseCommentMock =  new CaseComment__c(Comment__c='Comentário mock',IDGedoc__c='IDGedoc Mock',parentId__c=casemock.id);
        insert caseCommentMock;
        
        
        RestRequest request = new RestRequest();
        RestResponse res = new RestResponse();
        request.requestUri ='/CaseCommentManagement/v1/';
        request.httpMethod = 'GET';
        request.headers.put('x-Authorization','Bearer ' + jwt);
        request.addParameter('caseId',caseMock.id);
        RestContext.request = request;
        RestContext.response = res;
       
        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new UserProfileCalloutPessoaNotPrePaidMock());
        CaseCommentManagement.getCaseComments();
        CaseCommentManagement.GetCasesCommentsResponseWrapper responseReturn = (CaseCommentManagement.GetCasesCommentsResponseWrapper) Json.deserialize(res.responseBody.toString(),CaseCommentManagement.GetCasesCommentsResponseWrapper.class);
        test.stopTest();
        
        System.debug(res.statuscode);
        System.assertEquals(caseCommentMock.id, responseReturn.caseCommentRef[0].id);
    }
   
    @IsTest
    public static void getCaseCommentsNotAuthentic(){
         JWTUtilityTest.setPublicTestKey();
         String jwt = JWTUtilityTest.createinValidJWT();
         Map<String,String> headerMap = new Map<String,String>();
         account accountMock = DataFactory.createAccount();
         accountMock.documentNumber__c = '123456';
         insert accountMock;
        
         Case casemock = DataFactory.createCase('ChangeOfAddress', 'Subject Mock', 'descriptionMock');
         caseMock.AccountId = accountMock.id;
         insert caseMock;
         
         CaseComment__c caseCommentMock =  new CaseComment__c(Comment__c='Comentário mock',IDGedoc__c='IDGedoc Mock',parentId__c=casemock.id);
         insert caseCommentMock;
         
         
         RestRequest request = new RestRequest();
         RestResponse res = new RestResponse();
         request.requestUri ='/CaseCommentManagement/v1/';
         request.httpMethod = 'GET';
         request.headers.put('x-Authorization','Bearer ' + jwt);
         request.addParameter('caseId',caseMock.id);
         RestContext.request = request;
         RestContext.response = res;
        
         
         Test.startTest();
         Test.setMock(HttpCalloutMock.class, new UserProfileCalloutPessoaNotPrePaidMock());
         CaseCommentManagement.getCaseComments();
         test.stopTest();
         
         System.assert(res.statusCode==401,'O usuário não era proprietario do produto  mas conseguiu realizar a operação');

    }

    @IsTest
    public static void upsertCaseCommentTestInsertSucess(){
         JWTUtilityTest.setPublicTestKey();
         String jwt = JWTUtilityTest.createValidJWT();
         Map<String,String> headerMap = new Map<String,String>();
         account accountMock = DataFactory.createAccount();
         accountMock.documentNumber__c = '63542141747';
         insert accountMock;
        
         Case casemock = DataFactory.createCase('ChangeOfAddress', 'Subject Mock', 'descriptionMock');
         caseMock.AccountId = accountMock.id;
         insert caseMock;
         
         CaseComment__c caseCommentMock =  new CaseComment__c(Comment__c='Comentário mock',IDGedoc__c='IDGedoc Mock',parentId__c=casemock.id);
         insert caseCommentMock;
         
         
         RestRequest request = new RestRequest();
         RestResponse res = new RestResponse();
         request.requestUri ='/CaseCommentManagement/v1/';
         request.httpMethod = 'GET';
         request.headers.put('x-Authorization','Bearer ' + jwt);
         request.addParameter('caseId',caseMock.id);
         request.requestBody = Blob.valueOf('{"caseCommentRef":[{"comment":"Bom dia! Quero trocar meu endereçode instalação.","idGedoc":"{ID DO ARQUIVO NO GEDOC}","origin":"","viewDateTime":"2024-02-23T14:25"}],"caseId":'+'"'+casemock.id+'"'+',"fileLinksRef":[{"fileDescription":"{DESCRIÇÃO DO ARQUIVO PARA SER EXIBIDO}","idGedoc":"{ID DO ARQUIVO NO GEDOC}"}]}');
         RestContext.request = request;
         RestContext.response = res;
        
         
         Test.startTest();
         Test.setMock(HttpCalloutMock.class, new UserProfileCalloutPessoaNotPrePaidMock());
         CaseCommentManagement.upsertCaseComment();
         test.stopTest();
         
         
         System.assert(res.statusCode == 200);

    }

    @IsTest
    public static void upsertCaseCommentTestFail(){
         JWTUtilityTest.setPublicTestKey();
         String jwt = JWTUtilityTest.createInValidJWT();
         Map<String,String> headerMap = new Map<String,String>();
         account accountMock = DataFactory.createAccount();
         accountMock.documentNumber__c = '128345';
         insert accountMock;
        
         Case casemock = DataFactory.createCase('ChangeOfAddress', 'Subject Mock', 'descriptionMock');
         caseMock.AccountId = accountMock.id;
         insert caseMock;
         
         CaseComment__c caseCommentMock =  new CaseComment__c(Comment__c='Comentário mock',IDGedoc__c='IDGedoc Mock',parentId__c=casemock.id);
         insert caseCommentMock;
         
         
         RestRequest request = new RestRequest();
         RestResponse res = new RestResponse();
         request.requestUri ='/CaseCommentManagement/v1/';
         request.httpMethod = 'GET';
         request.headers.put('x-Authorization','Bearer ' + jwt);
         request.addParameter('caseId',caseMock.id);
         request.requestBody = Blob.valueOf('{"caseCommentRef":[{"comment":"Bom dia! Quero trocar meu endereçode instalação.","idGedoc":"{ID DO ARQUIVO NO GEDOC}","origin":"","viewDateTime":"2024-02-23T14:25"}],"caseId":'+'"'+'123456'+'"'+',"fileLinksRef":[{"fileDescription":"{DESCRIÇÃO DO ARQUIVO PARA SER EXIBIDO}","idGedoc":"{ID DO ARQUIVO NO GEDOC}"}]}');
         RestContext.request = request;
         RestContext.response = res;
        
         
         Test.startTest();
         Test.setMock(HttpCalloutMock.class, new UserProfileCalloutPessoaNotPrePaidMock());
         CaseCommentManagement.upsertCaseComment();
         test.stopTest();
         List<CaseComment__c> caseComentList = [SELECT Id, ParentId__c, Comment__c, Origin__c, ViewDatetime__c, CreatedDate,IDGedoc__c FROM CaseComment__c];
         
         System.assert(res.statusCode == 401);

    }

    @IsTest
    public static void upsertCaseCommentTestUpdateSucess(){
         JWTUtilityTest.setPublicTestKey();
         String jwt = JWTUtilityTest.createValidJWT();
         Map<String,String> headerMap = new Map<String,String>();
         
         account accountMock = DataFactory.createAccount();
         accountMock.documentNumber__c = '63542141747';
         insert accountMock;
        
         Case casemock = DataFactory.createCase('ChangeOfAddress', 'Subject Mock', 'descriptionMock');
         caseMock.accountId = accountMock.id;
         insert caseMock;
         
         CaseComment__c caseCommentMock =  new CaseComment__c(Comment__c='Comentário mock',IDGedoc__c='IDGedoc Mock',parentId__c=casemock.id);
         insert caseCommentMock;
         
         
         RestRequest request = new RestRequest();
         RestResponse res = new RestResponse();
         request.requestUri ='/CaseCommentManagement/v1/';
         request.httpMethod = 'GET';
         request.headers.put('x-Authorization','Bearer ' + jwt);
         request.addParameter('caseId',caseMock.id);
         request.requestBody = Blob.valueOf('{"caseCommentRef":[{"comment":"Bom dia! Quero trocar meu endereçode instalação.","id":"'+caseCommentMock.id+'","idGedoc":"{ID DO ARQUIVO NO GEDOC}","origin":"","viewDateTime":"2024-02-23T14:25"}],"caseId":'+'"'+casemock.id+'"'+',"fileLinksRef":[{"fileDescription":"{DESCRIÇÃO DO ARQUIVO PARA SER EXIBIDO}","idGedoc":"{ID DO ARQUIVO NO GEDOC}"}]}');
         RestContext.request = request;
         RestContext.response = res;
        
         
         Test.startTest();
         Test.setMock(HttpCalloutMock.class, new UserProfileCalloutPessoaNotPrePaidMock());
         CaseCommentManagement.upsertCaseComment();
         test.stopTest();
         List<CaseComment__c> caseComentList = [SELECT Id, ParentId__c, Comment__c, Origin__c, ViewDatetime__c, CreatedDate,IDGedoc__c FROM CaseComment__c];
         
         System.assert(res.statusCode == 200);
         System.assert(caseComentList[0].Comment__c == 'Bom dia! Quero trocar meu endereçode instalação.','O comentário não foi atualizado');   
         System.assert(caseComentList.size() == 1,'Foi criado mais um registro ao invés de atualizar o existente');

    }


    @IsTest
    public static void upsertCaseCommentTestInsertFileLinkSucess(){
         JWTUtilityTest.setPublicTestKey();
         String jwt = JWTUtilityTest.createValidJWT();
         Map<String,String> headerMap = new Map<String,String>();
        
         account accountMock = DataFactory.createAccount();
         accountMock.documentNumber__c = '63542141747';
         insert accountMock;
        
         Case casemock = DataFactory.createCase('ChangeOfAddress', 'Subject Mock', 'descriptionMock');
         caseMock.accountId = accountMock.id;
         insert caseMock;
         
         CaseComment__c caseCommentMock =  new CaseComment__c(Comment__c='Comentário mock',IDGedoc__c='IDGedoc Mock',parentId__c=casemock.id);
         insert caseCommentMock;
         
         
         RestRequest request = new RestRequest();
         RestResponse res = new RestResponse();
         request.requestUri ='/CaseCommentManagement/v1/';
         request.httpMethod = 'GET';
         request.headers.put('x-Authorization','Bearer ' + jwt);
         request.addParameter('caseId',caseMock.id);
         request.requestBody = Blob.valueOf('{"caseCommentRef":[{"comment":"Bom dia! Quero trocar meu endereçode instalação.","idGedoc":"{ID DO ARQUIVO NO GEDOC}","origin":"","viewDateTime":"2024-02-23T14:25"}],"caseId":'+'"'+casemock.id+'"'+',"fileLinksRef":[{"fileDescription":"{DESCRIÇÃO DO ARQUIVO PARA SER EXIBIDO}","idGedoc":"{ID DO ARQUIVO NO GEDOC}"}]}');
         RestContext.request = request;
         RestContext.response = res;
        
         
         Test.startTest();
         Test.setMock(HttpCalloutMock.class, new UserProfileCalloutPessoaNotPrePaidMock());
         CaseCommentManagement.upsertCaseComment();
         test.stopTest();
         filelink__c teste = [Select id from fileLink__c limit 1 ];
         
         
         System.assert(res.statusCode == 200);
         System.assert(teste != null,'Não foi criado o fileLink__c');

         
    }

    @IsTest
    public static void upsertCaseCommentTestUpdateFileLinkSucess(){
         JWTUtilityTest.setPublicTestKey();
         String jwt = JWTUtilityTest.createValidJWT();
         Map<String,String> headerMap = new Map<String,String>();

         account accountMock = DataFactory.createAccount();
         accountMock.documentNumber__c = '63542141747';
         insert accountMock;
        
         Case casemock = DataFactory.createCase('ChangeOfAddress', 'Subject Mock', 'descriptionMock');
         caseMock.accountID = accountMock.id;
         insert caseMock;
         
         CaseComment__c caseCommentMock =  new CaseComment__c(Comment__c='Comentário mock',IDGedoc__c='IDGedoc Mock',parentId__c=casemock.id);
         insert caseCommentMock;
         
         
         RestRequest request = new RestRequest();
         RestResponse res = new RestResponse();
         request.requestUri ='/CaseCommentManagement/v1/';
         request.httpMethod = 'GET';
         request.headers.put('x-Authorization','Bearer ' + jwt);
         request.addParameter('caseId',caseMock.id);
         request.requestBody = Blob.valueOf('{"caseCommentRef":[{"comment":"Bom dia! Quero trocar meu endereçode instalação.","idGedoc":"{ID DO ARQUIVO NO GEDOC}","origin":"","viewDateTime":"2024-02-23T14:25"}],"caseId":'+'"'+casemock.id+'"'+',"fileLinksRef":[{"fileDescription":"{DESCRIÇÃO DO ARQUIVO PARA SER EXIBIDO}","idGedoc":"{ID DO ARQUIVO NO GEDOC}"}]}');
         RestContext.request = request;
         RestContext.response = res;
        
         
         Test.startTest();
         Test.setMock(HttpCalloutMock.class, new UserProfileCalloutPessoaNotPrePaidMock());
         CaseCommentManagement.upsertCaseComment();
         test.stopTest();
         filelink__c teste = [Select id from fileLink__c limit 1 ];
         
         
         System.assert(res.statusCode == 200);
         System.assert(teste != null,'Não foi criado o fileLink__c');

    }


}