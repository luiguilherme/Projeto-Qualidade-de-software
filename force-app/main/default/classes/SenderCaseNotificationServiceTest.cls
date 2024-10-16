@IsTest
public class SenderCaseNotificationServiceTest {

    @TestSetup
    static void setupTestData() {

        Id recordTpId = Schema.SObjectType.GeneralSetting__c.getRecordTypeInfosByDeveloperName().get('UserComunicationSetup').getRecordTypeId();
        List<GeneralSetting__c> generalSettings = new List<GeneralSetting__c>{
            new GeneralSetting__c(
            Name = 'CaseOpenedNotification',
            NotificationName__c = 'CaseOpenedNotification',
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
            NotificationLittleBellToOneCase__c = 'One case bell notifications',
            NotificationLittleBellToNCases__c = 'Multiple cases bell notifications',
            NotificationEmailToOneCase__c = 'One case email notifications',
            NotificationEmailToNCases__c = 'Multiple cases email notifications',
            TitleNotificationLittleBellToNCases__c = 'Bell notification title for multiple cases n',
            TitleNotificationLittleBellToOneCase__c = 'Bell notification title for one cases',
            RecordTypeId = recordTpId),
            new GeneralSetting__c(
            Name = 'RoutingNewOwnerOwnerCrítico',
            NotificationName__c = 'RoutingNewOwnerOwnerCrítico',
            NotificationLittleBellToOneCase__c = 'One case bell notificationsC',
            NotificationLittleBellToNCases__c = 'Multiple cases bell notificationsC',
            NotificationEmailToOneCase__c = 'One case email notificationsC',
            NotificationEmailToNCases__c = 'Multiple cases email notificationsC',
            TitleNotificationLittleBellToNCases__c = 'Bell notification title for multiple cases nC',
            TitleNotificationLittleBellToOneCase__c = 'Bell notification title for one caseCs',
            RecordTypeId = recordTpId),
            new GeneralSetting__c(
            Name = 'ExpiredSLAUserAbove3rd',
            NotificationName__c = 'ExpiredSLAUserAbove3rd',
            NotificationLittleBellToOneCase__c = 'One case bell notificationsCx',
            NotificationLittleBellToNCases__c = 'Multiple cases bell notificationsCx',
            NotificationEmailToOneCase__c = 'One case email notificationsCx',
            NotificationEmailToNCases__c = 'Multiple cases email notificationsCx',
            TitleNotificationLittleBellToNCases__c = 'Bell notification title for multiple cases nCx',
            TitleNotificationLittleBellToOneCase__c = 'Bell notification title for one caseCsx',
            RecordTypeId = recordTpId),
            new GeneralSetting__c(
            Name = 'ExpiredSLARoleOuvidoriaAdmPerformance',
            NotificationName__c = 'ExpiredSLARoleOuvidoriaAdmPerformance ',
            NotificationLittleBellToOneCase__c = 'One case bell notificationsCx',
            NotificationLittleBellToNCases__c = 'Multiple cases bell notificationsCx',
            NotificationEmailToOneCase__c = 'One case email notificationsCx',
            NotificationEmailToNCases__c = 'Multiple cases email notificationsCx',
            TitleNotificationLittleBellToNCases__c = 'Bell notification title for multiple cases nCx',
            TitleNotificationLittleBellToOneCase__c = 'Bell notification title for one caseCsx',
            RecordTypeId = recordTpId),
            new GeneralSetting__c(
            Name = 'StatusChangeOwnerAtenção',
            NotificationName__c = 'StatusChangeOwnerAtenção',
            NotificationLittleBellToOneCase__c = 'One case bell notificationsCx',
            NotificationLittleBellToNCases__c = 'Multiple cases bell notificationsCx',
            NotificationEmailToOneCase__c = 'One case email notificationsCx',
            NotificationEmailToNCases__c = 'Multiple cases email notificationsCx',
            TitleNotificationLittleBellToNCases__c = 'Bell notification title for multiple cases nCx',
            TitleNotificationLittleBellToOneCase__c = 'Bell notification title for one caseCsx',
            RecordTypeId = recordTpId),
            new GeneralSetting__c(
            Name = 'StatusChangeUserAbove2ndAtenção',
            NotificationName__c = 'StatusChangeUserAbove2ndAtenção',
            NotificationLittleBellToOneCase__c = 'One case bell notificationsCx',
            NotificationLittleBellToNCases__c = 'Multiple cases bell notificationsCx',
            NotificationEmailToOneCase__c = 'One case email notificationsCx',
            NotificationEmailToNCases__c = 'Multiple cases email notificationsCx',
            TitleNotificationLittleBellToNCases__c = 'Bell notification title for multiple cases nCx',
            TitleNotificationLittleBellToOneCase__c = 'Bell notification title for one caseCsx',
            RecordTypeId = recordTpId)
        };

        insert generalSettings;

        Id userId = UserInfo.getUserId();
        Id recordTypeId = getCaseRecordTypeId('VivoVProcessesEscalation');

        // Insert test Cases
        List<Case> cases = new List<Case>{
            new Case(Status = 'A Iniciar', OwnerId = userId, RecordTypeId = recordTypeId),
            new Case(Status = 'Crítico', OwnerId = userId, RecordTypeId = recordTypeId),
            new Case(Status = 'A Iniciar', OwnerId = userId, RecordTypeId = recordTypeId)
        };
        insert cases;
    }

    static Id getCaseRecordTypeId(String developerName) {
        return Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get(developerName).getRecordTypeId();
    }

  
    @IsTest
    static void testSendOnInsert() {
        List<Case> cases = [SELECT Id, CaseNumber, Status, OwnerId, RecordTypeId FROM Case];

        Test.startTest();
        SenderCaseNotificationService service = new SenderCaseNotificationService();
        
        service.sendOnInsert(cases);
        Test.stopTest();
    }

    @IsTest
    static void testSendOnUpdate() {
        List<Case> cases = [SELECT Id, CaseNumber, Status, OwnerId, RecordTypeId FROM Case];
        Map<Id, Case> oldCases = new Map<Id, Case>([SELECT Id, Status, OwnerId, RecordTypeId FROM Case]);
        
        cases.get(0).Status = 'Atenção';
        update cases;

        Test.startTest();
        SenderCaseNotificationService service = new SenderCaseNotificationService();
        
        service.sendOnUpdate(cases, oldCases);
        Test.stopTest();
    }

    @IsTest
    static void testSendOnFlowScheduled() {
        
        List<SenderCaseNotificationService.NoticationCaseModel> notificationModels = new List<SenderCaseNotificationService.NoticationCaseModel>();
        
        Case testCase = [SELECT Id, CaseNumber, Status,OwnerId, RecordTypeId FROM Case LIMIT 1];
        SenderCaseNotificationService.NoticationCaseModel model = new SenderCaseNotificationService.NoticationCaseModel();
        model.varCase = testCase;
        model.messageType = new List<String>{'CaseOpenedNotification'};
        
        notificationModels.add(model);

        Test.startTest();
        SenderCaseNotificationService.sendOnFlowScheduled(notificationModels);
        Test.stopTest();
    }

    @IsTest
    static void testSendToUsers() {
        
        List<Id> userIds = new List<Id>{ UserInfo.getUserId() };

        Test.startTest();
        SenderCaseNotification service = new SenderCaseNotification();
        service.sendToUsers(userIds);
        Test.stopTest();
    }

    @IsTest
    static void testSendMultipleCases() {
        List<Case> cases = [SELECT Id, CaseNumber, Status, OwnerId FROM Case LIMIT 3];

        Test.startTest();
        SenderCaseNotification sender = new SenderCaseNotification();
        sender.send(cases, 'CaseOpenedNotification', null);
        Test.stopTest();
    }

    @IsTest
    static void testSendStatusRot() {
        List<Case> cases = [SELECT Id, CaseNumber, Status, OwnerId FROM Case LIMIT 3];

        Test.startTest();
        SenderCaseNotificationService senderService = new SenderCaseNotificationService();
        SenderCaseNotification sender = new SenderCaseNotification();
        sender.sendHub(cases, 'ExpiredSLARoleOuvidoriaAdmPerformance', 'notification,Email,formerOwner,Supervisor,RotA,NewA', UserInfo.getUserId());
        Test.stopTest();
    }
    
    @IsTest
    static void testSendHubEmail() {
        List<Case> cases = [SELECT Id, CaseNumber, Status, OwnerId FROM Case LIMIT 1];

        Test.startTest();
        SenderCaseNotification sender = new SenderCaseNotification();

        sender.sendHub(cases, 'CaseOpenedNotification', 'email,NewA', null);
        Test.stopTest();
    }
}