@IsTest
public with sharing class StoreServiceManagerControllerTest {
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
            GeneralParam__c generalParamTest = new GeneralParam__c(
                ViewFieldServiceStoreService__c = true,
                TimeAutomaticTicketCall__c = 15
            );

            Database.insert(generalParamTest);

            List<GenericOptionsLists__c> ltWorkPositionsTest = new List<GenericOptionsLists__c>();

            for (Integer positionTest = 2; positionTest <= 5; positionTest++) {
                GenericOptionsLists__c newWorkPositionTest = new GenericOptionsLists__c();

                newWorkPositionTest.Name = ('WorkPositions0' + positionTest);
                newWorkPositionTest.Code__c = ('0' + positionTest);
                newWorkPositionTest.Description__c = '0' + positionTest;
                newWorkPositionTest.Description2__c = '';
                newWorkPositionTest.APIName__c = 'PointOfService';
                newWorkPositionTest.APIDateTime__c = Date.today();
                newWorkPositionTest.UsedIn__c = 'WorkPositions';
                newWorkPositionTest.Active__c = true;

                ltWorkPositionsTest.add(newWorkPositionTest);
            }

            GenericOptionsLists__c newReasonPauseTest = new GenericOptionsLists__c();

            newReasonPauseTest.Name = 'AttendantPauseOptions2';
            newReasonPauseTest.Code__c = '2';
            newReasonPauseTest.Description__c = 'Banheiro';
            newReasonPauseTest.Description2__c = '';
            newReasonPauseTest.APIName__c = 'OperationalInformations';
            newReasonPauseTest.APIDateTime__c = Date.today();
            newReasonPauseTest.UsedIn__c = 'AttendantPauseOptions';
            newReasonPauseTest.Active__c = true;

            Database.insert(newReasonPauseTest);

            GenericOptionsLists__c newInteractionTest = new GenericOptionsLists__c();

            newInteractionTest.Name = 'Interactions705';
            newInteractionTest.Code__c = '705';
            newInteractionTest.Description__c = 'Alteração Cadastral - TV';
            newInteractionTest.Description2__c = 'TV';
            newInteractionTest.APIName__c = 'OperationalInformations';
            newInteractionTest.APIDateTime__c = Date.today();
            newInteractionTest.UsedIn__c = 'Interactions';
            newInteractionTest.Active__c = true;

            Database.insert(newInteractionTest);

            GenericOptionsLists__c newCustomerSegmentTest = new GenericOptionsLists__c();

            newCustomerSegmentTest.Name = 'PLATINUM';
            newCustomerSegmentTest.Code__c = 'PLATINUM';
            newCustomerSegmentTest.Description__c = 'PREMIUM';
            newCustomerSegmentTest.Description2__c = '1';
            newCustomerSegmentTest.APIName__c = 'CustomerSegment';
            newCustomerSegmentTest.APIDateTime__c = Date.today();
            newCustomerSegmentTest.UsedIn__c = 'CustomerSegment';
            newCustomerSegmentTest.Active__c = true;

            Database.insert(newCustomerSegmentTest);

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

            ltWebservicesSSM.add(
                new Webservice__c(
                    Name = 'QueueInformationStatusCallout',
                    switchedOn__c = true,
                    Endpoint__c = 'https://api-hml.telefonica.com.br/pointServiceQueueManagement/v1/queueInformation/status/{attendantId}/{pointOfServiceId}',
                    SubscriptionKey__c = '36cfd2713668489bb3f7d23d042be3a3'
                )
            );

            ltWebservicesSSM.add(
                new Webservice__c(
                    Name = 'QueueInformationAttendanceCallout',
                    switchedOn__c = true,
                    Endpoint__c = 'https://api-hml.telefonica.com.br/pointServiceQueueManagement/v1/queueInformation/attendanceInformation/{attendantId}',
                    SubscriptionKey__c = '36cfd2713668489bb3f7d23d042be3a3'
                )
            );

            Database.insert(ltWebservicesSSM);

            ServiceTicket__c ticketTest = new ServiceTicket__c(
                ExternalID__c = 'TICKET_TEST',
                Store__c = '307',
                TicketId__c = 'SSM17',
                Status__c = 'In Service',
                Login__c = 'A024895',
                SpecialNeeds__c = false,
                Priority__c = 2,
                CustomerName__c = 'Cliente Teste',
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
    public static void  hasPermissionSetToAccessTest() {
        User userTest = [
            SELECT id 
            FROM User 
            WHERE UserName = 'ssmgssvssf@ssmgssvssf.com' 
            LIMIT 1
        ];

        System.runAs(userTest) {
            Boolean hasPermissionSetTest = StoreServiceManagerController.hasPermissionSetToAccess();

            System.assertEquals(false, hasPermissionSetTest);
        }
    }

    @IsTest
    public static void  loadStoreServiceManagerTest() {
        User userTest = [
            SELECT id 
            FROM User 
            WHERE UserName = 'ssmgssvssf@ssmgssvssf.com' 
            LIMIT 1
        ];

        System.runAs(userTest) {
            Test.startTest();
                Test.setMock(HttpCalloutMock.class, new PointOfServiceCalloutMock());

                Map<String, Object> mapTest = StoreServiceManagerController.loadStoreServiceManager();
            Test.stopTest();

            User attendant = (User) mapTest.get('attendant');

            System.assertEquals('307', attendant.StoreCode__c);

            Boolean isPartnerCommunityLicenseTest = (Boolean) mapTest.get('partnerCommunityLicense');

            System.assertEquals(false, isPartnerCommunityLicenseTest);
            
            Map<String, Object> mapParamsTest = (Map<String, Object>) mapTest.get('params');

            System.assertEquals(true, mapParamsTest.get('viewFieldService'));
            System.assertEquals(15, mapParamsTest.get('timeAutomaticTicketCall'));
        }
    }

    @IsTest
    public static void fetchPointOfServiceTest() {
        User userTest = [
            SELECT id 
            FROM User 
            WHERE UserName = 'ssmgssvssf@ssmgssvssf.com' 
            LIMIT 1
        ];

        System.runAs(userTest) {
            Test.startTest();
                Test.setMock(HttpCalloutMock.class, new PointOfServiceCalloutMock());

                Map<String, Object> mapPointOfServiceTest = StoreServiceManagerController.fetchPointOfService();
            Test.stopTest();

            String jsonPointOfService = (String) mapPointOfServiceTest.get('success');

            StoreServiceManagerResponse.PointOfService pointOfService = (StoreServiceManagerResponse.PointOfService) 
                JSON.deserialize(jsonPointOfService, StoreServiceManagerResponse.PointOfService.class);

            System.assertEquals('01', pointOfService.workPosition[0].id);
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

                Map<String, Object> mapOperationalInformationsTest = StoreServiceManagerController.fetchOperationalInformations();
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
    public static void fetchInformationStatusTest() {
        User userTest = [
            SELECT id 
            FROM User 
            WHERE UserName = 'ssmgssvssf@ssmgssvssf.com' 
            LIMIT 1
        ];

        System.runAs(userTest) {
            Test.startTest();
                Test.setMock(HttpCalloutMock.class, new QueueInformationStatusCalloutMock());

                Map<String, Object> mapInformationStatusTest = StoreServiceManagerController.fetchInformationStatus();
            Test.stopTest();

            StoreServiceManagerTO.PositionInformationStatus informationStatus = (StoreServiceManagerTO.PositionInformationStatus) 
                mapInformationStatusTest.get('success');

            System.assertEquals('02', informationStatus.workPositionId);
            System.assertEquals('D', informationStatus.statusPosition);
        }
    }

    @IsTest
    public static void fetchInformationAttendanceTest() {
        User userTest = [
            SELECT id 
            FROM User 
            WHERE UserName = 'ssmgssvssf@ssmgssvssf.com' 
            LIMIT 1
        ];

        System.runAs(userTest) {
            Test.startTest();
                Test.setMock(HttpCalloutMock.class, new QueueInformationAttendanceCalloutMock());

                Map<String, Object> mapInformationAttendanceTest = StoreServiceManagerController.fetchInformationAttendance();
            Test.stopTest();

            StoreServiceManagerTO.AttendanceInformationStatus informationAttendance = (StoreServiceManagerTO.AttendanceInformationStatus) 
                mapInformationAttendanceTest.get('success');

            System.assertEquals('SSM17', informationAttendance.ticketId);
            System.assertEquals('2', informationAttendance.statusAttendance);
        }
    }

    @IsTest
    public static void getWorkPositionsPickListTest() {
        User userTest = [
            SELECT id 
            FROM User 
            WHERE UserName = 'ssmgssvssf@ssmgssvssf.com' 
            LIMIT 1
        ];

        System.runAs(userTest) {
            Test.startTest();
                Test.setMock(HttpCalloutMock.class, new PointOfServiceCalloutMock());

                List<StoreServiceManagerTO.ItemPicklistValue> ltWorkPositions = StoreServiceManagerController.getWorkPositionsPickList();
            Test.stopTest();

            System.assertNotEquals(0, ltWorkPositions.size());
        }
    }

    @IsTest
    public static void getAccountCustomerSegmentGSSTest() {
        String CUSTOMER_SEGMENT_PLATINUM_IN = 'PLATINUM';
        String CUSTOMER_SEGMENT_PLATINUM_OUT = '1';
        String CUSTOMER_SEGMENT_NONE_IN = NULL;
        String CUSTOMER_SEGMENT_NONE_OUT = '3';

        StoreServiceManagerTO.ItemPicklistValue segmentPLATINUM = StoreServiceManagerController.getAccountCustomerSegmentGSS(
            CUSTOMER_SEGMENT_PLATINUM_IN
        );

        StoreServiceManagerTO.ItemPicklistValue segmentNONE = StoreServiceManagerController.getAccountCustomerSegmentGSS(
            CUSTOMER_SEGMENT_NONE_IN
        );
        
        System.assertEquals(CUSTOMER_SEGMENT_PLATINUM_OUT, segmentPLATINUM.value);
        System.assertEquals(CUSTOMER_SEGMENT_NONE_OUT, segmentNONE.value);
    }

    @IsTest
    public static void isPartnerCommunityLicenseTest() {
        Boolean test = StoreServiceManagerController.isPartnerCommunityLicense();
    
        System.assertEquals(false, test);
    }

    @IsTest
    public static void  getParamsTest() {
        User userTest = [
            SELECT id 
            FROM User 
            WHERE UserName = 'ssmgssvssf@ssmgssvssf.com' 
            LIMIT 1
        ];

        System.runAs(userTest) {
            Map<String, Object> mapParamsTest = StoreServiceManagerController.getParams();

            System.assertEquals(true, mapParamsTest.get('viewFieldService'));
            System.assertEquals(15, mapParamsTest.get('timeAutomaticTicketCall'));
        }
    }

    @IsTest
    public static void calculateStartTimeTest() {
        String test = StoreServiceManagerController.calculateStartTime('00:30:00');
    
        System.assertNotEquals(null, test);
    }

    @IsTest
    public static void calculateElapsedTimeTest() {
        String startTime = '16:00:00';
        String endTime = '16:30:00';

        Double dElapsedTimeTest = StoreServiceManagerController.calculateElapsedTimeInMilliseconds(startTime, endTime);
        String sElapsedTimeTest = StoreServiceManagerController.calculateElapsedTime(dElapsedTimeTest);
        String elapsedTimeTest = StoreServiceManagerController.calculateElapsedTime(startTime, endTime);
    
        System.assertEquals(1800000.0, dElapsedTimeTest);
        System.assertEquals('00:30:00', sElapsedTimeTest);
        System.assertEquals('00:30:00', elapsedTimeTest);
    }
}
