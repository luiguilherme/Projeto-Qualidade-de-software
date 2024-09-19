@isTest
public with sharing class SlaHourControllerTest {
    
    @isTest
    public static void testSLAHour() {
        BusinessHours bh = [SELECT id FROM BusinessHours LIMIT 1];
        Long milissecondsInterval;
        
        Test.startTest();
        milissecondsInterval = SLAHourController.getBusinessHourDiff(bh.Id,  System.now(), System.now().addDays(5));
        Test.stopTest();


        System.assert(milissecondsInterval != null);
    }
}