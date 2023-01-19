@IsTest
public with sharing class SSMAttendanceEndServiceControllerTest {
    private static final String DOCUMENT_TYPES = 'DocumentTypes';

    @TestSetup
    public static void setup() {
        GenericOptionsLists__c newInteraction = new GenericOptionsLists__c();

        newInteraction.Name = 'Interactions705';
        newInteraction.Code__c = '705';
        newInteraction.Description__c = 'Alteração Cadastral - TV';
        newInteraction.Description2__c = '';
        newInteraction.APIName__c = 'OperationalInformations';
        newInteraction.APIDateTime__c = Date.today();
        newInteraction.UsedIn__c = 'Interactions';
        newInteraction.Active__c = true;

        Database.insert(newInteraction);
    }

    @IsTest
    public static void  loadSSMAttendanceEndServiceTest() {
        Test.startTest();
            Map<String, Object> mapTest = SSMAttendanceEndServiceController.loadSSMAttendanceEndService();
        Test.stopTest();

        System.assertNotEquals(null, mapTest.get('success'));
    }
}