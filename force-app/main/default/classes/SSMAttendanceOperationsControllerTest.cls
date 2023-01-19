@IsTest
public with sharing class SSMAttendanceOperationsControllerTest {
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
            accountTest.DocumentNumber__c = '11111111111111';
            // accountTest.CustomerType__c = 'Móvel';
            accountTest.CustomerSegment__c = 'PLATINUM';
            accountTest.Active__c = true;
            accountTest.DocumentNumber__c = '55566677788';
            accountTest.Phone = '81010101212';

            Database.insert(accountTest);

            GeneralParam__c paramTest = new GeneralParam__c(
                TimeAutomaticTicketCall__c = 10
            );
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
            List<Account> ltAccountTest = AccountDAO.getAccountByPhoneNumber('81010101212');

            StoreServiceManagerTO.ServiceTicket serviceTicket = new StoreServiceManagerTO.ServiceTicket();
                    
            serviceTicket.type = 'MANUAL';
            serviceTicket.workPositionId = '01';
            serviceTicket.displayAlert = false;
            serviceTicket.ticketId = 'A229';
            serviceTicket.customerPriority = 1;
            serviceTicket.customerId = ltAccountTest[0].Id;
            serviceTicket.customerName = 'Maria Augusta Silva';
            serviceTicket.customerAlias = 'Maria Augusta Silva';
            serviceTicket.customerCellPhone = '11988887777';
            serviceTicket.customerDocument = '45678932103';
            serviceTicket.category = 'FIXA';
            serviceTicket.categoryName = 'Fixa';
            serviceTicket.mainDocumentType = 'CPF';
            serviceTicket.documentNumber = '45678932103';
            serviceTicket.giveUpReason = '{\"value\": \"QR1\", \"label\": \"Retornará em outro horário / dia\"}';
            
            Test.startTest();
                Test.setMock(HttpCalloutMock.class, new PointOfServiceAttendanceCalloutMock());

                Map<String, Object> mapTest = SSMAttendanceOperationsController.recallTicket(serviceTicket);
            Test.stopTest();

            System.assertNotEquals(null, mapTest.get('success'));
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
            List<Account> ltAccountTest = AccountDAO.getAccountByPhoneNumber('81010101212');

            StoreServiceManagerTO.ServiceTicket serviceTicket = new StoreServiceManagerTO.ServiceTicket();
                    
            serviceTicket.type = 'MANUAL';
            serviceTicket.workPositionId = '01';
            serviceTicket.displayAlert = false;
            serviceTicket.ticketId = 'A229';
            serviceTicket.customerPriority = 1;
            serviceTicket.customerId = ltAccountTest[0].Id;
            serviceTicket.customerName = 'Maria Augusta Silva';
            serviceTicket.customerAlias = 'Maria Augusta Silva';
            serviceTicket.customerCellPhone = '11988887777';
            serviceTicket.customerDocument = '45678932103';
            serviceTicket.category = 'FIXA';
            serviceTicket.categoryName = 'Fixa';
            serviceTicket.mainDocumentType = 'CPF';
            serviceTicket.documentNumber = '45678932103';
            serviceTicket.giveUpReason = '{\"value\": \"QR1\", \"label\": \"Retornará em outro horário / dia\"}';
            
            Test.startTest();
                Test.setMock(HttpCalloutMock.class, new PointOfServiceAttendanceCalloutMock());

                Map<String, Object> mapTest = SSMAttendanceOperationsController.giveUp(serviceTicket);
            Test.stopTest();

            System.assertNotEquals(null, mapTest.get('success'));
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
            List<Account> ltAccountTest = AccountDAO.getAccountByPhoneNumber('81010101212');

            StoreServiceManagerTO.ServiceTicket serviceTicket = new StoreServiceManagerTO.ServiceTicket();
                    
            serviceTicket.type = 'MANUAL';
            serviceTicket.workPositionId = '01';
            serviceTicket.displayAlert = false;
            serviceTicket.ticketId = 'A229';
            serviceTicket.segmentation = '01';
            serviceTicket.segmentationName = 'Cliente V';
            serviceTicket.customerPriority = 1;
            serviceTicket.customerId = ltAccountTest[0].Id;
            serviceTicket.customerName = 'Maria Augusta Silva';
            serviceTicket.customerAlias = 'Maria Augusta Silva';
            serviceTicket.customerCellPhone = '11988887777';
            serviceTicket.customerDocument = '45678932103';
            serviceTicket.category = 'FIXA';
            serviceTicket.categoryName = 'Fixa';
            serviceTicket.mainDocumentType = 'CPF';
            serviceTicket.documentNumber = '45678932103';
            serviceTicket.activities = '[{\"value\": \"728\", \"label\": \"Cancelamento - Fixa"}]';
            serviceTicket.notes = 'O cliente solicitou o cancelamento';

            Test.startTest();
                Test.setMock(HttpCalloutMock.class, new PointOfServiceAttendanceCalloutMock());

                Map<String, Object> mapTest = SSMAttendanceOperationsController.confirmService(serviceTicket);
            Test.stopTest();

            System.assertNotEquals(null, mapTest.get('success'));
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
            List<Account> ltAccountTest = AccountDAO.getAccountByPhoneNumber('81010101212');

            StoreServiceManagerTO.ServiceTicket serviceTicket = new StoreServiceManagerTO.ServiceTicket();
                    
            serviceTicket.type = 'MANUAL';
            serviceTicket.workPositionId = '01';
            serviceTicket.displayAlert = false;
            serviceTicket.ticketId = 'A229';
            serviceTicket.customerPriority = 1;
            serviceTicket.customerId = ltAccountTest[0].Id;
            serviceTicket.customerName = 'Maria Augusta Silva';
            serviceTicket.customerAlias = 'Maria Augusta Silva';
            serviceTicket.customerCellPhone = '11988887777';
            serviceTicket.customerDocument = '45678932103';
            serviceTicket.category = 'FIXA';
            serviceTicket.categoryName = 'Fixa';
            serviceTicket.mainDocumentType = 'CPF';
            serviceTicket.documentNumber = '45678932103';
            
            Test.startTest();
                Test.setMock(HttpCalloutMock.class, new PointOfServiceAttendanceCalloutMock());

                Map<String, Object> mapTest = SSMAttendanceOperationsController.returnToHome(serviceTicket);
            Test.stopTest();

            System.assertNotEquals(null, mapTest.get('success'));
        }
    }
}