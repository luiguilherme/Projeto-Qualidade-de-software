/* -------------------------------------------------------------------------
* Autor....: Renan S. de Freitas - Deloitte
* Data.....: 21/03/2024
* Objetivo.: Rotina de Expurgos
*  -------------------------------------------------------------------------
* Autor....: Pedro Richtmann - Deloitte
* Data.....: 26/01/2024
* Alteração: Remoção do método updateScheduleTime, responsável pela atualização de data de realização do próximo expurgo; alteração de termo de "frequency" para "retentionPeriod" (API name e label do campo também foram alterados);
* US - Rotina de Expurgos
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
        objPurgeSettingCase.RetentionPeriod__c = 68;
        objPurgeSettingCase.ObjectName__c = 'Case';
        objPurgeSettingCase.RetentionPeriodMeasurementUnit__c = 'Meses';
        Insert objPurgeSettingCase;
        
        system.debug('objPurgeSettingCase: ' + objPurgeSettingCase);
    }
    
    @isTest
    private static void testScheduledJob() 
    {
        PurgeSetting__c objPurgeSetting = [SELECT Id, Name, ObjectName__c FROM PurgeSetting__c WHERE PurgeEnabled__c = TRUE];
        
        system.debug('objPurgeSetting.ObjectName__c: ' + objPurgeSetting.ObjectName__c);
        
        Test.startTest();
        	String jobId = System.schedule('SchedulePurgeRoutinesTest',   '0 0 0 * * ?' , new SchedulePurgeRoutines());
        Test.stopTest();
        
        System.assert(jobId != null, 'Agendamento não foi realizado');
        System.assertEquals(1, [SELECT count() FROM CronTrigger WHERE Id = :jobId]);
    }
}