@IsTest
public with sharing class SSMHomeOperationsControllerTest {
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
        }
    }

    @IsTest
    public static void  startAttendanceTest() {
        User userTest = [
            SELECT id 
            FROM User 
            WHERE UserName = 'ssmgssvssf@ssmgssvssf.com' 
            LIMIT 1
        ];

        System.runAs(userTest) {
            StoreServiceManagerTO.ServiceTicket serviceTicket = new StoreServiceManagerTO.ServiceTicket();
                    
            serviceTicket.ticketId = 'T98';
            serviceTicket.workPositionId = '01';
            serviceTicket.displayAlert = true;
            
            Test.startTest();
                Test.setMock(HttpCalloutMock.class, new PointOfServiceAttendanceCalloutMock());

                Map<String, Object> mapTest = SSMHomeOperationsController.startAttendance(serviceTicket);
            Test.stopTest();

            String responseAttendance = (String) mapTest.get('success');

            StoreServiceManagerResponse.Attendance attendanceTest = (StoreServiceManagerResponse.Attendance) 
                JSON.deserialize(responseAttendance, StoreServiceManagerResponse.Attendance.class);

            System.assertEquals(serviceTicket.ticketId, attendanceTest.ticket.id);
        }
    }
}
