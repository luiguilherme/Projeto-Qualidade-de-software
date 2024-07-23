/* -------------------------------------------------------------------------
* Autor....: Renan S. de Freitas - Deloitte
* Data.....: 29/01/2024
* Objetivo.: Rotina de Expurgos
*  -------------------------------------------------------------------------
* Autor....: Pedro Richtmann - Deloitte
* Data.....: 26/01/2024
* Alteração: Remoção do método updateScheduleTime, responsável pela atualização de data de realização do próximo expurgo; alteração de termo de "frequency" para "retentionPeriod" (API name e label do campo também foram alterados);
* US - Rotina de Expurgos
*  -------------------------------------------------------------------------
*/ 
@IsTest
public class BatchPurgeRoutinesTest 
{
    @TestSetup
    private static void makeData()
    {
        Integer numVlocityTrackingEntry = 10;
        List<vlocity_cmt__VlocityTrackingEntry__c> lstVlocityTrackingEntry = new List<vlocity_cmt__VlocityTrackingEntry__c>();
        
        for(Integer i=0;i<numVlocityTrackingEntry;i++) 
        {
            vlocity_cmt__VlocityTrackingEntry__c objVlocityTrackingEntry = new vlocity_cmt__VlocityTrackingEntry__c();
            objVlocityTrackingEntry.Name = 'Event Name' + i;
            objVlocityTrackingEntry.vlocity_cmt__Data__c = '{"SalesforceSessionToken":"eacc2f713286fa2ea2994254db7dfb3785218cd3b86b14d62bcbb66593e1bc23abd91efee8a37e53f91777c0385ebca4fb722a60c727be33f3192b3071c5ad27","UserId":"00576000000HvvnAAC","RequestPayload":{"options":{},"contextId":"80176000002HCgYAAW"},"ActionContainerComponent":"IntProc","SoslQueriesTotal":0,"DMLRowsTotal":0,"DMLStatementsTotal":0,"QueriesTotal":1,"QueryRowsTotal":0,"CpuTotal":119,"HeapSizeTotal":37208,"Timestamp":"2024-01-31T04:11:05.967Z","VlocityInteractionToken":"331152b0-9620-6212-4d70-3717d05a06ec","SoslQueriesLimitForAction":0,"DMLRowsLimitForAction":0,"DMLStatementsLimitForAction":0,"QueriesLimitForAction":1,"QueryRowsLimitForAction":0,"CpuLimitForAction":36,"HeapSizeLimitForAction":1111,"StepResult":{"success":false,"result":{"AsyncProcessStatus":null,"code":400,"statusMessage":"An internal Salesforce error has occurred. Please contact the Administrator.","technicalMessage":"[statusCode: 400] statusMessage: No Async Process found with Async ID or Reference ID: 80176000002HCgYAAW. Please check the documentation.","errorCode":400,"error":"An internal Salesforce error has occurred. Please contact the Administrator."}},"ResponseSize":423,"StepDebugInfo":{"Status":false,"Type":"Remote Action","ElapsedTime":521,"ElapsedTimeCPU":31,"Options":{"isExpressionSet":null,"asyncProcessId":"","contextId":"80176000002HCgYAAW","referenceId":""},"Input":{"options":{},"contextId":"80176000002HCgYAAW"}},"RequestSize":47,"actionMessage":"","additionalChainableResponse":{},"additionalInput":{},"additionalOutput":{},"chainOnStep":false,"disOnTplt":false,"executionConditionalFormula":"","failOnStepError":true,"failureConditionalFormula":"","failureResponse":{},"label":"RemoteAction1","remoteClass":"VOIAsyncProcess","remoteMethod":"getAsyncJobStatus","remoteOptions":{"isExpressionSet":null,"asyncProcessId":"","contextId":"80176000002HCgYAAW","referenceId":""},"responseJSONNode":"","responseJSONPath":"","returnOnlyAdditionalOutput":false,"returnOnlyFailureResponse":false,"sendJSONNode":"","sendJSONPath":"","sendOnlyAdditionalInput":false,"show":null,"useFormulas":true,"ElementStepNumber":1,"ElementResult":false,"ElapsedTime":521,"ElementType":"Remote Action","ElementName":"getAsyncJobStatusRA","TrackingEvent":"StepActionTime","OmniScriptSubType":"GetAsyncJobStatus","OmniScriptType":"CPQ","OmniScriptVersion":4,"OmniScriptId":"a307600000065SEAAY","TrackingService":"IntProc"}';
            lstVlocityTrackingEntry.add(objVlocityTrackingEntry);             
        }        
        
        Insert lstVlocityTrackingEntry;
        
        PurgeSetting__c objPurgeSettingCase = new PurgeSetting__c();
        objPurgeSettingCase.Name = 'Cases';
        objPurgeSettingCase.PurgeEnabled__c = true;
        objPurgeSettingCase.RetentionPeriod__c = 68;
        objPurgeSettingCase.ObjectName__c = 'Case';
        objPurgeSettingCase.RetentionPeriodMeasurementUnit__c = 'Meses';
        
        Insert objPurgeSettingCase;
        
        PurgeSetting__c objPurgeSettinTrackingEntries = new PurgeSetting__c();
        objPurgeSettinTrackingEntries.Name = 'Vlocity Tracking Entries';
        objPurgeSettinTrackingEntries.PurgeEnabled__c = true;
        objPurgeSettinTrackingEntries.RetentionPeriod__c = 68;
        objPurgeSettinTrackingEntries.ObjectName__c = 'vlocity_cmt__VlocityTrackingEntry__c';
        objPurgeSettinTrackingEntries.RetentionPeriodMeasurementUnit__c = 'Dias';
        
        Insert objPurgeSettinTrackingEntries;        
    }    
    
    @IsTest
    private static void BatchPurgeRoutinesMesesTest()
    {  
        List<Sobject> lstSobject = [SELECT Id FROM vlocity_cmt__VlocityTrackingEntry__c];   
        PurgeSetting__c objPurgeSetting = [SELECT ID, Name, RetentionPeriodMeasurementUnit__c, RetentionPeriod__c FROM PurgeSetting__c WHERE Name = 'Cases'];
        
        Test.startTest(); 
            BatchPurgeRoutines objBatch = new BatchPurgeRoutines(objPurgeSetting.Name);
            Database.executeBatch(objBatch);
            Database.BatchableContext bc;	
            objBatch.execute(bc, lstSobject);         	
        
        Test.stopTest();
    }
    
    @IsTest
    private static void BatchPurgeRoutinesDiasTest()
    {  
        List<Sobject> lstSobject = [SELECT Id FROM vlocity_cmt__VlocityTrackingEntry__c];   
        PurgeSetting__c objPurgeSetting = [SELECT ID, Name, RetentionPeriodMeasurementUnit__c, RetentionPeriod__c FROM PurgeSetting__c WHERE Name = 'Vlocity Tracking Entries'];
        
        Test.startTest(); 
            BatchPurgeRoutines objBatch = new BatchPurgeRoutines(objPurgeSetting.Name);
            Database.executeBatch(objBatch);
            Database.BatchableContext bc;	
            objBatch.execute(bc, lstSobject);
        
        Test.stopTest();
    }
    
    @IsTest
    private static void BatchPurgeRoutinesFailTest()
    {  
        List<Sobject> lstSobject = [SELECT Id FROM vlocity_cmt__VlocityTrackingEntry__c];
        vlocity_cmt__VlocityTrackingEntry__c objVlocityTrackingEntry = new vlocity_cmt__VlocityTrackingEntry__c();
        objVlocityTrackingEntry.Id = 'a5s76000002cJfeAAE';

        lstSobject.add(objVlocityTrackingEntry);
        PurgeSetting__c objPurgeSetting = [SELECT ID, Name FROM PurgeSetting__c WHERE Name = 'Vlocity Tracking Entries'];
        
        Test.startTest(); 
            BatchPurgeRoutines objBatch = new BatchPurgeRoutines(objPurgeSetting.Name);
            Database.executeBatch(objBatch);
            Database.BatchableContext bc;	
            objBatch.execute(bc, lstSobject);      	
        Test.stopTest();
    } 
}