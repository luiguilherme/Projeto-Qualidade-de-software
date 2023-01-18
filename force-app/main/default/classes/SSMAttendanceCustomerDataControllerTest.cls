@IsTest
public with sharing class SSMAttendanceCustomerDataControllerTest {
    @TestSetup
    public static void setup() {
        GenericOptionsLists__c newBusinessLine = new GenericOptionsLists__c();

        newBusinessLine.Name = 'BusinessLines2';
        newBusinessLine.Code__c = '2';
        newBusinessLine.Description__c = 'Fixa';
        newBusinessLine.Description2__c = 'FIXA';
        newBusinessLine.APIName__c = 'OperationalInformations';
        newBusinessLine.APIDateTime__c = Date.today();
        newBusinessLine.UsedIn__c = 'BusinessLines';
        newBusinessLine.Active__c = true;

        Database.insert(newBusinessLine);

        GenericOptionsLists__c newDocumentType = new GenericOptionsLists__c();

        newDocumentType.Name = 'DocumentTypesCPF';
        newDocumentType.Code__c = 'CPF';
        newDocumentType.Description__c = 'CPF';
        newDocumentType.Description2__c = '';
        newDocumentType.APIName__c = 'DocumentTypes';
        newDocumentType.APIDateTime__c = Date.today();
        newDocumentType.UsedIn__c = 'DocumentTypes';
        newDocumentType.Active__c = true;

        Database.insert(newDocumentType);
    }

    @IsTest
    public static void  loadSSMAttendanceCustomerDataTest() {
        Test.startTest();
            Map<String, Object> mapTest = SSMAttendanceCustomerDataController.loadSSMAttendanceCustomerData();
        Test.stopTest();

        System.assertNotEquals(null, mapTest.get('categories'));
        System.assertNotEquals(null, mapTest.get('documentTypes'));
    }
}