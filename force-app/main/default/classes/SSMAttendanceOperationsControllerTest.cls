@IsTest
public with sharing class SSMAttendanceOperationsControllerTest {
    private static final String TEST_PHONE_NUMBER = '81010101212';
    private static final String TEST_CNPJ_CPF_NUMBER = '55566677788';

    @TestSetup
    public static void setup() {
        Profile profileTest = [
            SELECT Id 
            FROM Profile 
            WHERE Name = 'Representante'
        ];

        UserRole userRoleTest = new UserRole();
        
        userRoleTest.Name = 'Telefonica Brasil';
        
        Database.insert(userRoleTest);

        User userTest = new User(
            Alias = 'SysAdmin', 
            Email = 'atendimento.senha@ssmgssvssf.com',
            EmailEncodingKey = 'UTF-8', 
            LastName = 'Testing', 
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US', 
            ProfileId = profileTest.Id, 
            UserRoleId = userRoleTest.Id,
            TimeZoneSidKey = 'America/Sao_Paulo', 
            UserName = 'ssmgssvssf@ssmgssvssf.com',
            Login__c = 'A024895',
            StoreCode__c = '307'
        );
        
        Database.insert(userTest);

        System.runAs(userTest) {
            FeatureFlag__c featureFlagObj = new FeatureFlag__c();
            featureFlagObj.Name = 'SSMUseServiceTicketObject';
            featureFlagObj.Application__c = 'SSMUseServiceTicketObject';
            featureFlagObj.Active__c = true;
    
            insert featureFlagObj;
            
            List<Webservice__c> ltWebservicesSSM = new List<Webservice__c>();

            ltWebservicesSSM.add(
                new Webservice__c(
                    Name = 'PointOfServiceCallout',
                    switchedOn__c = true,
                    Endpoint__c = 'https://api-hml.telefonica.com.br/pointServiceQueueManagement/v1/pointOfServices?attendantId={attendantId}',
                    SubscriptionKey__c = '36cfd2713668489bb3f7d23d042be3a3'
                )
            );

            ltWebservicesSSM.add(
                new Webservice__c(
                    Name = 'OperationalInformationsCallout',
                    switchedOn__c = true,
                    Endpoint__c = 'https://api-hml.telefonica.com.br/channelSalesManagement/v1/pointOfServices/operationalInformations/',
                    SubscriptionKey__c = '36cfd2713668489bb3f7d23d042be3a3'
                )
            );          

            ltWebservicesSSM.add(
                new Webservice__c(
                    Name = 'UpdateWorkPositionCallout',
                    switchedOn__c = true,
                    Endpoint__c = 'https://api-hml.telefonica.com.br/pointOfServices/{pointOfServiceId}/workPositions/{workPositionId}',
                    SubscriptionKey__c = '36cfd2713668489bb3f7d23d042be3a3'
                )
            );
        
            ltWebservicesSSM.add(
                new Webservice__c(
                    Name = 'PointOfServiceAttendantCallout',
                    switchedOn__c = true,
                    Endpoint__c = 'https://api-hml.telefonica.com.br//pointOfServices/{pointOfServiceId}/attendants/{attendantId}',
                    SubscriptionKey__c = '36cfd2713668489bb3f7d23d042be3a3'
                )
            );

            ltWebservicesSSM.add(
                new Webservice__c(
                    Name = 'PointOfServiceAttendanceCallout',
                    switchedOn__c = true,
                    Endpoint__c = 'https://api-hml.telefonica.com.br/pointOfServices/{pointOfServiceId}/attendants/{attendantId}/attendances',
                    SubscriptionKey__c = '36cfd2713668489bb3f7d23d042be3a3'
                )
            );
        
            ltWebservicesSSM.add(
                new Webservice__c(
                    Name = 'PointOfServiceTicketsCallout',
                    switchedOn__c = true,
                    Endpoint__c = 'https://api-hml.telefonica.com.br/pointOfServices/{pointOfServiceId}/tickets',
                    SubscriptionKey__c = '36cfd2713668489bb3f7d23d042be3a3'
                )
            );

            Database.insert(ltWebservicesSSM);

            Account accountTest = new Account();

            accountTest.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Billing').getrecordTypeId();
            accountTest.Name = 'Account Test SSM';
            accountTest.CustomerSegment__c = 'PLATINUM';
            accountTest.vlocity_cmt__Active__c = 'Yes';
            accountTest.DocumentNumber__c = TEST_CNPJ_CPF_NUMBER;
            accountTest.Phone = TEST_PHONE_NUMBER;

            Database.insert(accountTest);

            GeneralParam__c paramTest = new GeneralParam__c(
                TimeAutomaticTicketCall__c = 10
            );

            ServiceTicket__c ticketTest = new ServiceTicket__c(
                ExternalID__c = 'TICKET_TEST',
                Store__c = '307',
                TicketId__c = 'T98',
                Status__c = 'On Hold',
                SpecialNeeds__c = false,
                Priority__c = 2,
                CustomerName__c = 'Márcio Las',
                Alias__c = 'MLAS',
                Document__c = '85274136987',
                GeographicAreaCode__c = '81',
                NetworkNumber__c = '966778899',
                SegmentID__c = '1',
                SegmentName__c = 'Cliente',
                Activity__c = 'Test ticket',
                Protocol__c = '000011/2023',
                InteractionID__c = '4',
                InteractionName__c = 'Teste Componente SSM',
                WaitTime__c = '00:05:25',
                ActivityPriority__c = 1
            );
    
            Database.insert(ticketTest);
        }
    }

    @IsTest
    public static void recallTicketTest() {
        User userTest = [
            SELECT id 
            FROM User 
            WHERE UserName = 'ssmgssvssf@ssmgssvssf.com' 
            LIMIT 1
        ];

        System.runAs(userTest) {
            Map<String, Object> mapServiceTicketTest = SSMTicketsController.getPointOfServiceTitckets();

            List<StoreServiceManagerTO.ServiceTicket> ltServiceTicketTest = 
                (List<StoreServiceManagerTO.ServiceTicket>) mapServiceTicketTest.get('success');

            StoreServiceManagerTO.ServiceTicket serviceTicketTest = ltServiceTicketTest[0];

            Test.startTest();
                Test.setMock(HttpCalloutMock.class, new PointOfServiceAttendanceCalloutMock());

                Map<String, Object> mapTest = SSMAttendanceOperationsController.recallTicket(serviceTicketTest);
            Test.stopTest();

            System.assertEquals('T98', serviceTicketTest.ticketId);
        }
    }

    @IsTest
    public static void returnToHome() { 
        User userTest = [
            SELECT id 
            FROM User 
            WHERE UserName = 'ssmgssvssf@ssmgssvssf.com' 
            LIMIT 1
        ];

        System.runAs(userTest) {
            Map<String, Object> mapServiceTicketTest = SSMTicketsController.getPointOfServiceTitckets();

            List<StoreServiceManagerTO.ServiceTicket> ltServiceTicketTest = 
                (List<StoreServiceManagerTO.ServiceTicket>) mapServiceTicketTest.get('success');

            StoreServiceManagerTO.ServiceTicket serviceTicketTest = ltServiceTicketTest[0];

            Test.startTest();
                Test.setMock(HttpCalloutMock.class, new PointOfServiceAttendanceCalloutMock());

                Map<String, Object> mapTest = SSMAttendanceOperationsController.returnToHome(serviceTicketTest);
            Test.stopTest();

            System.assertEquals('T98', serviceTicketTest.ticketId);
        }
    }

    @IsTest
    public static void giveUpTest() { 
        User userTest = [
            SELECT id 
            FROM User 
            WHERE UserName = 'ssmgssvssf@ssmgssvssf.com' 
            LIMIT 1
        ];

        System.runAs(userTest) {
            Map<String, Object> mapServiceTicketTest = SSMTicketsController.getPointOfServiceTitckets();

            List<StoreServiceManagerTO.ServiceTicket> ltServiceTicketTest = 
                (List<StoreServiceManagerTO.ServiceTicket>) mapServiceTicketTest.get('success');

            StoreServiceManagerTO.ServiceTicket serviceTicketTest = ltServiceTicketTest[0];

            serviceTicketTest.category = 'FIXA';
            serviceTicketTest.categoryName = 'Fixa';
            serviceTicketTest.mainDocumentType = 'CPF';
            serviceTicketTest.mainDocumentTypeName = 'CPF';
            serviceTicketTest.documentNumber = '45678932103';
            serviceTicketTest.giveUpReason = '{\"value\": \"QR1\", \"label\": \"Retornará em outro horário / dia\"}';

            Test.startTest();
                Test.setMock(HttpCalloutMock.class, new PointOfServiceAttendanceCalloutMock());

                Map<String, Object> mapTest = SSMAttendanceOperationsController.giveUp(serviceTicketTest);
            Test.stopTest();

            System.assertEquals('T98', serviceTicketTest.ticketId);
        }
    }

    @IsTest
    public static void confirmServiceTest() { 
        User userTest = [
            SELECT id 
            FROM User 
            WHERE UserName = 'ssmgssvssf@ssmgssvssf.com' 
            LIMIT 1
        ];

        System.runAs(userTest) {
            Map<String, Object> mapCustomer = SSMAttendanceController.getAccount('', TEST_CNPJ_CPF_NUMBER);
            Account acc = (Account) mapCustomer.get('success');
            Id customerInteractionId = (Id) mapCustomer.get('CustomerInteractionId');

            Map<String, Object> mapServiceTicketTest = SSMTicketsController.getPointOfServiceTitckets();

            List<StoreServiceManagerTO.ServiceTicket> ltServiceTicketTest = 
                (List<StoreServiceManagerTO.ServiceTicket>) mapServiceTicketTest.get('success');

            StoreServiceManagerTO.ServiceTicket serviceTicketTest = ltServiceTicketTest[0];
                    
            serviceTicketTest.customerInteractionId = customerInteractionId;
            serviceTicketTest.customerId = acc.Id;
            serviceTicketTest.category = 'FIXA';
            serviceTicketTest.categoryName = 'Fixa';
            serviceTicketTest.mainDocumentType = 'CPF';
            serviceTicketTest.mainDocumentTypeName = 'CPF';
            serviceTicketTest.documentNumber = '45678932103';
            serviceTicketTest.activities = '[{\"value\": \"728\", \"label\": \"Cancelamento - Fixa"}]';
            serviceTicketTest.notes = 'O cliente solicitou o cancelamento';

            Test.startTest();
                Test.setMock(HttpCalloutMock.class, new PointOfServiceAttendanceCalloutMock());

                Map<String, Object> mapTest = SSMAttendanceOperationsController.confirmService(serviceTicketTest);
            Test.stopTest();

            System.assertEquals('T98', serviceTicketTest.ticketId);
        }
    }
}