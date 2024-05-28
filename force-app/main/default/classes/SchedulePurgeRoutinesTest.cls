/* -------------------------------------------------------------------------
* Autor....: Renan S. de Freitas - Deloitte
* Data.....: 21/03/2024
* Objetivo.: Rotina de Expurgos
*  -------------------------------------------------------------------------
*/ 
@isTest
public class SchedulePurgeRoutinesTest 
{
    @TestSetup
    public static void makeData()
    {
        PurgeSetting__c objPurgeSettingCase = new PurgeSetting__c();
        objPurgeSettingCase.Name = 'Cases';
        objPurgeSettingCase.PurgeEnabled__c = true;
        objPurgeSettingCase.Frequency__c = 68;
        objPurgeSettingCase.ObjectName__c = 'Case';
        objPurgeSettingCase.FrequencyMeasurementUnit__c = 'Meses';
        objPurgeSettingCase.SchedulingDate__c = System.now();        
        Insert objPurgeSettingCase;
        
        system.debug('objPurgeSettingCase: ' + objPurgeSettingCase);
    }
    
    @isTest
    private static void testScheduledJob() 
    {
        PurgeSetting__c objPurgeSetting = [SELECT Id, Name, SchedulingDate__c FROM PurgeSetting__c WHERE PurgeEnabled__c = TRUE];
        objPurgeSetting.SchedulingDate__c.addDays(-1);
        update objPurgeSetting;
        
        system.debug('objPurgeSetting.SchedulingDate__c: ' + objPurgeSetting.SchedulingDate__c);
        
        Test.startTest();
        	String jobId = System.schedule('SchedulePurgeRoutinesTest',   '0 0 0 * * ?' , new SchedulePurgeRoutines());
        Test.stopTest();
        
        System.assert(jobId != null, 'Agendamento não foi realizado');
        System.assertEquals(1, [SELECT count() FROM CronTrigger WHERE Id = :jobId]);
    }
}