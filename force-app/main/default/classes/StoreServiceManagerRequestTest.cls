@IsTest
public with sharing class StoreServiceManagerRequestTest {
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
            Login__c = 'a9000000',
            StoreCode__c = '01'
        );

        Database.insert(userTest);
    }

    @IsTest
    public static void getUpdateWorkPositionRequestTest() {
        User userTest = [
            SELECT id, Login__c 
            FROM User 
            WHERE UserName = 'ssmgssvssf@ssmgssvssf.com' 
            LIMIT 1
        ];

        System.runAs(userTest) {
            String workPositionId = '01';
            Boolean startService = true;
            String status = 'Empty';
            
            Test.startTest();
                StoreServiceManagerResponse.WorkPosition request = StoreServiceManagerRequest.getUpdateWorkPositionRequest(userTest.Login__c, workPositionId, startService);
            Test.stopTest();
            
            System.assertEquals(userTest.Login__c, request.attendant.id);
            System.assertEquals(workPositionId, request.id);
            System.assertEquals(status, request.status);
        }
    }

    @IsTest
    public static void getUpdatePauseAttendantRequestTest() {
        User userTest = [
            SELECT id, Login__c, StoreCode__c
            FROM User 
            WHERE UserName = 'ssmgssvssf@ssmgssvssf.com' 
            LIMIT 1
        ];

        System.runAs(userTest) {
            String status = 'Alocado';

            StoreServiceManagerTO.ItemPicklistValue pauseReason = new StoreServiceManagerTO.ItemPicklistValue();

            pauseReason.value ='19';
            pauseReason.label = 'Almoco';

            Test.startTest();
                 StoreServiceManagerResponse.SalesAgent request = StoreServiceManagerRequest.getUpdatePauseAttendantRequest(userTest.Login__c, pauseReason);
            Test.stopTest();
				
            System.assertEquals(userTest.Login__c, request.id);
            System.assertEquals(status, request.status);
        }
    }
  
    @IsTest
    public static void getGenerateTicketRequestTest() {
        User userTest = [
                SELECT id, Login__c, StoreCode__c
                FROM User 
                WHERE UserName = 'ssmgssvssf@ssmgssvssf.com' 
                LIMIT 1
            ];

        System.runAs(userTest) {
            String scheduleTime = '14:16:22';
            String cellPhone = '83987654321';

            Test.startTest();
                StoreServiceManagerResponse.Ticket request = StoreServiceManagerRequest.getGenerateTicketRequest(userTest.Login__c, scheduleTime, cellPhone);
            Test.stopTest();
                
            System.assertEquals(userTest.Login__c, request.createBy);
            System.assertEquals(scheduleTime, request.createAt);
            System.assertEquals(cellPhone.substring(0, 2), request.geographicArea.code);
            System.assertEquals(cellPhone.substring(2), request.network.networkNumber);
        }
    }

    @IsTest
    public static void getStartAttendanceRequestTest() {
        User userTest = [
            SELECT id, Login__c, StoreCode__c
            FROM User 
            WHERE UserName = 'ssmgssvssf@ssmgssvssf.com' 
            LIMIT 1
        ];

        System.runAs(userTest) {
            StoreServiceManagerTO.ServiceTicket serviceTicket = new StoreServiceManagerTO.ServiceTicket();
                    
            serviceTicket.ticketId = 'A229';
            serviceTicket.workPositionId = '01';
            serviceTicket.displayAlert = true;
            
            Test.startTest();
                StoreServiceManagerResponse.Attendance request = StoreServiceManagerRequest.getStartAttendanceRequest(serviceTicket);
            Test.stopTest();

			System.assertEquals(serviceTicket.ticketId, request.ticket.id);            
			System.assertEquals(serviceTicket.workPositionId, request.workPosition.id);
            System.assertEquals(serviceTicket.displayAlert, request.displayAlert);
        }
    }

    @IsTest
    public static void getEndAttendanceRequestTest() {
        User userTest = [
            SELECT id, Login__c, StoreCode__c
            FROM User 
            WHERE UserName = 'ssmgssvssf@ssmgssvssf.com' 
            LIMIT 1
        ];

        System.runAs(userTest) {
            StoreServiceManagerTO.ServiceTicket serviceTicket = new StoreServiceManagerTO.ServiceTicket();
                    
            serviceTicket.type = 'MANUAL';
            serviceTicket.workPositionId = '01';
            serviceTicket.displayAlert = true;
            serviceTicket.ticketId = 'A229';
            serviceTicket.segmentation = '01';
            serviceTicket.segmentationName = 'Cliente V';
            serviceTicket.customerPriority = 1;
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
                StoreServiceManagerResponse.Attendance request = StoreServiceManagerRequest.getEndAttendanceRequest(userTest.Login__c, serviceTicket, 'Closed');
            Test.stopTest();
                
            System.assertEquals(serviceTicket.workPositionId, request.workPosition.id);
            System.assertEquals(serviceTicket.ticketId, request.ticket.id);
            System.assertEquals(serviceTicket.notes, request.notes);
            System.assertEquals(serviceTicket.displayAlert, request.displayAlert);
            System.assertEquals('Closed', request.status);
        }
    }
}