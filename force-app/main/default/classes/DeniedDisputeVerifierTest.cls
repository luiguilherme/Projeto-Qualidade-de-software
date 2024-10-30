@isTest
public class DeniedDisputeVerifierTest {
    private final static String CASES_FROM_ACCOUNT_JSON_STRING = '[{"ComplainedAsset":"41991575677","Id":"5008K000005Bx9fQAC","RecordTypeDeveloperName":"DisputeInvoiceCase","IsHDE":false,"Origin":"SFA Script - Nex","CreatedDate":"2024-01-25T18:34:58.000Z"},{"ComplainedAsset":"41991575677","Id":"5008K000005BxAXQA0","RecordTypeDeveloperName":"DisputeInvoiceCase","IsHDE":false,"Origin":"Salesforce","CreatedDate":"2024-01-25T18:14:58.000Z"},{"ComplainedAsset":"41991575677","Id":"5008K000005BxB1QAK","RecordTypeDeveloperName":"DisputeInvoiceCase","IsHDE":false,"Origin":"Salesforce","CreatedDate":"2024-01-25T18:17:30.000Z"},{"Id":"5008K000005BxBaQAK","RecordTypeDeveloperName":"MobileServiceQualification","IsHDE":false,"Origin":"Salesforce","CreatedDate":"2024-01-25T18:19:49.000Z"},{"ComplainedAsset":"41991575677","Id":"5008K000005BxDqQAK","RecordTypeDeveloperName":"DisputeInvoiceCase","IsHDE":false,"Origin":"SFA Script - Nex","CreatedDate":"2024-01-25T18:31:59.000Z"},{"ComplainedAsset":"41991575677","Id":"5008K000005CDFEQA4","RootCause":true,"DisputeDenied":true,"RecordTypeDeveloperName":"DisputeInvoiceCase","IsHDE":false,"Origin":"SFA Script - Next","CreatedDate":"2024-01-29T17:48:00.000Z"},{"ComplainedAsset":"41991575677","Id":"5008K000005CDNTQA4","RootCause":true,"DisputeDenied":true,"RecordTypeDeveloperName":"DisputeInvoiceCase","IsHDE":false,"Origin":"SFA Script - Next","CreatedDate":"2024-01-29T18:33:22.000Z"},{"ComplainedAsset":"41991575677","Id":"5008K000005CDPkQAO","RecordTypeDeveloperName":"DisputeInvoiceCase","IsHDE":false,"Origin":"SFA Script - Next","CreatedDate":"2024-01-29T18:51:12.000Z"},{"ComplainedAsset":"41991575677","Id":"5008K000005CDRAQA4","RootCause":false,"DisputeDenied":false,"RecordTypeDeveloperName":"DisputeInvoiceCase","IsHDE":false,"Origin":"SFA Script - Next","CreatedDate":"2024-01-29T18:54:18.000Z"},{"ComplainedAsset":"41991575677","Id":"5008K000005CDRjQAO","RootCause":true,"DisputeDenied":true,"RecordTypeDeveloperName":"DisputeInvoiceCase","IsHDE":false,"Origin":"SFA Script - Next","CreatedDate":"2024-01-29T18:57:39.000Z"},{"ComplainedAsset":"41991575677","Id":"5008K000005CDWFQA4","RootCause":true,"DisputeDenied":true,"RecordTypeDeveloperName":"DisputeInvoiceCase","IsHDE":false,"Origin":"SFA Script - Next","CreatedDate":"2024-01-29T19:23:12.000Z"},{"ComplainedAsset":"41991575677","Id":"5008K000005CDfXQAW","RootCause":false,"DisputeDenied":true,"RecordTypeDeveloperName":"DisputeInvoiceCase","IsHDE":false,"Origin":"SFA Script - Next","CreatedDate":"2024-01-29T21:10:34.000Z"},{"ComplainedAsset":"41991575677","Id":"5008K000005CDQhQAO","RootCause":true,"DisputeDenied":true,"RecordTypeDeveloperName":"DisputeInvoiceCase","IsHDE":false,"Origin":"SFA Script - Next","CreatedDate":"2024-01-29T19:07:43.000Z"},{"ComplainedAsset":"41991575677","Id":"5008K000005CDTuQAO","RootCause":true,"DisputeDenied":true,"RecordTypeDeveloperName":"DisputeInvoiceCase","IsHDE":false,"Origin":"SFA Script - Next","CreatedDate":"2024-01-29T19:10:59.000Z"},{"ComplainedAsset":"2345654879","Id":"5008K000005CDZEQA4","RecordTypeDeveloperName":"DisputeInvoiceCase","IsHDE":false,"Origin":"SFA Script - Next","CreatedDate":"2024-01-29T19:43:52.000Z"},{"ComplainedAsset":"41991575677","Id":"5008K000005CDiZQAW","RootCause":false,"DisputeDenied":true,"RecordTypeDeveloperName":"DisputeInvoiceCase","IsHDE":false,"Origin":"SFA Script - Next","CreatedDate":"2024-01-29T20:37:20.000Z"},{"ComplainedAsset":"41991575677","Id":"5008K000005CDkBQAW","RootCause":false,"DisputeDenied":true,"RecordTypeDeveloperName":"DisputeInvoiceCase","IsHDE":false,"Origin":"SFA Script - Next","CreatedDate":"2024-01-29T21:01:32.000Z"},{"ComplainedAsset":"41991575677","Id":"5008K000005CDm6QAG","RootCause":false,"DisputeDenied":true,"RecordTypeDeveloperName":"DisputeInvoiceCase","IsHDE":false,"Origin":"SFA Script - Next","CreatedDate":"2024-01-29T20:53:12.000Z"},{"ComplainedAsset":"41991575677","Id":"5008K000005CDxiQAG","RootCause":false,"DisputeDenied":true,"RecordTypeDeveloperName":"DisputeInvoiceCase","IsHDE":false,"Origin":"SFA Script - Next","CreatedDate":"2024-01-29T21:29:40.000Z"},{"ComplainedAsset":"2345654879","Id":"5008K000005CnY2QAK","RecordTypeDeveloperName":"DisputeInvoiceCase","IsHDE":false,"Origin":"SFA Script - Next","CreatedDate":"2024-02-02T21:02:48.000Z"},{"ComplainedAsset":"41991575677","Id":"5008K000005DCZPQA4","RootCause":false,"DisputeDenied":true,"RecordTypeDeveloperName":"DisputeInvoiceCase","IsHDE":false,"Origin":"SFA Script - Next","CreatedDate":"2024-02-07T17:09:41.000Z"},{"ComplainedAsset":"41991575677","Id":"5008K000005CDx0QAG","RootCause":true,"DisputeDenied":true,"RecordTypeDeveloperName":"DisputeInvoiceCase","IsHDE":false,"Origin":"SFA Script - Next","CreatedDate":"2024-01-29T21:32:49.000Z"},{"ComplainedAsset":"41991575677","Id":"5008K000005CIWaQAO","RootCause":true,"DisputeDenied":true,"RecordTypeDeveloperName":"DisputeInvoiceCase","IsHDE":false,"Origin":"SFA Script - Next","CreatedDate":"2024-01-30T11:41:21.000Z"},{"ComplainedAsset":"41991575677","Id":"5008K000005CImZQAW","RootCause":true,"DisputeDenied":true,"RecordTypeDeveloperName":"DisputeInvoiceCase","IsHDE":false,"Origin":"SFA Script - Next","CreatedDate":"2024-01-30T12:42:28.000Z"},{"ComplainedAsset":"2345654879","Id":"5008K000005CIlJQAW","RootCause":false,"DisputeDenied":true,"RecordTypeDeveloperName":"DisputeInvoiceCase","IsHDE":false,"Origin":"SFA Script - Next","CreatedDate":"2024-01-30T12:50:28.000Z"},{"ComplainedAsset":"41991575677","Id":"5008K000005CInrQAG","RootCause":true,"DisputeDenied":true,"RecordTypeDeveloperName":"DisputeInvoiceCase","IsHDE":false,"Origin":"SFA Script - Next","CreatedDate":"2024-01-30T12:49:31.000Z"},{"ComplainedAsset":"2345654879","Id":"5008K000005CP8jQAG","RootCause":false,"DisputeDenied":false,"RecordTypeDeveloperName":"DisputeInvoiceCase","IsHDE":false,"Origin":"SFA Script - Next","CreatedDate":"2024-01-31T19:16:38.000Z"},{"ComplainedAsset":"2345654879","Id":"5008K000005CQEBQA4","RootCause":false,"DisputeDenied":true,"RecordTypeDeveloperName":"DisputeInvoiceCase","IsHDE":false,"Origin":"SFA Script - Next","CreatedDate":"2024-01-31T23:30:19.000Z"},{"ComplainedAsset":"41991575677","Id":"5008K000005CW01QAG","RecordTypeDeveloperName":"DisputeInvoiceCase","IsHDE":false,"Origin":"SFA Script - Nex","CreatedDate":"2024-02-01T20:22:38.000Z"},{"ComplainedAsset":"41991575677","Id":"5008K000005CJqwQAG","RecordTypeDeveloperName":"DisputeInvoiceCase","IsHDE":false,"Origin":"SFA Script - Next","CreatedDate":"2024-01-30T19:19:41.000Z"},{"ComplainedAsset":"2345654879","Id":"5008K000005COs7QAG","RootCause":false,"DisputeDenied":false,"RecordTypeDeveloperName":"DisputeInvoiceCase","IsHDE":false,"Origin":"SFA Script - Next","CreatedDate":"2024-01-31T17:31:32.000Z"},{"ComplainedAsset":"41991575677","Id":"5008K000005CVyLQAW","RecordTypeDeveloperName":"DisputeInvoiceCase","IsHDE":false,"Origin":"SFA Script - Nex","CreatedDate":"2024-02-01T20:20:58.000Z"},{"ComplainedAsset":"2345654879","Id":"5008K000005COLNQA4","RecordTypeDeveloperName":"DisputeInvoiceCase","IsHDE":false,"Origin":"SFA Script - Next","CreatedDate":"2024-01-31T14:49:35.000Z"},{"ComplainedAsset":"41991575677","Id":"5008K000005CVzmQAG","RecordTypeDeveloperName":"DisputeInvoiceCase","IsHDE":false,"Origin":"SFA Script - Nex","CreatedDate":"2024-02-01T20:21:56.000Z"},{"ComplainedAsset":"2345654879","Id":"5008K000005CP4uQAG","RootCause":false,"DisputeDenied":true,"RecordTypeDeveloperName":"DisputeInvoiceCase","IsHDE":false,"Origin":"SFA Script - Next","CreatedDate":"2024-01-31T19:08:04.000Z"},{"ComplainedAsset":"2345654879","Id":"5008K000005CQDlQAO","RootCause":false,"DisputeDenied":true,"RecordTypeDeveloperName":"DisputeInvoiceCase","IsHDE":false,"Origin":"SFA Script - Next","CreatedDate":"2024-01-31T23:11:33.000Z"},{"ComplainedAsset":"2345654879","Id":"5008K000005CQDSQA4","RootCause":false,"DisputeDenied":true,"RecordTypeDeveloperName":"DisputeInvoiceCase","IsHDE":false,"Origin":"SFA Script - Next","CreatedDate":"2024-01-31T23:43:14.000Z"},{"ComplainedAsset":"2345654879","Id":"5008K000005CTmnQAG","RootCause":false,"DisputeDenied":true,"RecordTypeDeveloperName":"DisputeInvoiceCase","IsHDE":false,"Origin":"SFA Script - Next","CreatedDate":"2024-02-01T14:20:34.000Z"},{"ComplainedAsset":"2345654879","Id":"5008K000005DCamQAG","RootCause":false,"DisputeDenied":true,"RecordTypeDeveloperName":"DisputeInvoiceCase","IsHDE":false,"Origin":"SFA Script - Next","CreatedDate":"2024-02-07T17:13:56.000Z"},{"ComplainedAsset":"2345654879","Id":"5008K000005DCnNQAW","RootCause":false,"DisputeDenied":true,"RecordTypeDeveloperName":"DisputeInvoiceCase","IsHDE":false,"Origin":"SFA Script - Next","CreatedDate":"2024-02-07T17:46:48.000Z"},{"ComplainedAsset":"2345654879","Id":"5008K000005DCreQAG","RootCause":false,"DisputeDenied":true,"RecordTypeDeveloperName":"DisputeInvoiceCase","IsHDE":false,"Origin":"SFA Script - Next","CreatedDate":"2024-02-07T17:57:34.000Z"},{"ComplainedAsset":"2345654879","Id":"5008K000005DDaBQAW","RootCause":false,"DisputeDenied":false,"RecordTypeDeveloperName":"DisputeInvoiceCase","IsHDE":false,"Origin":"SFA Script - Next","CreatedDate":"2024-02-07T20:13:55.000Z"},{"ComplainedAsset":"2345654879","Id":"5008K000005DPqfQAG","RootCause":false,"DisputeDenied":false,"RecordTypeDeveloperName":"DisputeInvoiceCase","IsHDE":false,"Origin":"SFA Script - Next","CreatedDate":"2024-02-09T19:02:52.000Z"},{"ComplainedAsset":"2345654879","Id":"5008K000005DQ27QAG","RootCause":false,"DisputeDenied":true,"RecordTypeDeveloperName":"DisputeInvoiceCase","IsHDE":false,"Origin":"SFA Script - Next","CreatedDate":"2024-02-09T20:07:19.000Z"},{"ComplainedAsset":"2345654879","Id":"5008K000005DCfwQAG","RootCause":false,"DisputeDenied":true,"RecordTypeDeveloperName":"DisputeInvoiceCase","IsHDE":false,"Origin":"SFA Script - Next","CreatedDate":"2024-02-07T17:28:31.000Z"},{"ComplainedAsset":"2345654879","Id":"5008K000005DChTQAW","RootCause":false,"DisputeDenied":true,"RecordTypeDeveloperName":"DisputeInvoiceCase","IsHDE":false,"Origin":"SFA Script - Next","CreatedDate":"2024-02-07T17:33:15.000Z"},{"ComplainedAsset":"2345654879","Id":"5008K000005DCj0QAG","RootCause":false,"DisputeDenied":true,"RecordTypeDeveloperName":"DisputeInvoiceCase","IsHDE":false,"Origin":"SFA Script - Next","CreatedDate":"2024-02-07T17:37:20.000Z"},{"ComplainedAsset":"2345654879","Id":"5008K000005DCqvQAG","RootCause":false,"DisputeDenied":true,"RecordTypeDeveloperName":"DisputeInvoiceCase","IsHDE":false,"Origin":"SFA Script - Next","CreatedDate":"2024-02-07T17:55:22.000Z"},{"ComplainedAsset":"41991575677","Id":"5008K000005DDXGQA4","RootCause":true,"DisputeDenied":true,"RecordTypeDeveloperName":"DisputeInvoiceCase","IsHDE":false,"Origin":"SFA Script - Next","CreatedDate":"2024-02-07T19:56:52.000Z"},{"ComplainedAsset":"2345654879","Id":"5008K000005DCruQAG","RootCause":false,"DisputeDenied":true,"RecordTypeDeveloperName":"DisputeInvoiceCase","IsHDE":false,"Origin":"SFA Script - Next","CreatedDate":"2024-02-07T18:12:07.000Z"},{"ComplainedAsset":"2345654879","Id":"5008K000005DPuhQAG","RootCause":false,"DisputeDenied":true,"RecordTypeDeveloperName":"DisputeInvoiceCase","IsHDE":false,"Origin":"SFA Script - Next","CreatedDate":"2024-02-09T19:25:23.000Z"},{"ComplainedAsset":"2345654879","Id":"5008K000005DCz9QAG","RootCause":false,"DisputeDenied":false,"RecordTypeDeveloperName":"DisputeInvoiceCase","IsHDE":false,"Origin":"SFA Script - Next","CreatedDate":"2024-02-07T18:14:14.000Z"},{"ComplainedAsset":"2345654879","Id":"5008K000005DJsoQAG","RootCause":false,"DisputeDenied":false,"RecordTypeDeveloperName":"DisputeInvoiceCase","IsHDE":false,"Origin":"SFA Script - Next","CreatedDate":"2024-02-08T17:23:55.000Z"},{"ComplainedAsset":"2345654879","Id":"5008K000005DIfvQAG","RecordTypeDeveloperName":"DisputeInvoiceCase","IsHDE":false,"Origin":"SFA Script - Next","CreatedDate":"2024-02-08T12:05:50.000Z"},{"ComplainedAsset":"2345654879","Id":"5008K000005DrBdQAK","HDEOtherProducts":"2345654879","RecordTypeDeveloperName":"CallSupervisor","IsHDE":true,"Origin":"HDE","CreatedDate":"2024-02-14T15:14:17.000Z"},{"ComplainedAsset":"2345654879","Id":"5008K000005DsK3QAK","RecordTypeDeveloperName":"DisputeInvoiceCase","IsHDE":false,"Origin":"SFA Script - Next","CreatedDate":"2024-02-14T19:38:48.000Z"},{"ComplainedAsset":"2345654879","Id":"5008K000005Dx2vQAC","RecordTypeDeveloperName":"DisputeInvoiceCase","IsHDE":false,"Origin":"SFA Script - Next","CreatedDate":"2024-02-15T17:54:17.000Z"},{"ComplainedAsset":"2345654879","Id":"5008K000005DxQTQA0","RecordTypeDeveloperName":"DisputeInvoiceCase","IsHDE":false,"Origin":"SFA Script - Next","CreatedDate":"2024-02-15T19:40:13.000Z"},{"ComplainedAsset":"2345654879","Id":"5008K000005DxRXQA0","RecordTypeDeveloperName":"DisputeInvoiceCase","IsHDE":false,"Origin":"SFA Script - Next","CreatedDate":"2024-02-15T19:50:35.000Z"},{"ComplainedAsset":"2345654879","Id":"5008K000005EDRGQA4","RootCause":false,"DisputeDenied":false,"RecordTypeDeveloperName":"DisputeInvoiceCase","IsHDE":false,"Origin":"SFA Script - Next","CreatedDate":"2024-02-19T12:20:33.000Z"},{"ComplainedAsset":"2345654879","Id":"5008K000005EDc1QAG","RecordTypeDeveloperName":"DisputeInvoiceCase","IsHDE":false,"Origin":"SFA Script - Next","CreatedDate":"2024-02-19T14:01:21.000Z"},{"ComplainedAsset":"2345654879","Id":"5008K000005ENG4QAO","RecordTypeDeveloperName":"DisputeInvoiceCase","IsHDE":false,"Origin":"SFA Script - Next","CreatedDate":"2024-02-21T18:43:52.000Z"},{"ComplainedAsset":"41991575677","Id":"5008K000005Dr0tQAC","RecordTypeDeveloperName":"DisputeInvoiceCase","IsHDE":false,"Origin":"SFA Script - Next","CreatedDate":"2024-02-14T14:31:59.000Z"},{"ComplainedAsset":"2345654879","Id":"5008K000005EDgpQAG","RootCause":false,"DisputeDenied":false,"RecordTypeDeveloperName":"DisputeInvoiceCase","IsHDE":false,"Origin":"SFA Script - Next","CreatedDate":"2024-02-19T14:00:10.000Z"},{"ComplainedAsset":"2345654879","Id":"5008K000005Dr9IQAS","RootCause":true,"DisputeDenied":false,"RecordTypeDeveloperName":"DisputeInvoiceCase","IsHDE":false,"Origin":"SFA Script - Next","CreatedDate":"2024-02-14T15:04:06.000Z"},{"ComplainedAsset":"2345654879","Id":"5008K000005EI0oQAG","RootCause":false,"DisputeDenied":false,"RecordTypeDeveloperName":"DisputeInvoiceCase","IsHDE":false,"Origin":"SFA Script - Next","CreatedDate":"2024-02-20T18:26:37.000Z"},{"ComplainedAsset":"2345654879","Id":"5008K000005ESInQAO","RecordTypeDeveloperName":"DisputeInvoiceCase","IsHDE":false,"Origin":"SFA Script - Next","CreatedDate":"2024-02-22T18:15:15.000Z"},{"ComplainedAsset":"2345654879","Id":"5008K000005ESL9QAO","RecordTypeDeveloperName":"DisputeInvoiceCase","IsHDE":false,"Origin":"SFA Script - Next","CreatedDate":"2024-02-22T18:45:29.000Z"},{"ComplainedAsset":"2345654879","Id":"5008K000005ESUUQA4","RecordTypeDeveloperName":"DisputeInvoiceCase","IsHDE":false,"Origin":"SFA Script - Next","CreatedDate":"2024-02-22T19:35:02.000Z"},{"ComplainedAsset":"2345654879","Id":"5008K000005EWUmQAO","RecordTypeDeveloperName":"DisputeInvoiceCase","IsHDE":false,"Origin":"SFA Script - Next","CreatedDate":"2024-02-23T19:17:49.000Z"},{"ComplainedAsset":"2345654879","Id":"5008K000005EjFWQA0","RootCause":true,"DisputeDenied":true,"RecordTypeDeveloperName":"DisputeInvoiceCase","IsHDE":false,"Origin":"SFA Script - Next","CreatedDate":"2024-02-26T14:34:37.000Z"},{"ComplainedAsset":"2345654879","Id":"5008K000005EjirQAC","RecordTypeDeveloperName":"DisputeInvoiceCase","IsHDE":false,"Origin":"SFA Script - Next","CreatedDate":"2024-02-26T17:11:45.000Z"},{"ComplainedAsset":"2345654879","Id":"5008K000005Ejj6QAC","RecordTypeDeveloperName":"DisputeInvoiceCase","IsHDE":false,"Origin":"SFA Script - Next","CreatedDate":"2024-02-26T17:12:54.000Z"},{"ComplainedAsset":"2345654879","Id":"5008K000005EWXbQAO","RecordTypeDeveloperName":"DisputeInvoiceCase","IsHDE":false,"Origin":"SFA Script - Next","CreatedDate":"2024-02-23T19:32:14.000Z"}]';
	//[Case]
    private final static String INVALID_CART_INSTANCE = '[{"HandledBillingStartDate__c":"/","Id":"","Name":"","ChargeCategory__c":"","Status__c":"","InstanceProduct__c":"","CreatedDate":"","Description__c":"","NameFull":"","Csp__c":"","FrontEndCode__c":"","StartTime__c":"","BillingStartDate__c":"","TotalAmount__c":"","AvailableAmount__c":"","BillingEndDate__c":""}]';
    private final static String INVALID_CART_INSTANCE_OTHER_CASE = '[{"HandledBillingStartDate__c":"06/2023","BillingEndDate__c":"2023-06-20","AvailableAmount__c":210,"TotalAmount__c":210,"Description__c":"MMS - Guia Serviu00e7os Eventuais (Evento)","Csp__c":"csp_value","BillingStartDate__c":"2023-06-19","StartTime__c":"2023-05-24T00:00:00.000Z","FrontEndCode__c":"2453069","NameFull":"SMS - Guia Serviu00e7os Eventuais (Evento)","CreatedDate":"2024-02-22T19:35:16.000Z","InstanceProduct__c":"2345654874","Status__c":"InAnalisys","ChargeCategory__c":"MMS","Name":"SMS - Guia Serviu00e7os Eventuais (Evento)","Id":"a7F8K0000008VKeUAM"}]';
    //[DisputedItem__c]
    private final static String VALID_CART_INSTANCE = '[{"HandledBillingStartDate__c":"06/2023","BillingEndDate__c":"2023-06-20","AvailableAmount__c":210,"TotalAmount__c":210,"Description__c":"MMS - Guia Serviu00e7os Eventuais (Evento)","Csp__c":"csp_value","BillingStartDate__c":"2023-06-19","StartTime__c":"2023-05-24T00:00:00.000Z","FrontEndCode__c":"2453069","NameFull":"SMS - Guia Serviu00e7os Eventuais (Evento)","CreatedDate":"2024-02-22T19:35:16.000Z","InstanceProduct__c":"2345654879","Status__c":"InAnalisys","ChargeCategory__c":"MMS","Name":"SMS - Guia Serviu00e7os Eventuais (Evento)","Id":"a7F8K0000008VKeUAM"}]';
    //[DisputedItem__c]
    //Account > Asset > Case > Task
    //                       > ComplainedAsset__c
    //                       > DisputedItem__c
    
    @isTest
    static void givenNoInputWhenInvokingMethodThenShouldReturnErrorFromException() {

        Profile userProfile = [SELECT Id, Name FROM Profile WHERE Name = 'Governanca'];
        UserRole userRole = [SELECT Id, Name FROM UserRole WHERE Name = 'BC_Business_Center_Atend'];
        User user = DataFactory.createUser(userProfile.Id, userRole.Id);
        
        System.runAs(user) {
            
            Account acc = new Account();
            acc.name = 'test';
            insert acc;
    
            Case case0 = new Case();
            case0.AccountId = acc.id;
            case0.Origin = 'URA';
            insert case0;
            
            Map<String, Object> uniqueMap = new Map<String, Object>();
            uniqueMap.put('DRgetCasesFromAccId', JSON.deserializeUntyped(CASES_FROM_ACCOUNT_JSON_STRING));
            uniqueMap.put('DRgetInstanceFromCart', JSON.deserializeUntyped(INVALID_CART_INSTANCE));
            uniqueMap.put('AccountId', acc.id);
            Map<String, Object> args = new Map<String, Object>();

            // args.put('input', uniqueMap);
            args.put('output', new Map<String, Object>());
            
            String action = 'checkCases';
            DeniedDisputeVerifier h19Apex = new DeniedDisputeVerifier();

            Map<String, Object> result = (Map<String, Object>) h19Apex.call(action, args);
            
            System.assertEquals(true, result.get('error'));
            System.assertEquals('Attempt to de-reference a null object', result.get('errorMsg'));

        }

    }

    @isTest
    static void givenDeniedDisputeInvoiceCaseCreatedWithin24hMustReturnNEG24H() {
        //criar caso com CreatedDate criado nas ultimas 24h
        //criar caso com RecordTyoe > DisputeInvoiceCase
        //criar ServiceDefinition com DisputeDenied__c = true
        Profile userProfile = [SELECT Id, Name FROM Profile WHERE Name = 'Governanca'];
        UserRole userRole = [SELECT Id, Name FROM UserRole WHERE Name = 'BC_Business_Center_Atend'];
        User user = DataFactory.createUser(userProfile.Id, userRole.Id);
        
        System.runAs(user) {

            Id CaseRTID = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get('DisputeInvoiceCase').getRecordTypeId();
            Account acc = new Account();
            acc.name = 'test';
            insert acc;

            ServiceDefinition__c disputeDeniedSD = new ServiceDefinition__c();
            disputeDeniedSD.DisputeDenied__c = true;
            insert disputeDeniedSD;

            Case case0 = new Case();
            case0.origin = 'SFA Script - Next';
            case0.ServiceDefinitionId__c = disputeDeniedSD.Id;
            case0.recordTypeId = CaseRTID;
            case0.AccountId = acc.id;
            insert case0;
            
            Map<String, Object> uniqueMap = new Map<String, Object>();
            uniqueMap.put('DRgetCasesFromAccId', JSON.deserializeUntyped(CASES_FROM_ACCOUNT_JSON_STRING));
            uniqueMap.put('DRgetInstanceFromCart', JSON.deserializeUntyped(VALID_CART_INSTANCE));
            uniqueMap.put('AccountId', acc.id);
            Map<String, Object> args = new Map<String, Object>();

            args.put('input', uniqueMap);
            args.put('output', new Map<String, Object>());
            
            String action = 'checkCases';
            DeniedDisputeVerifier a = new DeniedDisputeVerifier();
            
            Test.startTest();

            Map<String, Object> results = (Map<String, Object>) a.call(action, args);

            Test.stopTest();
            
            System.assertEquals('NEG24H', results.get('result'));
        }
    }

    @isTest
    private static void givenValidInputsWhenCallingHelpersThenShouldValidateHelpers() {
        Profile userProfile = [SELECT Id, Name FROM Profile WHERE Name = 'Governanca'];
        UserRole userRole = [SELECT Id, Name FROM UserRole WHERE Name = 'BC_Business_Center_Atend'];
        User user = DataFactory.createUser(userProfile.Id, userRole.Id);
        
        System.runAs(user) {

            DeniedDisputeVerifier h19Apex = new DeniedDisputeVerifier();

            Account acc = new Account();
            acc.name = 'test';
            insert acc;

            Case case0 = new Case();
            case0.origin = 'URA';
            case0.AccountId = acc.id;
            insert case0;

            Map<String, Object> uniqueMap = new Map<String, Object>();
            uniqueMap.put('DRgetCasesFromAccId', JSON.deserializeUntyped(CASES_FROM_ACCOUNT_JSON_STRING));
            uniqueMap.put('DRgetInstanceFromCart', JSON.deserializeUntyped(VALID_CART_INSTANCE));
            uniqueMap.put('AccountId', acc.id);

            String action = 'checkCases';
            Map<String, Object> args = new Map<String, Object>();
            args.put('input', uniqueMap);
            args.put('output', new Map<String, Object>());

            Test.setCreatedDate(case0.Id, Datetime.now().addDays(-2));
            Test.startTest();

            Map<String, Object> results = (Map<String, Object>) h19Apex.call(action, args);
            Boolean futureMethod = h19Apex.checkHasDisputeRootCause(case0, new Task(), new List<Object>());

            Test.stopTest();
            
            System.assertEquals(null, futureMethod);
        }
    }

    @isTest
    private static void givenValidInputsWhenInvokingMethodThenShouldValidateTask() {
        Profile userProfile = [SELECT Id, Name FROM Profile WHERE Name = 'Governanca'];
        UserRole userRole = [SELECT Id, Name FROM UserRole WHERE Name = 'BC_Business_Center_Atend'];
        User user = DataFactory.createUser(userProfile.Id, userRole.Id);
        
        System.runAs(user) {

            DeniedDisputeVerifier h19Apex = new DeniedDisputeVerifier();
            Id recordTypeHDEId = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get('CallSupervisor').getRecordTypeId();

            Account acc = new Account();
            acc.name = 'test';
            insert acc;

            Case case0 = new Case();
            case0.origin = 'Transfer';
            case0.HDERootCause__c = false;
            case0.SegmentProduct__c = 'Móvel';
            case0.HDEOtherProducts__c = '2345654879';
            case0.AccountId = acc.id;
            case0.RecordTypeId = recordTypeHDEId;
            insert case0;

            Task task = new Task();
            task.WhatId = case0.Id;
            task.TaskListType__c = 'Executar processo';
            task.View__c = 'CRI E-mail V';
            upsert task;

            Map<String, Object> uniqueMap = new Map<String, Object>();
            uniqueMap.put('DRgetCasesFromAccId', JSON.deserializeUntyped(CASES_FROM_ACCOUNT_JSON_STRING));
            uniqueMap.put('DRgetInstanceFromCart', JSON.deserializeUntyped(VALID_CART_INSTANCE));
            uniqueMap.put('AccountId', acc.id);

            String action = 'checkCases';
            Map<String, Object> args = new Map<String, Object>();
            args.put('input', uniqueMap);
            args.put('output', new Map<String, Object>());

            Test.startTest();

            Map<String, Object> results = (Map<String, Object>) h19Apex.call(action, args);

            Test.stopTest();

            System.assertEquals('NA', results.get('result'));
        }
    }

    @isTest
    private static void givenValidInputsWithRootCauseWhenInvokingMethodThenShouldReturnNA() {
        Profile userProfile = [SELECT Id, Name FROM Profile WHERE Name = 'Governanca'];
        UserRole userRole = [SELECT Id, Name FROM UserRole WHERE Name = 'BC_Business_Center_Atend'];
        User user = DataFactory.createUser(userProfile.Id, userRole.Id);
        
        System.runAs(user) {
            DeniedDisputeVerifier h19Apex = new DeniedDisputeVerifier();

            Account acc = new Account();
            acc.name = 'test';
            insert acc;

            ServiceDefinition__c serviceDefinition = new ServiceDefinition__c();
            serviceDefinition.DisputeDenied__c = false;
            serviceDefinition.RootCause__c = true;
            insert serviceDefinition;

            Case case0 = new Case();
            case0.origin = 'Transfer';
            case0.HDERootCause__c = false;
            case0.SegmentProduct__c = 'Móvel';
            case0.HDEOtherProducts__c = '2345654879';
            case0.AccountId = acc.id;
            case0.HDERootCause__c = true;
            case0.ServiceDefinitionId__c = serviceDefinition.Id;
            insert case0;

            Map<String, Object> uniqueMap = new Map<String, Object>();
            uniqueMap.put('DRgetCasesFromAccId', JSON.deserializeUntyped(CASES_FROM_ACCOUNT_JSON_STRING));
            uniqueMap.put('DRgetInstanceFromCart', JSON.deserializeUntyped(VALID_CART_INSTANCE));
            uniqueMap.put('AccountId', acc.id);

            String action = 'checkCases';
            Map<String, Object> args = new Map<String, Object>();
            args.put('input', uniqueMap);
            args.put('output', new Map<String, Object>());

            Test.startTest();

            Map<String, Object> results = (Map<String, Object>) h19Apex.call(action, args);

            Test.stopTest();

            System.assertEquals('NA', results.get('result'));
        }   
    }

    @isTest
    private static void givenValidInputsWhenInvokingMethodThenShouldReturnRAIZ() {
        Profile userProfile = [SELECT Id, Name FROM Profile WHERE Name = 'Governanca'];
        UserRole userRole = [SELECT Id, Name FROM UserRole WHERE Name = 'BC_Business_Center_Atend'];
        User user = DataFactory.createUser(userProfile.Id, userRole.Id);
        
        System.runAs(user) {
            DeniedDisputeVerifier h19Apex = new DeniedDisputeVerifier();
            Id recordTypeHDEId = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get('CallSupervisor').getRecordTypeId();
            Id recordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get('DisputeInvoiceCase').getRecordTypeId();

            Account acc = new Account();
            acc.name = 'test';
            insert acc;

            ServiceDefinition__c serviceDefinitionDisputeFalse = new ServiceDefinition__c();
            serviceDefinitionDisputeFalse.Name = 'test_1';
            serviceDefinitionDisputeFalse.DisputeDenied__c = false;
            serviceDefinitionDisputeFalse.RootCause__c = false;
            insert serviceDefinitionDisputeFalse;

            ServiceDefinition__c serviceDefinitionDisputeTrue = new ServiceDefinition__c();
            serviceDefinitionDisputeFalse.Name = 'test_2';
            serviceDefinitionDisputeTrue.DisputeDenied__c = true;
            serviceDefinitionDisputeTrue.RootCause__c = true;
            insert serviceDefinitionDisputeTrue;

            Case caseHDE = new Case();
            caseHDE.origin = 'Transfer';
            caseHDE.HDERootCause__c = false;
            caseHDE.SegmentProduct__c = 'Móvel';
            caseHDE.HDEOtherProducts__c = '2345654879';
            caseHDE.AccountId = acc.id;
            caseHDE.RecordTypeId = recordTypeHDEId;
            caseHDE.ServiceDefinitionId__c = serviceDefinitionDisputeFalse.Id;
            caseHDE.HDERootCause__c = true;
            insert caseHDE;

            Case caseNEG24H = new Case();
            caseNEG24H.origin = 'URA';
            caseNEG24H.AccountId = acc.id;
            caseNEG24H.RecordTypeId = recordTypeId;
            caseNEG24H.ServiceDefinitionId__c = serviceDefinitionDisputeTrue.Id;
            insert caseNEG24H;

            Case caseHDE2 = new Case();
            caseHDE2.origin = 'Transfer';
            caseHDE2.HDERootCause__c = false;
            caseHDE2.SegmentProduct__c = 'Móvel';
            caseHDE2.HDEOtherProducts__c = '2345654879';
            caseHDE2.AccountId = acc.id;
            caseHDE2.RecordTypeId = recordTypeHDEId;
            caseHDE2.HDERootCause__c = true;
            insert caseHDE2;

            Case case2 = new Case();
            case2.origin = 'URA';
            case2.AccountId = acc.id;
            insert case2;

            Task task = new Task();
            task.WhatId = caseHDE.Id;
            task.TaskListType__c = 'Realizar ajuste próximo ciclo faturamento';
            task.Subject = 'Realizar ajuste próximo ciclo faturamento';
            task.View__c = 'CRI E-mail V';
            insert task;

            Map<String, Object> uniqueMap = new Map<String, Object>();
            uniqueMap.put('DRgetCasesFromAccId', JSON.deserializeUntyped(CASES_FROM_ACCOUNT_JSON_STRING));
            uniqueMap.put('DRgetInstanceFromCart', JSON.deserializeUntyped(VALID_CART_INSTANCE));
            uniqueMap.put('AccountId', acc.id);

            String action = 'checkCases';
            Map<String, Object> args = new Map<String, Object>();
            args.put('input', uniqueMap);
            args.put('output', new Map<String, Object>());

            // Test.setCreatedDate(case2.Id, Datetime.now().addDays(-2));
            Test.startTest();

            Map<String, Object> results = (Map<String, Object>) h19Apex.call(action, args);

            Test.stopTest();

            System.assertEquals('NEG24H', results.get('result'));
        }
    }

    @isTest
    private static void givenInvalidCartsWheInvokingMethodThenShouldDenyCart() {
        Profile userProfile = [SELECT Id, Name FROM Profile WHERE Name = 'Governanca'];
        UserRole userRole = [SELECT Id, Name FROM UserRole WHERE Name = 'BC_Business_Center_Atend'];
        User user = DataFactory.createUser(userProfile.Id, userRole.Id);
        
        System.runAs(user) {
            DeniedDisputeVerifier h19Apex = new DeniedDisputeVerifier();

            Id recordTypeHDEId = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get('CallSupervisor').getRecordTypeId();

            Account acc = new Account();
            acc.name = 'test';
            insert acc;

            Case caseHDE = new Case();
            caseHDE.origin = 'Transfer';
            caseHDE.HDERootCause__c = false;
            caseHDE.SegmentProduct__c = 'Móvel';
            caseHDE.HDEOtherProducts__c = '2345654879';
            caseHDE.AccountId = acc.id;
            caseHDE.RecordTypeId = recordTypeHDEId;
            caseHDE.HDERootCause__c = true;
            insert caseHDE;

            Task task = new Task();
            task.WhatId = caseHDE.Id;
            task.TaskListType__c = 'Realizar ajuste próximo ciclo faturamento';
            task.Subject = 'Realizar ajuste próximo ciclo faturamento';
            task.View__c = 'CRI E-mail V';
            insert task;

            Map<String, Object> uniqueMap = new Map<String, Object>();
            uniqueMap.put('DRgetCasesFromAccId', JSON.deserializeUntyped(CASES_FROM_ACCOUNT_JSON_STRING));
            uniqueMap.put('DRgetInstanceFromCart', JSON.deserializeUntyped(INVALID_CART_INSTANCE_OTHER_CASE));
            uniqueMap.put('AccountId', acc.id);

            String action = 'checkCases';
            Map<String, Object> args = new Map<String, Object>();
            args.put('input', uniqueMap);
            args.put('output', new Map<String, Object>());

            Test.startTest();

            Map<String, Object> results = (Map<String, Object>) h19Apex.call(action, args);

            Test.stopTest();
            
            System.assertEquals('NA', results.get('result'));
        }
    }

    @isTest
    private static void givenValidInputsWhenInvokingMethodThenShouldShow60DaysDiff() {
        Profile userProfile = [SELECT Id, Name FROM Profile WHERE Name = 'Governanca'];
        UserRole userRole = [SELECT Id, Name FROM UserRole WHERE Name = 'BC_Business_Center_Atend'];
        User user = DataFactory.createUser(userProfile.Id, userRole.Id);
        
        System.runAs(user) {
            DeniedDisputeVerifier h19Apex = new DeniedDisputeVerifier();
            DeniedDisputeVerifier h19ApexClean = new DeniedDisputeVerifier();
            
            Id recordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get('DisputeInvoiceCase').getRecordTypeId();

            Account acc = new Account();
            acc.name = 'test';
            insert acc;

            ServiceDefinition__c serviceDefinition = new ServiceDefinition__c();
            serviceDefinition.DisputeDenied__c = false;
            serviceDefinition.RootCause__c = true;
            insert serviceDefinition;

            Case case0 = new Case();
            case0.origin = 'Transfer';
            case0.AccountId = acc.id;
            case0.ServiceDefinitionId__c = serviceDefinition.Id;
            case0.RecordTypeId = recordTypeId;
            insert case0;

            Map<String, Object> uniqueMap = new Map<String, Object>();
            uniqueMap.put('DRgetCasesFromAccId', JSON.deserializeUntyped(CASES_FROM_ACCOUNT_JSON_STRING));
            uniqueMap.put('DRgetInstanceFromCart', JSON.deserializeUntyped(VALID_CART_INSTANCE));
            uniqueMap.put('AccountId', acc.id);

            String action = 'checkCases';

            Map<String, Object> argsToday = new Map<String, Object>();
            argsToday.put('input', uniqueMap);
            argsToday.put('output', new Map<String, Object>());

            Map<String, Object> args61DaysOld = new Map<String, Object>();
            args61DaysOld.put('input', uniqueMap);
            args61DaysOld.put('output', new Map<String, Object>());

            Map<String, Object> resultsToday = (Map<String, Object>) h19Apex.call(action, argsToday);
            
            Test.setCreatedDate(case0.Id, Datetime.now().addDays(-61));
            Test.startTest();

            Map<String, Object> results61DaysOld = (Map<String, Object>) h19ApexClean.call(action, args61DaysOld);

            Test.stopTest();

            System.assertEquals('RAIZ', resultsToday.get('result'));
            System.assertEquals('NA', results61DaysOld.get('result'));
        }
    }
}