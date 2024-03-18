@IsTest
public with sharing class SSMAttendantControllerTest {
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
        }
    }

    @IsTest
    public static void getPositionPicklistTest() {
        User userTest = [
            SELECT id 
            FROM User 
            WHERE UserName = 'ssmgssvssf@ssmgssvssf.com' 
            LIMIT 1
        ];

        System.runAs(userTest) {
            Test.startTest();
                Test.setMock(HttpCalloutMock.class, new PointOfServiceCalloutMock());

                Map<String, Object> mapWorkPositionTest = SSMAttendantController.getPositionPicklistValues();
            Test.stopTest();

            List<StoreServiceManagerTO.ItemPicklistValue> ltWorkPosition = 
                (List<StoreServiceManagerTO.ItemPicklistValue>) mapWorkPositionTest.get('workPositionsList');

            System.assertEquals('01', ltWorkPosition[0].value);
        }
    }

    @IsTest
    public static void fetchOperationalInformationsTest() {
        User userTest = [
            SELECT id 
            FROM User 
            WHERE UserName = 'ssmgssvssf@ssmgssvssf.com' 
            LIMIT 1
        ];

        System.runAs(userTest) {
            Test.startTest();
                Test.setMock(HttpCalloutMock.class, new OperationalInformationsCalloutMock());

                Map<String, Object> mapOperationalInformationsTest = SSMAttendantController.fetchOperationalInformations();
            Test.stopTest();

            String jsonOperationalInformations = (String) mapOperationalInformationsTest.get('success');

            StoreServiceManagerResponse.OperationalInformations ltOperationalInformations = (StoreServiceManagerResponse.OperationalInformations) 
                JSON.deserialize(jsonOperationalInformations, StoreServiceManagerResponse.OperationalInformations.class);

            System.assertEquals('2', ltOperationalInformations.attendantPauseOptions[0].id);
            System.assertEquals('1', ltOperationalInformations.businessLines[0].id);
            System.assertEquals('QR1', ltOperationalInformations.quittingReasons[0].id);
            System.assertEquals('705', ltOperationalInformations.interactions[0].id);
        }
    }

    @IsTest
    public static void getPickListAttendantPauseOptionsTest() {
        User userTest = [
            SELECT id 
            FROM User 
            WHERE UserName = 'ssmgssvssf@ssmgssvssf.com' 
            LIMIT 1
        ];

        System.runAs(userTest) {
            Test.startTest();
                Test.setMock(HttpCalloutMock.class, new OperationalInformationsCalloutMock());

                Map<String, Object> mapOperationalInformationsTest = SSMAttendantController.fetchOperationalInformations();
            Test.stopTest();
            
            Map<String, Object> mapAttendantPauseOptionsTest = SSMAttendantController.getPickListAttendantPauseOptions();

            List<StoreServiceManagerTO.ItemPicklistValue> ltAttendantPauseOptions = 
                (List<StoreServiceManagerTO.ItemPicklistValue>) mapAttendantPauseOptionsTest.get('success');

            System.assertEquals('2', ltAttendantPauseOptions[0].value);
        }
    }

    @IsTest
    public static void startServiceTest() {
        User userTest = [
            SELECT id 
            FROM User 
            WHERE UserName = 'ssmgssvssf@ssmgssvssf.com' 
            LIMIT 1
        ];

        System.runAs(userTest) {
            Test.startTest();
                Test.setMock(HttpCalloutMock.class, new UpdateWorkPositionCalloutMock());

                Map<String, Object> mapStartServiceTest = SSMAttendantController.startService('01');
            Test.stopTest();

            System.assertEquals(200, mapStartServiceTest.get('success'));
        }
    }

    @IsTest
    public static void endServiceTest() {
        User userTest = [
            SELECT id 
            FROM User 
            WHERE UserName = 'ssmgssvssf@ssmgssvssf.com' 
            LIMIT 1
        ];

        System.runAs(userTest) {
            Test.startTest();
                Test.setMock(HttpCalloutMock.class, new UpdateWorkPositionCalloutMock());

                Map<String, Object> mapStartServiceTest = SSMAttendantController.endService('01');
            Test.stopTest();

            System.assertEquals(200, mapStartServiceTest.get('success'));
        }
    }

    @IsTest
    public static void pauseServiceTest() {
        User userTest = [
            SELECT id 
            FROM User 
            WHERE UserName = 'ssmgssvssf@ssmgssvssf.com' 
            LIMIT 1
        ];

        System.runAs(userTest) {
            StoreServiceManagerTO.ItemPicklistValue pauseReason = new StoreServiceManagerTO.ItemPicklistValue();
            
            pauseReason.value = '19';
            pauseReason.label = 'Almoco';

            Test.startTest();
                Test.setMock(HttpCalloutMock.class, new PointOfServiceAttendantCalloutMock());

                Map<String, Object> mapPauseServiceTest = SSMAttendantController.pauseService(pauseReason);
            Test.stopTest();

            System.assertEquals(200, mapPauseServiceTest.get('success'));
        }
    }
    
    @IsTest
    public static void resumeServiceTest() {
        User userTest = [
            SELECT id 
            FROM User 
            WHERE UserName = 'ssmgssvssf@ssmgssvssf.com' 
            LIMIT 1
        ];

        System.runAs(userTest) {
            Test.startTest();
                Test.setMock(HttpCalloutMock.class, new PointOfServiceAttendantCalloutMock());

                Map<String, Object> mapResumeServiceTest = SSMAttendantController.resumeService();
            Test.stopTest();

            System.assertEquals(200, mapResumeServiceTest.get('success'));
        }
    }
}
