@IsTest
public with sharing class SenderCaseNotificationScheduleTest {
    @TestSetup
    public static void setup() {   
        Profile profile = [
            SELECT 
                Id, 
                Name 
            FROM 
                Profile 
            WHERE 
                Name LIKE 'Representante' 
            LIMIT 1
        ];
        
        UserRole role = [
            SELECT 
                Id, 
                Name 
            FROM 
                UserRole 
            WHERE 
                DeveloperName LIKE 'AtendimentoGoldOperador' 
            LIMIT 1
        ]; 

        UserRole roleManager = [
            SELECT 
                Id, 
                Name 
            FROM 
                UserRole 
            WHERE 
                DeveloperName LIKE 'AtendimentoGoldAdmProcessos' 
            LIMIT 1
        ];

        User userManagerTest = DataFactory.createUser(profile.Id, roleManager.Id);

        userManagerTest.Email = 'marciol.silva@telefonica.com';

        insert userManagerTest;

        User userTest = DataFactory.createUser(profile.Id, role.Id);

        userTest.ManagerId = userManagerTest.Id;
        
        insert userTest;
        
        System.runAs(userTest) {
            Account accountTest = new Account();
            
            accountTest.Name = 'Validate Test 1';
            accountTest.vlocity_cmt__CustomerValue__c = 'Gold';
            
            insert accountTest; 

            String recType = 'HDE - Gold Processos Escalonamento';
            String recordTypeDeveloperName = Schema.SObjectType.Case.getRecordTypeInfosByName().get(recType).getDeveloperName();
    
            Case caseTest = DataFactory.createCase(recordTypeDeveloperName, 'Test Case #1', 'Case test');
            
            caseTest.Origin = 'HDE';
            caseTest.AccountId = accountTest.Id;
            caseTest.Segment__c = 'Gold';
            caseTest.CustomerServiceReason__c = 'Agenda técnica não cumprida';
            caseTest.ContactPhone__c = '(081)982925763';
            caseTest.CallerPhone__c = '(081)982925763';
            caseTest.Comment__c = 'Caso Gold Test';
            caseTest.Protocol__c = '12345678';
            caseTest.SegmentProduct__c = 'OtherProduct';
            caseTest.HDEOtherProducts__c = 'SIMCard';
            caseTest.CustomerMoodRating__c = 'Não';
            caseTest.CaseComplexityReason__c = 'Motivos de baixa Complexidade';
            caseTest.Status = 'A Iniciar';
            caseTest.OwnerId = userTest.Id;

            insert caseTest;
            
            Id recordTpId = Schema.SObjectType.GeneralSetting__c.getRecordTypeInfosByDeveloperName().get('UserComunicationSetup').getRecordTypeId();
            List<GeneralSetting__c> generalSettings = new List<GeneralSetting__c>{
                new GeneralSetting__c(
                Name = 'ExpiredSLAUserAbove3rd',
                NotificationName__c = 'ExpiredSLAUserAbove3rd',
                NotificationLittleBellToOneCase__c = 'One case bell notification',
                NotificationLittleBellToNCases__c = 'Multiple cases bell notification',
                NotificationEmailToOneCase__c = 'One case email notification',
                NotificationEmailToNCases__c = 'Multiple cases email notification',
                TitleNotificationLittleBellToNCases__c = 'Bell notification title for multiple cases',
                TitleNotificationLittleBellToOneCase__c = 'Bell notification title for one case',
                RecordTypeId = recordTpId),
                new GeneralSetting__c(
                Name = 'RoutingNewOwnerOwner',
                NotificationName__c = 'RoutingNewOwnerOwner',
                NotificationLittleBellToOneCase__c = 'One case bell notification',
                NotificationLittleBellToNCases__c = 'Multiple cases bell notification',
                NotificationEmailToOneCase__c = 'One case email notification',
                NotificationEmailToNCases__c = 'Multiple cases email notification',
                TitleNotificationLittleBellToNCases__c = 'Bell notification title for multiple cases',
                TitleNotificationLittleBellToOneCase__c = 'Bell notification title for one case',
                RecordTypeId = recordTpId)
            }; 
            
            insert generalSettings;
            
        }
    }
    
    @IsTest
    public static void ScheduleSenderNotificationCaseTest() {
        Test.startTest();
            String jobId = System.schedule('ScheduledApexTest',
                '0 0 1 * * ?',
                new SenderCaseNotificationSchedule()
            );
        Test.stopTest();
    }
}