/*
    ---------------------------------------------------
    @author - Márcio Las
    @company - Telefonica  
    @date - 28/03/2022
    @description - Class ControllerTest for SSMTickets
    ---------------------------------------------------
*/
@IsTest
public with sharing class SSMTicketsControllerTest {
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
            ServiceTicket__c ticketTest = new ServiceTicket__c(
                ExternalID__c = 'DT081123ST307TKB0001',
                Store__c = '307',
                TicketId__c = 'B0001',
                Status__c = 'On Hold',
                SpecialNeeds__c = false,
                Priority__c = 2,
                CustomerName__c = 'Márcio Las',
                Alias__c = 'MLAS',
                Document__c = '85274136987',
                GeographicAreaCode__c = '81',
                NetworkNumber__c = '982925763',
                SegmentID__c = '1',
                SegmentName__c = 'Cliente',
                Activity__c = 'Test ticket',
                Protocol__c = '000111/2023',
                InteractionID__c = '4',
                InteractionName__c = 'Troca de Chip',
                WaitTime__c = '00:05:25',
                ActivityPriority__c = 2
            );

            Database.insert(ticketTest);
        }

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
    public static void getNewPointOfServiceTitcketsTest() {

        FeatureFlag__c featureFlagObj = new FeatureFlag__c();
        featureFlagObj.Name = 'SSMUseServiceTicketObject';
        featureFlagObj.Application__c = 'SSMUseServiceTicketObject';
        featureFlagObj.Active__c = true;

        insert featureFlagObj;

        User userTest = [
            SELECT id 
            FROM User 
            WHERE UserName = 'ssmgssvssf@ssmgssvssf.com' 
            LIMIT 1
        ];

        System.runAs(userTest) {
            Map<String, Object> mapServiceTicketsTest = SSMTicketsController.getPointOfServiceTitckets();

            List<StoreServiceManagerTO.ServiceTicket> ltServiceTickets = 
                (List<StoreServiceManagerTO.ServiceTicket>) mapServiceTicketsTest.get('success');

            System.assertEquals('B0001', ltServiceTickets[0].ticketId);
        }
    }

    @IsTest
    public static void getOldPointOfServiceTitcketsTest() {

        FeatureFlag__c featureFlagObj = new FeatureFlag__c();
        featureFlagObj.Name = 'SSMUseServiceTicketObject';
        featureFlagObj.Application__c = 'SSMUseServiceTicketObject';
        featureFlagObj.Active__c = false;
        
        insert featureFlagObj;

        User userTest = [
            SELECT id 
            FROM User 
            WHERE UserName = 'ssmgssvssf@ssmgssvssf.com' 
            LIMIT 1
        ];

        System.runAs(userTest) {
            Test.startTest();
                Test.setMock(HttpCalloutMock.class, new PointOfServiceTicketsCalloutMock());

                Map<String, Object> mapServiceTicketsTest = SSMTicketsController.getPointOfServiceTitckets();
            Test.stopTest();

            List<StoreServiceManagerTO.ServiceTicket> ltServiceTickets = 
                (List<StoreServiceManagerTO.ServiceTicket>) mapServiceTicketsTest.get('success');

            System.assertNotEquals(0, ltServiceTickets.size());
        }
    }
}